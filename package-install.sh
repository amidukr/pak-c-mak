if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then 
   echo "package-install.sh <command> [<package>]"; 
   echo "commnad - can be either list of install";
   echo "  list - enumarate list of available packages";
   echo "  install - installs packages";
   exit 1;
fi

COMMAND=$1
PACKAGE=$2

export CMAKE_VC_INSTALL_UTILS=$(realpath "$(dirname "$BASH_SOURCE")")

if [ "$COMMAND" = "list" ]; then
  ls -1 "$CMAKE_VC_INSTALL_UTILS/packages/" | perl -wlne 'print $1 if /install-(.*)\.sh/'; 
  exit 0;
fi

if [ "$COMMAND" = "install" ]; then
  "$CMAKE_VC_INSTALL_UTILS/packages/install-$PACKAGE.sh"
  exit 0;
fi
