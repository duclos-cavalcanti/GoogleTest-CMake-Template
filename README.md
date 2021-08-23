# CMake-Template with GoogleTest

## Table of Contents
1. [Introduction](#introduction)
2. [Dependencies](#dependencies)
3. [Installation](#installation)
4. [Usage](#usage)
5. [File Structure](#filestructure)

<a name="introduction"/>

## 1. Introduction
Simple project template that aims: 
1. To write code in `C` that is compiled/built with [CMake](https://cmake.org/).
2. Test the project using [GoogleTest's](http://google.github.io/googletest/) `C++` framework, which is also mantained through `CMake`.
3. Obtain coverage reports of said tests using GNU's `gcov/lcov`.


#### Why `CMake`? 

`CMake` is an open-source, cross platform tool designed to build, test and
package software. Given the multiple tools used in this project, CMake presents itself as
a pleasant solution, since it is easier to maintain larger projects, pull down
dependencies, script different actions and much more while being OS-independent. However
there are other frameworks out there that could do a similar job like `Bazel` and even old
school `Makefiles`.

The central concept of `CMake` is to provide a higher abstraction "language" that one can
script his/hers building process in a very readable and powerful manner. `CMake` will read
the provided "main" script which should always be named `CMakeLists.txt` and be located at
the very top/head directory of the project.

From that script other scripts can be included, run and even functions can be defined.
Dependencies are able to be checked and even pulled and built. This is the case for
`GoogleTest` which provides a `CMakeLists.txt` file at its `master` branch to facilitate
the integration of the project with google's testing framework.

Finally, after all of the `CMake` configuration takes place (through the mentioned scripts), 
`Makefiles` will be generated with custom actions/targets what we specified in our
configuration. This gives us somewhat the flexibility of `Makefiles` but the readability
and maintainability of `CMake` and also a much cleaner environment as `CMake` organizes
the generated files very well all within one place (the build folder). 

#### Why so many folders? 

The general point is to organize the files in a clean manner but also help lessen the
mental effort to know what is where and what should go in which directory.

* Header files go into `include` folders, source files go into `src` folders. 

* Library source files go into the top directory of `lib` and library header files go into `lib/include`. 

    Theoretically, a `lib` folder may not even be needed for a simple use-case, but I placed them
    there to emulate a situation where one may use libraries from various different projects
    and one may want to separate them from the our source files. This may be due to
    organization or even maybe due to these libraries being closed source and having a
    separate folder for them facilitates the git management of said libraries.

    It is also doable to expand the `lib` library to have other subfolders which contains 
    files or even other libraries.

* The `cmake` folders contain `Cmake scripts` that can be included/called upon during `CMake`'s configuration.

* The `bin` folders contain the binaries/executables created during the building of the project.

* In case of the `tests` folder/project there are two special folders:
    * `reports`, subfolders in this directory contain the necessary file to generate and
      visualize our `coverage` and `unit-testing` reports.
    * `mocks`, should contain mock files necessary for specific testing situations.


<a name="dependencies"/>

## 2. Dependencies
* `CMake` 
* `GCC` 
* `Python`
* `gcov` and `lcov`

`GoogleTest` does not need to be installed, CMake will handle that for us.

<a name="installation"/>

## 3. Installation
### Linux
#### Arch-based systems
Python is assumed to already be installed, as well as the `gcc` toolchain.
```sh
sudo pacman -S cmake gcov
```

From the AuR:
```sh
git clone https://aur.archlinux.org/lcov.git 
cd lcov
makepkg -si
```

#### Ubuntu and Debian-based systems
Python is assumed to already be installed, as well as the `gcc` toolchain.
```sh
sudo apt-get install cmake lcov gcov
```

### Mac OS
1. If `Homebrew` is already installed go to `2`, else:
```sh
/bin/bash -c "$(curl -fsSL \
https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. Then:
```
brew install cmake gcc gcovr lcov
```
Python is assumed to already be installed.

### Windows
```
¯\\(°_o)/¯
```

TODO: Complete this.

<a name="usage"/>

## 4. Usage
See [5. File Structure](#filestructure) to be able to have a better visual representation
of the following explanation.

This view is from the project's head directory and is somewhat important to be able to
navigate and use the built-in features. In summary there are two projects here, our *main*
one and the *test* project that provides **unit-testing** for the *main* one.

The main steps in using CMake involves going into the `build` directory, running `cmake ..` for it to start
its configuration using the `CMakeLists.txt` file that should be located in the parent
directory relative to `build`. This can be confirmed both in the head directory of this
project and within the `tests` folder as well. Finally running `make` will hopefully build
our project with no errors. 

These and other steps will be gone into more detail now:

1. **Cloning**
```
git clone https://share.mola.bo:80/ddcavalcanti/GoogleTestTemplate-CMake.git
```
2. **Building the C-Project**
```sh
cd GoogleTestTemplate-CMake
cd build
cmake ..
make
```

3. **Building the Tests Project**
```sh
cd GoogleTestTemplate-CMake
cd tests/build
cmake ..
make
```

4. **Running Tests and Obtaining Tests Report**
```sh
cd GoogleTestTemplate-CMake
cd tests/build
make report
```
The Unit-Testing reports will be located at `tests/reports/test`. From there
one can use his/her favorite browser to point/open the `index.html` file.

4. **Obtaining Coverage Reports**
```sh
cd GoogleTestTemplate-CMake
cd tests/build
make coverage
```
The Coverage reports will be located at `tests/reports/coverage/*`. There will be a 
`src`, `lib`, `total` and `test` folders. Don't worry, unless you want something more specific, just go 
to the `total` folder and use your favorite browser to point to/open the `index.html` file within it.

<a name="filestructure"/>

## File Structure
The project's folder structure is the following:
```
.
├── bin
│   └── gtest-template-test
├── build
│   ├── bin
│   ├── CMakeCache.txt
│   ├── CMakeFiles
│   ├── cmake_install.cmake
│   ├── compile_commands.json
│   ├── googletest-build
│   ├── googletest-download
│   ├── googletest-src
│   ├── lib
│   └── Makefile
├── cmake
│   ├── coverage.cmake
│   ├── gtest-build.cmake
│   ├── gtest-download.cmake
│   └── test.cmake
├── CMakeLists.txt
├── include
├── mocks
├── reports
│   ├── coverage
│   ├── html
│   └── test
├── src
│   ├── hello-test.cc
│   └── main.cc
└── test.py

```
