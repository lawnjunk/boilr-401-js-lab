#!/usr/bin/env bash

# nullglob makes globs return empty string if no matches found
# required for following for loop
shopt -s nullglob

red_bold="$(tput setaf 1)$(tput bold)"
white_bold="$(tput setaf 15)$(tput bold)"
cyan_bold="$(tput setaf 6)$(tput bold)"
reset="$(tput sgr0)"

warn(){
  echo "${red_bold}WARNING:${white_bold}" "$@" "${reset}"
}

notice(){
  echo "${cyan_bold}NOTICE:${white_bold}" "$@" "${reset}"
}

exit_code=0

for submission in ./lab-*;do
  notice "running eslint in directory ${submission}/test"

  eslint --quiet "${submission}"
  if [[ "$?" -eq 1 ]];then 
    warn "eslint failed in directory ${submission}/test"
    exit_code=1
  fi

  mocha "${submission}/test"
  if [[ "$?" -eq 1 ]];then 
    warn "mocha failed in directory ${submission}/test"
    exit_code=1
  fi
done

exit $exit_code

