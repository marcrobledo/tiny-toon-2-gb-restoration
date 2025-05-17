#!/bin/sh

source_filename='tiny_toon_2_en.gb'
target_filename='tiny_toon_2_en_restored.gb'

if [ -f $target_filename ]; then
    rm $target_filename
fi

cd src
export assemble=1

echo "assembling..."
../rgbds/rgbasm -tiny_toon_2_en_restored.obj main.asm
if [ $? -eq 1 ]
then
    echo "Failed assembling"
    exit 1
fi

echo "linking..."
../rgbds/rgblink -o../roms/$target_filename -O./../roms/$source_filename -n../roms/tiny_toon_2_en_restored.sym tiny_toon_2_en_restored.obj 
if [ $? -eq 1 ]
then
    echo "Failed linking"
    exit 1
fi

echo "fixing..."
../rgbds/rgbfix -p0 -v ../roms/$target_filename
rm tiny_toon_2_en_restored.obj
cd ..
