#!/bin/zsh


project_root="/home/keitaro/Desktop/projects"
projects=($(ls $project_root))

function echo_red() {
    msg=$1
    echo -e "\e[31m$msg\e[0m"
}

function echo_green() {
    msg=$1
    echo -e "\e[32m$msg\e[0m"
}

function git_managed() {
    target_dir=$1
    if [ -e "$target_dir/.git" ]; then
        echo 1
    else
        echo 0
    fi
}

function diff_exists() {
    target_dir=$1
    cd $target_dir
    diff=$(git diff)
    if [ -z $diff ]; then
        echo 0
    else
        echo 1
    fi
}

function force_commit_push() {
    # 強制的に全ての差分をadd
    # 時間をメッセージにしてコミットする
}

managed=()
not_managed=()
for project in $projects
do
    if [ $(git_managed $project_root/$project) -eq 1 ];then
        managed+=($project)
    else
        not_managed+=($project)
    fi
done

has_diff=()
for project in $managed
do
    if [ $(diff_exists $project_root/$project) -eq 1 ];then
        has_diff+=($project)
    fi
done

echo "Not Managed by GIT and may disappear"
for project in $not_managed
do
    echo_red $project
done

echo "Managed by GIT and has diff"
for project in $has_diff
do
    echo_red $project
done
