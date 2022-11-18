#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen$white ⬇  $nc   $job    $green START $nc"
echo    '  Will create:'
echo -e "    1. $2-prod-img         in your local docker images"
echo 'Running:'
echo -e "  $BGgreen$white>$nc docker-compose -f docker-compose.prod.yml build\n\n"
echo

# do job
docker-compose -f docker-compose.prod.yml build

# report
echo
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo -e "  ==>  OUTPUT ->  $green $2-prod-img  $nc  into your local docker images"
echo
docker image ls $2-prod-img | sed 's/^/       /'
echo
echo -e "  ==>  $BGmagenta$white NEXT $nc USE    $yellow npm run d:save-tar $nc   to output a *.tar.gz file"
echo
echo 