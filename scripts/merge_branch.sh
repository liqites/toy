# !/bin/bash
#
DEVELOP_BRANCH="develop"
MASTER_BRANCH="master"
#RAILSDEMO_ROOT=/Users/liqi/projects/personal/toy/railsdemo
#cd $RAILSDEMO_ROOT
APP_ROOT=/Users/liqi/projects/personal/toy
cd $APP_ROOT
CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
echo "Current branch is : $CURRENT_BRANCH"
if [ $CURRENT_BRANCH != $DEVELOP_BRANCH ] ; then
	echo "You are not working on DEVELOP BRANCH --> $DEVELOP_BRANCH !!"
	git checkout $DEVELOP_BRANCH
	CURRENT_BRANCH=$DEVELOP_BRANCH
fi

nothing_commit=$(git status | grep "nothing to commit" )
if [ -z "$nothing_commit" ]
	then
	git add .
	commit_message="auto commit by shell @ $(date)"
	git commit -m "$commit_message"
	echo "Auto commit by script with message ($commit_message)"
	git push origin $CURRENT_BRANCH
else
	echo $nothing_commit
fi

ahead=$(git status | grep "nothing to commit" )
if [ -z "$ahead" ] ; then
	echo "nothing"
else
	git push origin $CURRENT_BRANCH
	echo $ahead
fi

git checkout $MASTER_BRANCH
echo "Merge $CURRENT_BRANCH to $MASTER_BRANCH"
git merge --no-ff $CURRENT_BRANCH --message "Merge branch 'develop'"

nothing_commit=$(git status | grep "nothing to commit" )
echo $nothing_commit
if [ -z "$nothing_commit" ]
	then
	echo $nothing_commit
else
	git push origin $MASTER_BRANCH
fi
git checkout $CURRENT_BRANCH
