#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"

echo -e "  ==>  $BGgreen$white  ⬇   $nc   $job    $green START $nc"
echo -e "$cyan Current docker images (*-img): $nc"
docker images -a | sed 's/^/  /'
echo
echo -e "$cyan Current docker containers (*-cont): $nc"
docker container ls -a | sed 's/^/  /'
echo
echo -e "$BGyellow Warning $nc this operation will $BGred$white DELETE $nc the following:"
echo -e "    1. $red $2-dev-cont $nc"
echo -e "    2. $red $2-prod-cont $nc"
echo -e "    3. $red $2-dev-img $nc"
echo -e "    4. $red $2-prod-img $nc"
echo -e "But don't worry. "
echo -e "You can recreate them with $yellow yarn d:dev-run $nc and $yellow yarn d:prod-run $nc"
echo -e "$red $bright"
read -p "Are you sure? [y/n]" -n 1 -r
echo -e "$nc"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # echo 'Running:'
  # CMD_TO_RUN="PROJECT_NAME=$2 docker run --rm -p 3000:80 --name $2-dev-cont -it $2-dev-img"
  # echo -e "  $BGgreen$white>$nc $CMD_TO_RUN"
  # echo
  # do job
  echo -e "$yellow Containers: $nc"
  echo -e "$red docker stop $2-dev-cont $nc ==>"
                docker stop $2-dev-cont
  echo -e "$red docker rm   $2-dev-cont $nc ==>"
                docker rm   $2-dev-cont    
  echo -e "$red docker stop $2-prod-cont $nc ==>"
                docker stop $2-prod-cont
  echo -e "$red docker rm   $2-prod-cont $nc ==>"
                docker rm   $2-prod-cont
  echo
  echo -e "$yellow Images: $nc"
  echo -e "$red docker image rm $2-dev-img $nc ==>"
                docker image rm $2-dev-img
  echo -e "$red docker image rm $2-prod-img $nc ==>"
                docker image rm $2-prod-img

  # report
  echo
  echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"

  echo -e "dev container STOPPED!"
  echo -e "Your image and container live on!"
  # echo -e "  ==>  OUTPUT ->  $green $2-dev-img  $nc  into your local docker images"

  echo -e "$yellow Containers: $nc (hopefully none)"
  docker container ls -a | grep -e "$2" -e "CONTAINER" 
  echo -e "$yellow Images: $nc  (hopefully none)"
  docker images -a       | grep -e "$2" -e "REPOSITORY"
  echo
  echo -e "  ==>  $BGmagenta$white NEXT: $nc "
  echo -e "       Recreate them with $yellow yarn d:dev-run $nc and $yellow yarn d:prod-run $nc"
  echo
  echo 
fi



