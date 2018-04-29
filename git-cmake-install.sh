
if [ "$#" -ne 3 ]; then 
   echo "git-cmake-install <project> <git-url> <git-branch>"; exit 1;
fi

PROJECT=$1
GIT_URL=$2
GIT_BRANCH=$3



INSTALL_UTILS=$(realpath ${BASH_SOURCE%/*})
CMAKE_REPOSITORY_CACHE=$(realpath cache)
mkdir -p "$INSTALL_UTILS/downloads"
source "$INSTALL_UTILS/set-cmake-repo-env.sh"

PROJECT_DOWNLOAD_DIR=$INSTALL_UTILS/downloads/$PROJECT

git clone -b $GIT_BRANCH $GIT_URL "$PROJECT_DOWNLOAD_DIR"
cd "$PROJECT_DOWNLOAD_DIR"
git pull

mkdir -p "$PROJECT_DOWNLOAD_DIR/build"
cd "$PROJECT_DOWNLOAD_DIR/build"
rm -rf *

cmake $CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX="$CMAKE_PREFIX_PATH" ..

cmake --build . --target INSTALL
cmake --build . --config Release --target INSTALL
