#!/bin/bash

SCRIPT_ROOT="`realpath \"$0\"`"
SCRIPT_ROOT="`dirname \"${SCRIPT_ROOT}\"`"

LIB_ROOT="${SCRIPT_ROOT}/../../_lib"

source "${LIB_ROOT}/colors.sh"

printf "${Bla}Bla\t${BBla}BBla\t${UBla}UBla\t${IBla}IBla\t${BIBla}BIBla\t${On_Bla}On_Bla\t${On_IBla}On_IBla\n"
printf "${Red}Red\t${BRed}BRed\t${URed}URed\t${IRed}IRed\t${BIRed}BIRed\t${On_Red}On_Red\t${On_IRed}On_IRed\n"
printf "${Gre}Gre\t${BGre}BGre\t${UGre}UGre\t${IGre}IGre\t${BIGre}BIGre\t${On_Gre}On_Gre\t${On_IGre}On_IGre\n"
printf "${Yel}Yel\t${BYel}BYel\t${UYel}UYel\t${IYel}IYel\t${BIYel}BIYel\t${On_Yel}On_Yel\t${On_IYel}On_IYel\n"
printf "${Blu}Blu\t${BBlu}BBlu\t${UBlu}UBlu\t${IBlu}IBlu\t${BIBlu}BIBlu\t${On_Blu}On_Blu\t${On_IBlu}On_IBlu\n"
printf "${Pur}Pur\t${BPur}BPur\t${UPur}UPur\t${IPur}IPur\t${BIPur}BIPur\t${On_Pur}On_Pur\t${On_IPur}On_IPur\n"
printf "${Cya}Cya\t${BCya}BCya\t${UCya}UCya\t${ICya}ICya\t${BICya}BICya\t${On_Cya}On_Cya\t${On_ICya}On_ICya\n"
printf "${Whi}Whi\t${BWhi}BWhi\t${UWhi}UWhi\t${IWhi}IWhi\t${BIWhi}BIWhi\t${On_Whi}On_Whi\t${On_IWhi}On_IWhi\n"

printf "${SUCC}SUCC\t${INFO}INFO\t${WARN}WANR\t${ERRO}ERRO\t${FATA}FATA\n"

printf "${RCol}Reset\n"
