#!/bin/bash

echo "Clean the data from cademycode.db? [1/0]"
read cleancontinue

if [ $cleancontinue -eq 1 ]
then
    echo "Cleaning Data"
    python dev/cleanse_data.py
    echo "Done cleaning data"

    dev_version=$(head -n 1 dev/changelog.md)
    prod_version=$(head -n 1 prod/changelog.md)

    read -a splitversion_dev <<< $dev_version
    read -a splitversion_prod <<< $prod_version

    dev_version=${splitversion_dev[1]}
    prod_version=${splitversion_prod[1]}

    if [ $prod_version != $dev_version ]
    then    
        echo "New changes detected. Move files to prod?[1/0]"
        read scriptcontinue
    else
        scriptcontinue=1
    fi
else
    echo "Canceled."
fi

if [ $scriptcontinue -eq 1 ]
then    
    for filename in dev/*
    do 
        if [ $filename == "dev/codemycode.db"] || [$filename == "dev/cleanse_data.py"] || [$filename == "dev/cleanse_db.log"]
        then
            echo "Not copying" $filename
        elif [$filename == "dev/cademycode_cleansed.db"] || [$filename == "dev/cademycode_cleansed.csv"]
        then
            mv $filename prod
            echo "Moving" $filename
        else 
            cp $filename prod
            echo "Copying" $filename
        fi
    done
else
    echo "Canceled."
fi
