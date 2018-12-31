# Overview

**pak-c-mak** is cross-platform tools used as a local package manager for CMake based modules. As a prototype for this tool local maven repository was used. This tool follows git distributed approach, and the concept is to have set of distributed pak-c-mak repositories with many-many CMake module that can be used together.

For example your application is buildup from many-many modules, and for this reason you can create your own git repository to keep package scripts to build application, which you can host on GitHub or use your corporate secured git repo without external access, and when you will need to share buildable environment for you sources, it will be just necessary to add pak-c-mak repo to pak-c-mak build cache and voila everything ready to go.
- **pak-c-mak** effectively can work with multiple repositories, if you've found that somebody already created repository for you, you can just add as many repos as you want.
- **pak-c-mak** have special mode for local development, where packages will be found in your local copy first, and only after that if local copy not found will go and download from the remote git repository.
 
![alt text](readme/pak-c-mak-overview.png "Logo Title Text 1")

## Why was it created

The intention to create this tool is based on research

The intention for this tool is to bring best practices to manage single package repository for cross-platform projects in C++. For such languages like Java, Rust, Python this task already solved. C++ language has longer history than these, and different platform built on C++ evolved independently, as a result there is no single cross-platform package managers, instead around 20 of them which are OS dependent. So the intention for this project is to challenge this  situatiin.

In **Java** enterprise worlds, where web application could be very complex and contains hundreds and sometime up to thousand of transitive dependencies. Java binary executable format already made in that way, so different module's binaries already compatible even if they compiled for different platforms. So it makes possible for Java, to keep central repository for binary artifacts compatible with any platform like Maven central repository. Using java eco system it is easily possible to build an application from single command on the system where only JDK is installed. Commonly adopted build tools Maven and Gradle with support of maven repositories do it all for you. 

In **C++** worlds, CMake is commonly adopted tool for cross-platform module build, however maintaining binary compatibility between artifacts build for different platform on different C++compilere like maven central is tricky thing. For C++ cross-platform development in many situations it is more efficient to keep compatibility on source code level instead, and build all set of binaries for particular platform from source code, instead of creating universal binary one, and for this reason googletest, boost and other suggesting just to download their source coded and keep it somewhere near to your project code and import it from there. It seems that cross-platform central binary repository for Cross C++ will never happen. 
It still possible use deb manager for Ubuntu or vcpkg for Windows, but in this case it will be platform dependent development, so it is not cross-platform anymore.

**pak-c-mak** is simple cross-platform distributed package manager based on **Git** and **CMake**. Git is distributed version control system, on Linux it is just DVCS, while on Windows it is also provides as dependency bash eco system, that is enough to write cross platform scripts for Linux, Unix, Windows, Mac is etc. CMake is already perfectly cool, it can be used to install packages into you OS in cross-platform way. Pak-c-mak is simply set of script that provide single command line interface same for any platform, eliminating usage difference that exists for CLI and scripting on different platforms.

# Features

**pak-c-mak** provides following features:
- **Package manager** for C++ modules and dependencies between them.
- **Local build cache repository** to install built target, decoupled from OS binaries.
- **pak-c-mak repositories**: Git based repository to keep packages and profiles.
- **Profiles** to define different preset for built configuration.
- Two ways of use: 
  - **Distribution mode**: Automated build from remote git repositories. C++ modules are download from remote git repositories.
  - **Development mode**: Used to debug local changes to C++ modules. C++ modules are found on local workstation.

For complete command list please run help command: [pak-c-mak help](commands/pak-c-mak-help)

# Requirements



**pak-c-mak** requires these software installed before starting use of **pak-c-mak**:

- **CMake** - https://cmake.org/
- **Git** - https://git-scm.com/
- **C++ Build Tool** - one of built tool compatible with CMake generators, more info about CMake generators can be found here: https://cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html
  - on ***Windows*** it could be ***MS Visual Studio***
  - on ***Linux*** it could be ***build-essential*** package
- **bash utilities**
  - ***dirname***
  - ***perl***
  - ***sed***

# Supported Platforms

- Windows
- Linux
- OS X [not tested yet]
- BSD Unix [not tested yet]
  
# Examples

**pak-c-mak** example is presented by **pak-c-mak-demo-app**, which have ***googletest*** as third-party dependency, and **pak-c-mak-demo-repo** that contains packages to build **pak-c-mak-demo-app** and ***googletest***.

- **pak-c-mak-demo-repo** - https://github.com/amidukr/pak-c-mak-demo-repo
- **pak-c-mak-demo-app** - https://github.com/amidukr/pak-c-mak-demo-app
- ***googletest*** - is very nice framework for C++ unit testing created by Google, and is used as example of third-party dependency: https://github.com/google/googletest

## Installing pak-c-mak-demo-app

