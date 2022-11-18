#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen$white ⬇  $nc   $job    $green START $nc"
echo    '  Once the dev docker container is fully up and running...'
echo -e "  ==>  $BGmagenta$white NEXT $nc  " 
echo -e "       Open   $cyan http://localhost:3000 $nc "
echo -e "       for hot reload development!"
echo    "             Edit, save & see the live results (volumes magic!)."
echo -e "  ==>  $BGmagenta$white NEXT $nc   $yellow Press Ctrl-C here $nc to stop the dev server." 
echo    ""
echo 'Running commands:'
CMD_TO_RUN="PROJECT_NAME=$2 docker-compose -p $2-dev---projectname up"
echo -e "  $BGgreen$white>$nc $CMD_TO_RUN \n\n"


# Function that will get executed when the user presses Ctrl+C
function handlerAfterCtrlC(){
  # report
  echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
  echo 'The Dev server is now halted/exited.'
  echo "However, it lives on in Docker's chache for startup speed!"
  echo 'Both image and container are there. Check Docker Desktop for cleanup if useful.'
  echo
  echo '--Docker Image:----'
  docker image ls $2-dev-img | sed 's/^/   /'
  echo '--Docker Container:---'
  docker container ls -a | grep -e "$2" -e "CREATED" | sed 's/^/   /'
}

trap handlerAfterCtrlC SIGINT

# Get rid of container that may block this launch 
FIND_CONT=$(docker container ls -a | grep $2-dev-cont)
if [ "$FIND_CONT" != "" ]; then
  echo -e "$yellow Begone rude container that is in my may: $nc"
  echo -e "$red docker stop $2-dev-cont $nc ==>"
                docker stop $2-dev-cont
  echo -e "$red docker rm   $2-dev-cont $nc ==>"
                docker rm   $2-dev-cont
fi

# do job
PROJECT_NAME="$2" docker-compose -p $2-dev---projectname up
# docker-compose -p $2-dev---projectname up
