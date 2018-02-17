#!/bin/bash

##########################################################
# Create directory full of root ownership/permission files
##########################################################

# Make directory and change directory
mkdir -p "dir_full_of_root_files"
cd ./dir_full_of_root_files

# for loop creating files
for i in `seq 1 10`;
  do
    sudo touch testing_file_${i}.jpg
done

sudo chmod -R 755 .


