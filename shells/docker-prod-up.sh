#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen$white ⬇  $nc   $job    $green START $nc"
echo    '  Once the prod (production) docker container is fully up and running...'
echo -e "  ==>  $BGmagenta$white NEXT $nc  " 
echo -e "       Open   $cyan http://localhost:1337 $nc "
echo -e "       to try prod locally!"
echo -e "  ==>  $BGmagenta$white NEXT $nc   $yellow Press Ctrl-C here $nc to stop this prod server." 
echo    ""
echo 'Running commands:'

CMD_TO_RUN="PROJECT_NAME=$2 docker-compose -p $2-prod---projectname -f docker-compose.prod.yml up"
echo -e "  $BGgreen$white>$nc $CMD_TO_RUN \n\n"


# Get rid of container that may block this launch 
FIND_CONT=$(docker container ls -a | grep $2-prod-cont)
if [ "$FIND_CONT" != "" ]; then
  echo -e "$yellow Begone rude container that is in my may: $nc"
  echo -e "$red docker stop $2-prod-cont $nc ==>"
                docker stop $2-prod-cont
  echo -e "$red docker rm   $2-prod-cont $nc ==>"
                docker rm   $2-prod-cont
fi


# do job
PROJECT_NAME=$2 docker-compose -p $2-prod---projectname -f docker-compose.prod.yml up

# report
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo 'The Prod server is now halted/exited.'
echo "However, it lives on in Docker's chache for startup speed!"
echo 'Both image and container are there. Check Docker Desktop for cleanup if useful.'
echo

echo '--Docker Image:----'
docker image ls $2-prod-img | sed 's/^/   /'
echo '--Docker Container:---'
docker container ls -a | grep -e "$2" -e "CREATED" | sed 's/^/   /'

