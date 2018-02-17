#!/bin/bash

# Change user ownership of files
# of target dir

##########
#functions
##########

checkIfValidPaths() {
  local srcPath="${1}"

  echo ""

  if ! [ -d "${srcPath}" ];
    then
      echo "${srcPath}"" is not a valid source Path!"  
      echo ""
      return 1;
  else
    echo "'""${srcPath}""' is a valid path"
    echo ""
    return 0;
  fi
}

ownership_changer() {
  local targetDir="${1}"
  local userName="${2}"
  local userGroup="${3}"

  sudo chown -Rv "${userName}":"${userGroup}" "${targetDir}"
  sudo chmod -v 644 "${targetDir}"/*
}

prompt_user() {
  local targetDir=$(cd ${1} && pwd)
  local userName=$(id -un)
  local userGroup=$(id -gn)

  echo ""
  echo "This script changes the permissions of all files inside the target directory to 644. "
  echo "It also changes the user and group to the current user and group that ran the ownership_changer.sh script."
  echo ""
  echo "The following will be changed:"
  echo ">>>>>>"
  echo "The current working directory >>> '""${targetDir}""'"
  echo "The current userName >>> '""${userName}""'"
  echo "The current userGroup >>> '""${userGroup}""'"
  echo ""

  read -p "Is that what you want?(y or n) " resp
  echo ""
  case ${resp} in
    [y]* ) checkIfValidPaths "${targetDir}" && ownership_changer "${targetDir}" "${userName}" "${userGroup}";;
    [n]* ) echo "Now exiting..." && exit;;
    *) echo "Not a valid response. Now exiting..."&& exit;;
  esac

  echo ""
}

############################
# Run script
############################

# Else there IS an ARGUMENT supplied
if [ $# -eq 1 ]; then
  if checkIfValidPaths "${1}"; then
    prompt_user "${1}"
  fi
# If there IS NO initial ARGUMENT supplied
else
  echo "Please enter in a valid target path location!!" 
fi
