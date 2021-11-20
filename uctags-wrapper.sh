#!/bin/bash

language=$1

case $language in
    python)
        echo "Generating tags for $language"
        ctags -R --languages=Python --map-Python=.py -f ./tags-py .
        ctags -R --languages=Python --map-Python=.py --append -f ./tags-py ~/.local/lib/
        ctags -R --languages=Python --map-Python=.py --append -f ./tags-py /usr/lib/python3/dist-packages/botocore/*
        ;;
    *)
        echo "language: $language not handled."
        ;;
esac
