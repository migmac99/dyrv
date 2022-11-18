#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
output1="$green $2-dev-img $nc in your docker images"
output2="$green $2-dev-cont $nc a running container on $cyan http://localhost:1337 $nc"

echo -e "  ==>  $BGgreen$white  ⬇   $nc   $job    $green START $nc"
echo    '  Will create:'
echo -e "    1. $output1"
echo -e "    2. $output2"
echo 'Running:'
CMD_TO_RUN="docker run -p 3000:3000 --name $2-dev-cont -it $2-dev-img"
echo -e "  $BGgreen$white>$nc $CMD_TO_RUN"
echo

PROBLEM="ok"
FIND_IMAGE=$(docker images | grep $2-dev-img)
if [ "$FIND_IMAGE" == "" ]; then
  PROBLEM="IMAGE NOT IN DOCKER"
  echo -e "  $BGyellow Warning $nc $yellow $PROBLEM $nc"
  echo -e "$green Making a dev image now:$nc"
  echo -e "  $BGgreen$white>$nc $CMD_TO_RUN"
  PROJECT_NAME=$2 docker-compose -f docker-compose.yml build
fi

# if [ "$PROBLEM" != "ok" ]; then 
#   echo -e "  $BGred$white ERROR>>> $nc $red $PROBLEM $nc"
#   echo
#   echo -e "  $BGmagenta$white NEXT $nc USE    $yellow npm run d:build $nc  to create $2-dev-img then re-run this"
#   exit
# fi

# Get rid of container that may block this launch 
FIND_CONT=$(docker container ls -a | grep $2-dev-cont)
echo "FIND_CONT= $FIND_CONT"
if [ "$FIND_CONT" != "" ]; then
  echo -e "$yellow Begone rude container that is in my may: $nc"
  echo -e "$red docker stop $2-dev-cont $nc ==>"
                docker stop $2-dev-cont
  echo -e "$red docker rm   $2-dev-cont $nc ==>"
                docker rm   $2-dev-cont
fi

# do job
docker run -p 3000:3000 --name $2-dev-cont -it $2-dev-img

# report
echo
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo -e "dev container STOPPED!"
echo -e "Your image and container live on!"
# echo -e "  ==>  OUTPUT ->  $green $2-dev-img  $nc  into your local docker images"
echo
docker container ls -a | grep -e "-dev-" -e "CONTAINER" 
docker image ls $2-dev-img | sed 's/^/       /'
echo
echo -e "  ==>  $BGmagenta$white NEXT $nc USE    $yellow yarn d:prod-run $nc   to see if this builds for prod"
echo
echo 