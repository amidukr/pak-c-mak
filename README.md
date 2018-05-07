# Overview

**pak-c-mak** is cross-platform tools used as a local package manager for CMake based modules. As a prototype for this tool local maven repository was used. This tool follows git distributed approach, and the concept is to have set of distributed pak-c-mak repositories with many-many CMake module that can be used together.

For example your application is buildup from many-many modules, and for this reason you can create your own git repository to keep package scripts to build application, which you can host on GitHub or use your corporate secured git repo without external access, and when you will need to share buildable environment for you sources, it will be just necessary to add pak-c-mak repo to pak-c-mak build cache and voila everything ready to go.
- **pak-c-mak** effectively can work with multiple repositories, if you've found that somebody already created repository for you, you can just add as many repos as you want.
- **pak-c-mak** have special mode for local development, where packages will be found in your local copy first, and only after that if local copy not found will go and download from the remote git repository.
 
![alt text](readme/pak-c-mak-overview.png "Logo Title Text 1")

## Why was it created

I have a huge experience in Java, and I wasn't writing anything in C/C++ for a long time since student or school year, and when I've tried to build something cross-platform in C++ with multiple modules, I've found that there are no single cross-platform package managers, instead around 20 of them which are OS dependent, so this project trying to challenge it.

In **Java** enterprise worlds, where web application could be very complex and contains hundreds and sometime up to thousand of transitive dependencies, it is easily possible to build an application from single command on the system where only JDK is installed. Commonly adopted build tools Maven and Gradle do it all for you. 

In **C++** worlds, CMake is commonly adopted tool for cross-platform module build, however maintaining cross-platform repository with binary artifacts like maven central, suitable for different platform it is going to be nightmare, because there are exists so many binary compatibilities issues related to this, some companies even go to pay for Intel C++ compiler with most aggressive optimization strategies which definitely breaks compatibilities with any pre-build binary artifacts with other compiler. However cross-platform compilation built effectively possible, when entire C++ application is built from source codes, and for this reason googletest, boost and other suggesting just to download their source coded and keep it somewhere near to your project code and import it from there. It seems that maven central repository like for Cross Platform binaries in C++ will never happen. Of course, you can use deb manager for Ubuntu or vcpkg for Windows, but in this case, you are sticking to the platform.

**pak-c-mak** is very simple cross-platform distributed package manager based on **Git** and **CMake**. Git is distributed version control system, but if you start working with git, you are getting not only DVCS but for example on Windows you are getting complete bash infrastructure and you can write bash script that will be runnable everywhere where git is installed: Linux, Unix, Windows, MacOS etc. CMake is already perfectly cool, it can be used to install packages into you OS, however:
- On Windows with MSVC, Linux folder structure is quite useless, on Windows MSVC CMake requires additional scripting and arguments for dependencies building and install.
- Installing of googletest was a tricky on Windows, needs to disable some compiler keys and build both Release and Debug binaries, so needs package manager to keep it managed.
- Another case if you are preparing binaries for you embedded device or building a kernel you do not needed to install it into OS right now.

Therefor if there is CMakeLists.txt in C++ folder, it doesn't mean that entire build process has been automated already.

This is what we trying to solve and make it simple.
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
sudo apt-get install git
sudo apt-get install cmake
sudo apt-get install build-essential
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

Verifying if packages successfully installed.
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
