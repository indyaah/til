til () {
	DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
	CWD=$(pwd)
	cd $TIL_HOME
	BRANCH_NAME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")
	LINK="$1"
	TITLE="$2"
	NOTES="$3"
	CATEGORY="$4"
	FILE="$5"
	git co master
	git pull --rebase
	git co -b "$BRANCH_NAME"
	[[ ! -z "$CATEGORY" ]] && [[ ! -z "$FILE" ]] && mkdir -p "./uploads/$CATEGORY" && cp "$HOME/Downloads/$FILE" "./uploads/$CATEGORY/" && git add "./uploads/$CATEGORY/$FILE" && NOTES="$NOTES<br/><br/>[ARCHIVED ARTICLE](../master/uploads/$CATEGORY/$FILE)"
	echo "8i|$DATE|$LINK|$TITLE|$NOTES|"
	gsed -i "8i|$DATE|$LINK|$TITLE|$NOTES|" README.md
	git add README.md
	git commit -m "Added $1"
	git co master
	git merge $BRANCH_NAME
	git push
	git branch -D "$BRANCH_NAME"
	cd $CWD
}
