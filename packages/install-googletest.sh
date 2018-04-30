export CMAKE_ARGUMENTS="$CMAKE_ARGUMENTS -Dgtest_force_shared_crt=ON"

"$PAK_C_MAK_PATH/git-cmake-install" googletest https://github.com/google/googletest master
