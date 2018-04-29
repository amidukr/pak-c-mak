if [ "$#" -ne 3 ]; then 
   echo "git-cmake-install <project> <git-url> <git-branch>"; exit 1;
fi

PROJECT=$1
GIT_URL=$2
GIT_BRANCH=$3


CMAKE_VC_INSTALL_UTILS=$(realpath "$(dirname "$BASH_SOURCE")")
source "$CMAKE_VC_INSTALL_UTILS/set-cmake-repo-env.sh"

mkdir -p "$CMAKE_VC_INSTALL_UTILS/downloads"


PROJECT_DOWNLOAD_DIR=$CMAKE_VC_INSTALL_UTILS/downloads/$PROJECT

git clone -b $GIT_BRANCH $GIT_URL "$PROJECT_DOWNLOAD_DIR"
cd "$PROJECT_DOWNLOAD_DIR"
git pull

mkdir -p "$PROJECT_DOWNLOAD_DIR/build"
cd "$PROJECT_DOWNLOAD_DIR/build"
rm -rf *

cmake $CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX="$CMAKE_PREFIX_PATH" ..

cmake --build . --target INSTALL
cmake --build . --config Release --target INSTALL
