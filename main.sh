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

managed=()
for project in $projects
do
    if [ $(git_managed $project_root/$project) -eq 1 ];then
        managed+=($project)
    fi
done

echo $managed
