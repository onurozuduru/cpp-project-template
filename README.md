# cpp-project-template
Project template for c++, includes a build script, example cmake files and [googletest](https://github.com/google/googletest) setup.

![cpp-project-template.gif](https://github.com/onurozuduru/cpp-project-template/assets/2547436/3dd83ecc-a9ce-4942-a1bd-332f8b0715c9)

## Create New Project

`create_cpp_project.sh` copies the template to the given path and sets project name in cmake file.
It is possible to create link to the script under a directory under `$PATH`, by default `$HOME/.local/bin` is used.

```bash
# Give execute permission
chmod +x create_cpp_project

# Link script under ~/.local/bin for convenience
./create_cpp_project.sh --install

# Create new project
create_cpp_project /path/to/new_project
```

## Template Structure

```bash
TemplateProject/
├── .clang-format
├── .gitignore
├── build.sh*
├── CMakeLists.txt
├── exe/
│  ├── CMakeLists.txt
│  ├── include/
│  │  └── logger.h
│  └── source/
│     ├── logger.cpp
│     └── main.cpp
├── libs/
│  ├── CMakeLists.txt
│  └── examplelib/
│     ├── CMakeLists.txt
│     ├── include/
│     │  └── examplelib.h
│     └── source/
│        └── examplelib.cpp
└── test/
   ├── CMakeLists.txt
   └── libs/
      ├── CMakeLists.txt
      └── examplelib/
         └── examplelib_test.cpp
```

## Project Build Script

Each new project includes `build.sh` script to be able to build with CMake.
The script creates a folder named `build` under the project folder and able pass build type and build with or without tests.