Installing required packages for **pak-c-mak**
```shell
sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install cmake
sudo apt-get -y install build-essential
```

Cloning **pak-c-mak**
```shell
git clone https://github.com/amidukr/pak-c-mak
  Cloning into 'pak-c-mak'...
  ...
```  

Adding **pak-c-mak** demo repository with packages and profiles
```shell
./pak-c-mak/pak-c-mak add-repo pak-c-mak-demo-repo https://github.com/amidukr/pak-c-mak-demo-repo master
```

Verifying if packages are successfully installed.
```shell
./pak-c-mak/pak-c-mak list
  googletest
  pak-c-mak-demo-app
  pak-c-mak-demo-app-with-deps
```

Building and installing googletest
```shell
./pak-c-mak/pak-c-mak install googletest
  Cloning into '/home/vagrant/pak-c-mak-test/pak-c-mak/pak_c_mak_tmp/downloads/packages/googletest'...
  ...
  [100%] Built target gtest_main
  Install the project...
  -- Install configuration: ""
  -- Installing: /home/vagrant/pak-c-mak-test/pak-c-mak/cache/lib/libgmock.a
  -- Installing: /home/vagrant/pak-c-mak-test/pak-c-mak/cache/lib/libgmock_main.a
  ...
```
  
Building and installing **pak-c-mak** demo application
```shell
./pak-c-mak/pak-c-mak install pak-c-mak-demo-app
  Cloning into '/home/vagrant/pak-c-mak-test/pak-c-mak/pak_c_mak_tmp/downloads/packages/pak-c-mak-demo-app'...
  ...
  [100%] Built target pak_c_mak_demo_app_executable
  Install the project...
  -- Install configuration: ""
  -- Installing: /home/vagrant/pak-c-mak/cache/lib/libpak_c_mak_demo_app_library.a
```

Verifying that **pak-c-mak** demo application successfully installed.
```shell
./pak-c-mak/cache/bin/pak_c_mak_demo_app_executable
  MyHoldVariable of MyHolderClass
```
  
## Development Mode

Cloning **pak-c-mak** demo application sources
```shell
git clone https://github.com/amidukr/pak-c-mak-demo-app
  Cloning into 'pak-c-mak-demo-app'...
```

Updating **pak-c-mak** demo application printed text
```shell
vi ./pak-c-mak-demo-app/src/myholderclass.cpp
```

to something like that:
```c++
  #include<myholderclass.hpp>

  const char* MyHolderClass::GetHoldVariable() {
    return "MyHoldVariable of MyHolderClass updated text";
  };
```

Enabling **pak-c-mak** development mode, so package will be searched on local first.
```shell
export PAK_C_MAK_LOCAL_PACKAGES=*
```

Building and installing **pak-c-mak** demo application again
```shell
./pak-c-mak/pak-c-mak install pak-c-mak-demo-app
  Cloning into '/home/vagrant/pak-c-mak-test/pak-c-mak/pak_c_mak_tmp/downloads/packages/pak-c-mak-demo-app'...
  ...
  [100%] Built target pak_c_mak_demo_app_executable
  Install the project...
  -- Install configuration: ""
  -- Installing: /home/vagrant/pak-c-mak/cache/lib/libpak_c_mak_demo_app_library.a
```
  
Verifying that locally changed copy of **pak-c-mak** demo application is installed.
```shell
./pak-c-mak/cache/bin/pak_c_mak_demo_app_executable
  MyHoldVariable of MyHolderClass updated text
```
## Creating pak-c-mak repository

To create your pak-c-mak repository, just simply use [pak-c-mak-demo-repo](https://github.com/amidukr/pak-c-mak-demo-repo) as template for your repository.

## Build using CMake CMAKE_PREFIX_PATH

To access artifacts installed into pak-c-mak cache, CMAKE_PREFIX_PATH variable could be used for CMake based modules. More information about this variable can be found in CMake official documentation.

https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html

To configure CMAKE_PREFIX_PATH variable for using pak-c-mak cache, please use following command:

```shell
source ./pak-c-mak/pak-c-mak-env
```

## Cleaning CMake build cache

Some changes to CMakeLists.txt file may require cleaning of cmake build cache, please use following command:
```shell
./pak-c-mak/pak-c-mak clean-cmake-build
```

# Contribution

If you would like to contribute - any help would be appreciated:
- The platform currently was not tested on OS X and BSD platform, so looking for feedbacks.
- If you've found this tool useful and you are keeping pak-c-mak repositories with your modules, please let know, will keep DB updated with list of public pak-c-mak repositories.
- Project team is open for any suggestions and improvements.

# Contacts
For any question feel free to contact me: **Dmytro Brazhnyk** <<amid.ukr@gmail.com>>
