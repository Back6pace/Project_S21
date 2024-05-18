#!/bin/bash

SUCCESS=0
FAIL=0
DIFF_RES=""
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
BASE="$(tput setaf 7)"

declare -a option=(
    "test_case_cat.txt"
    "-b -e -n -s -t -v test_case_cat.txt"
    "-s test_case_cat.txt"
    "-t test_2_cat.txt"
    "-n test_case_cat.txt"
    "-v test_2_cat.txt"
    "-b test_case_cat.txt"
    "-e test_case_cat.txt"
    "no_file.txt"
    "-n -b test_1_cat.txt"
    "-s -n -e test_case_cat.txt"
    "-n test_1_cat.txt"
    "-n -e test_1_cat.txt"
    "-n test_1_cat.txt test_case_cat.txt"
    "-b -e test_case_cat.txt"
    "-n -e test_case_cat.txt"
    "-s -e test_case_cat.txt"
    "-t -n test_case_cat.txt"
    "-n -s test_case_cat.txt"
    "-n -t test_case_cat.txt"
    "-b -e -n test_case_cat.txt"
    "-b -e -s test_case_cat.txt"
    "-b -e -t test_case_cat.txt"
    "-b -s -v test_case_cat.txt"
    "-e -b -v test_case_cat.txt"
    "-b -e -n -s test_case_cat.txt"
    "-b -n -t -e test_case_cat.txt"
    "-b -t -n -s test_case_cat.txt"
    "-e -b -s -v test_case_cat.txt"
    "-e -s -n -t test_case_cat.txt"
)

testing() {
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_cat $t > test_s21_cat.log
    cat $t > test_sys_cat.log
    DIFF_RES="$(diff -s test_s21_cat.log test_sys_cat.log)"
    RESULT="SUCCESS"
    if [ "$DIFF_RES" == "Files test_s21_cat.log and test_sys_cat.log are identical" ]
    then
      (( SUCCESS++ ))
        RESULT="SUCCESS"
    else
      (( FAIL++ ))
        RESULT="FAIL"
    fi
    echo "[${GREEN}${SUCCESS}${BASE}/${RED}${FAIL}${BASE}] ${GREEN}${RESULT}${BASE} cat $t"
    rm test_s21_cat.log test_sys_cat.log
}

for i in "${option[@]}"
do
    testing $i
done

echo "${GREEN}SUCCESS - ${SUCCESS}"
echo "${RED}FAIL - ${FAIL}"