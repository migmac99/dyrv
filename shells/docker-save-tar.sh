#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
output="$green $2-prod-docker-img.tar.gz $nc in your local root folder"

echo -e "  ==>  $BGgreen$white  ⬇   $nc   $job    $green START $nc"
echo    '  Will create:'
echo -e "    1. $output"
echo 'Running:'
echo -e "  $BGgreen$white>$nc docker image save $2-prod-img | gzip > $2-prod-docker-img.tar.gz"
echo

PROBLEM="ok"
FIND_IMAGE=$(docker images | grep $2.app-img)
if [ "$FIND_IMAGE" == "" ]; then
  PROBLEM="IMAGE NOT IN DOCKER"
fi

if [ "$PROBLEM" != "ok" ]; then 
  echo -e "  $BGred$white ERROR>>> $nc $red $PROBLEM $nc"
  exit
fi

# do job
docker image save $2-prod-img | gzip > $2-prod-docker-img.tar.gz

# report
echo -e "  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo -e "  ==>  OUTPUT -> $output"
echo
ls -l $2-prod-docker-img.tar.gz | sed 's/^/       /'
echo
echo -e "  ==>  $BGmagenta$white NEXT $nc "
echo -e "    1.  Delete image  $yellow docker image rm $FILE $nc, then "
echo -e "    2.  $yellow npm run d:load-tar $nc, and then"
echo -e "    3.  $yellow npm run d:run-prod $nc "
echo -e "        ...to test that the tar works, then..."
echo -e "    4.  Send tar to a happy place where it can run free! "
echo
echo 