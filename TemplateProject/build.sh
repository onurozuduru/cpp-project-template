#!/bin/sh
###############################################################################
#File: build.sh
#
#License: MIT
#
#Copyright (C) 2024 Onur Ozuduru
#
#Follow Me!
#  github: github.com/onurozuduru
###############################################################################

PROJECT_DIR=$(dirname "$(realpath "$0")")
BUILD_DIR="${PROJECT_DIR}/build"

BUILD_TYPE="RelWithDebInfo" # Release|RelWithDebInfo|Debug
WITH_TESTS="OFF"
IS_CLEAN_BULD=""

CMD_CMAKE="cmake"
CMAKE_BUILD_TESTING="-DBUILD_TESTING"
CMAKE_BUILD_TYPE="-DCMAKE_BUILD_TYPE"

CMAKE_SOURCE="-S $PROJECT_DIR"
CMAKE_BUILD="-B $BUILD_DIR"

CMAKE_ADDITIONAL=""

create_build_dir() {
    echo "Creating build directory: ${BUILD_DIR}"
    if [ ! -e "${BUILD_DIR}" ]; then
        mkdir "${BUILD_DIR}"
    fi
}

clean_build_dir() {
    echo "Cleaning build directory: ${BUILD_DIR}"
    if [ -d "${BUILD_DIR}" ]; then
        rm -rf "${BUILD_DIR}"
    fi
}

print_help() {
    printf 'Usage: %s [--build-type <Release|RelWithDebInfo|Debug>] [--clean] [--with-tests] [--cmake-additional-args | -a <ARGUMENTS> ] [--help | -h]\n' "$0"
    printf 'Build this project under directory: %s\n' "${BUILD_DIR}"
    printf '\t--build-type\t\tBuild type <Release|RelWithDebInfo|Debug>. Default: %s \n' "${BUILD_TYPE}"
    printf '\t--clean\t\t\tClean build, remove build directory before building.\n'
    printf '\t--with-tests\t\tBuild with tests.\n'
    printf '\t-a,--additional-args\tAdditonal arguments to pass to CMake. Example: --cmake-additional-args "-t test"\n'
    printf '\t-h,--help\t\tDisplay help.\n'
}

### Get params
# -l long options (--help)
# -o short options (-h)
# : options takes argument (--option1 arg1)
# $@ pass all command line parameters.
set -e
params=$(getopt -l "build-type:,clean,with-tests,additional-args:,help" -o "a:h" -- "$@")

eval set -- "$params"

### Run
while true
do
    case $1 in
        -h|--help)
            print_help
            exit 0
            ;;
        --build-type)
            shift
            BUILD_TYPE="$1"
            ;;
        --clean)
            IS_CLEAN_BULD="YES"
            ;;
        --with-tests)
            WITH_TESTS="ON"
            ;;
        --additional-args|-a)
            shift
            CMAKE_ADDITIONAL="$1"
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

echo "--------------------------------------------------------------------------------"
echo "Script arguments:"
echo "BUILD_TYPE: ${BUILD_TYPE}"
[ -n "${IS_CLEAN_BULD}" ] && echo "IS_CLEAN_BULD: ${IS_CLEAN_BULD}" || echo "IS_CLEAN_BULD: NO"
echo "WITH_TESTS: ${WITH_TESTS}"
echo "Additional arguments: ${CMAKE_ADDITIONAL}"
echo "--------------------------------------------------------------------------------"

if [ -n "${IS_CLEAN_BULD}" ]; then
    clean_build_dir
fi
create_build_dir

CMD_GENERATE_BUILD="${CMD_CMAKE} ${CMAKE_BUILD_TESTING}=${WITH_TESTS} ${CMAKE_BUILD_TYPE}=${BUILD_TYPE} ${CMAKE_ADDITIONAL} ${CMAKE_SOURCE} ${CMAKE_BUILD}"
CMD_BUILD="${CMD_CMAKE} --build ${BUILD_DIR}"

echo "Executing commands:"
echo "GENERATE: ${CMD_GENERATE_BUILD}"
echo "BUILD: ${CMD_BUILD}"
echo "--------------------------------------------------------------------------------"

${CMD_GENERATE_BUILD} && cd "${BUILD_DIR}" && ${CMD_BUILD} && cd

