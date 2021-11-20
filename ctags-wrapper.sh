#!/bin/bash

language=$1
path=$2

current_dir=`/bin/pwd`;
ctags_flags=""
exclude_files=""
#ctags_flags="--c++-kinds=+p --c-kinds=+p"
ctags_flags="$ctags_flags $EXCLUDE_FILES"
local_tags_dir="$HOME/tags"
local_tags_log="log_tags"
tmp_tags="$HOME/tags/tmp_tags.$$";
name=tags

if [ -d "$local_tags_dir" ]; then
    mkdir -p $local_tags_dir
fi

echo "Generating tags for language: $language."
case $language in
    python)
        ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags-py .
        ctags -R --fields=+l --languages=python --python-kinds=-iv --append -f ./tags-py ~/.local/lib
        ;;
    c)
        echo $ctags_flags
        ctags $ctags_flags -o $tmp_tags --append -R /usr/include/;
        ctags $ctags_flags -o $tmp_tags --append -R /usr/local/include/;
        #ctags $ctags_flags -o $tmp_tags --append -R -h +.. /usr/include/c++/; ## TODO can't get it to load C++ headers
        ctags $ctags_flags -o $tmp_tags --append -R -h default $path;
        mv $tmp_tags $current_dir/$name;
        ;;
    *)
        echo "language: $language not handled."
        ;;
esac
