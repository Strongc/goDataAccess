#!/usr/bin/env bash
BASEDIR="`pwd`"
DATA="$BASEDIR/data"
BIN="$BASEDIR/bin"
SPLIT="$BASEDIR/split"
OUTPUT="$BASEDIR/output"
LOG="$BASEDIR/log"
LIMIT=10000

function init() {
    ulimit -n 4000

    rm -rf "$SPLIT"
    rm -rf "$OUTPUT"
    rm -rf "$LOG"
    mkdir -p "$SPLIT"
    mkdir -p "$OUTPUT"
    mkdir -p "$LOG"
}

function split_file()
{
    cd "$SPLIT"
    split -l "$LIMIT" "$1" -d 0
    cd -
}

function logger()
{
    echo -e "`date '+%Y-%m-%d %H:%M:%S'` $1" >> "$2"
}

init
split_file "$DATA/top-1m.txt"
ls $SPLIT | while read filename
do
    logger "Processing $SPLIT/$filename" "$LOG/$filename.log"
    go run "$BIN/spider.go" "$BIN/spider.json" "$SPLIT/$filename" "$OUTPUT/$filename"
    logger "Finished $SPLIT/$filename" "$LOG/$filename.log"
done
