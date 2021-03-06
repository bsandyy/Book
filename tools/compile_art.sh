#!/bin/bash

SFILE=SConstruct
WORK=/tmp/work

if [ $# -eq 2 ]
then
    ALIAS=$1
    LOCATION=$2
    if [ ! -f $LOCATION ]
    then
        LOCATION=../${LOCATION}/text.md
    fi
    if [ -f $LOCATION ]
    then
        if [ -f $SFILE ]
        then
            touch $WORK
            while [ -f $WORK ]
            do
                time make COLUMNS=$COLUMNS SELECTED="$ALIAS"; red_green_bar.py $? $COLUMNS
                inotifywait $LOCATION
            done
        else
            echo Nie jestem we wlasciwym katalogu, bo tu brak pliku: $SFILE
        fi
    else
        echo No source file: $LOCATION
    fi
else
    echo Podaj linie z pliku z artykulami jako parametry:
    echo 1. alias
    echo 2. sciezka do artykulu
    echo np.:
    echo $0 ros workshops/IPython_Robot_Prototyping
fi
