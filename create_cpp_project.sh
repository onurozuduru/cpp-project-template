#!/bin/bash
###############################################################################
#File: create_cpp_project.sh
#
#License: MIT
#
#Copyright (C) 2024 Onur Ozuduru
#
#Follow Me!
#  github: github.com/onurozuduru
###############################################################################

SCRIPT_DIR=$(dirname "$(realpath "$0")")
TEMPLATE_NAME="TemplateProject"
TEMPLATE_DIR="${SCRIPT_DIR}/TemplateProject"
NEW_PROJECT_PATH=""
NEW_PROJECT_NAME=""

IS_INSTALL=""
INSTALL_DIR="${HOME}/.local/bin"

create_link() {
    if [[ -z "${INSTALL_DIR}" ]]; then
        echo "Install location is not specified!"
        exit 1
    fi
    if [[ ! -d "${INSTALL_DIR}" ]]; then
        echo "Install location does not exist: ${INSTALL_DIR}"
        exit 1
    fi
    if [[ ! -w "${INSTALL_DIR}" ]]; then
        echo "Install location, no permission to write: ${INSTALL_DIR}"
        exit 1
    fi

    local target_path
    local link_name
    target_path=$(realpath "$0")
    link_name=$(basename "${target_path}" .sh)

    local link_path="${INSTALL_DIR}/${link_name}"

    echo "Linking ${target_path}->${link_path}"
    ln -s "${target_path}" "${link_path}" && echo "Linked!" || echo "Failed!"
}

create_project() {
    if [[ -z "${NEW_PROJECT_PATH}" ]]; then
        echo "Project path cannot be empty!"
        exit 1
    fi
    if [[ -d "${NEW_PROJECT_PATH}" ]]; then
        echo "Directory already exists: ${NEW_PROJECT_PATH}"
        exit 1
    fi
    NEW_PROJECT_NAME=$(basename "${NEW_PROJECT_PATH}")
    if [[ -z "${NEW_PROJECT_NAME}" ]]; then
        echo "Project name could not be derived from: ${NEW_PROJECT_PATH}"
        exit 1
    fi
    if [[ ! -d "${TEMPLATE_DIR}" ]]; then
        echo "Template does not exist: ${TEMPLATE_DIR}"
        exit 1
    fi

    echo "Creating new project '${NEW_PROJECT_NAME}'"
    cp -r "${TEMPLATE_DIR}" "${NEW_PROJECT_PATH}"
    sed -i "s/${TEMPLATE_NAME}/${NEW_PROJECT_NAME}/g" "${NEW_PROJECT_PATH}/CMakeLists.txt"
    echo "Project created: ${NEW_PROJECT_PATH}"
}

print_help() {
    printf 'Usage: %s <NEW_PROJECT_PATH> [ --install | -i ] [ --install-dir | -d <PATH> ] [ --help | -h ]\n' "$0"
    printf 'Create new CPP project under <NEW_PROJECT_PATH>.\n'
    printf '\t-i,--install\t\tCreate link to this script to use as command. Default location: %s\n' "${INSTALL_DIR}"
    printf '\t-d,--install-dir <PATH>\tUse given path for --install instead of default location.\n'
    printf '\t-h,--help\t\tDisplay help.\n'
}

### Get params
# -l long options (--help)
# -o short options (-h)
# : options takes argument (--option1 arg1)
# $@ pass all command line parameters.
set -e
params=$(getopt -l "install,install-dir:,help" -o "id:h" -- "$@")

eval set -- "$params"

### Run
while true
do
    case $1 in
        -h|--help)
            print_help
            exit 0
            ;;
        -i|--install)
            IS_INSTALL="YES"
            ;;
        -d|--install-dir)
            shift
            INSTALL_DIR="$1"
            ;;
        --)
            shift
            break;;
        *)
            print_help
            exit 0
            ;;
    esac
    shift
done

if [[ -n "${IS_INSTALL}" ]]; then
    create_link
    exit 0
fi

NEW_PROJECT_PATH="$1"
create_project

