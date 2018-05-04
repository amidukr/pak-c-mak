function pak-install {
	set -e
	
	export PAK_C_MAK_CMAKE_ARGUMENTS="$PAK_C_MAK_CMAKE_ARGUMENTS -Dgtest_force_shared_crt=ON"
	
	"$PAK_C_MAK_TOOLS_PATH/git-cmake-install" googletest https://github.com/google/googletest master
	
	export PAK_C_MAK_CMAKE_BUILD_ARGUMENT="$PAK_C_MAK_CMAKE_BUILD_ARGUMENT --config Release"
	"$PAK_C_MAK_TOOLS_PATH/git-cmake-install" googletest https://github.com/google/googletest master
}
