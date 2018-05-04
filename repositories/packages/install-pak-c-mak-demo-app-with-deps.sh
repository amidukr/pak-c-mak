function pak-install {
    set -e
	 
    "$PAK_C_MAK_PATH/pak-c-mak" install googletest
	"$PAK_C_MAK_PATH/pak-c-mak" install pak-c-mak-demo-app
}
