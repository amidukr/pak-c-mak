export CMAKE_ARGUMENTS="$CMAKE_ARGUMENTS -Dgtest_force_shared_crt=ON"

"$CMAKE_VC_INSTALL_UTILS/git-cmake-install.sh" googletest https://github.com/google/googletest master
