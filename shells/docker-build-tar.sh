#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run d:build-tar $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen ⬇  $nc   $job    $green START $nc"
echo    '  Will create:'
echo -e "    1. $2-web-prod-img         in your local docker images"
echo -e "    2. $2-web-prod-docker-img.tar.gz  in this root folder"
echo -e "$BGgreen$white>$nc docker-compose -f docker-compose.prod.yml build"
echo -e "$BGgreen$white>$nc docker image save $2-prod-img | gzip > $2-web-prod-docker-img.tar.gz\n\n"
echo

# do job
docker-compose -f docker-compose.prod.yml build 
echo
docker image save $2-prod-img | gzip > $2-prod-docker-img.tar.gz
# docker image save Dyrv-web-prod-img | gzip > Dyrv-web-prod-docker-img.tar.gz

# report complete
echo
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo '  ==>  IMAGE BUILT & SAVED AS A *.tar.gz'
echo '       ' $(ls dyrv*)
echo -e "  ==>   $BGmagenta$white NEXT $nc USE    $yellow npm run d:load  $nc  and   $yellow npm run d:run  $nc  to test the cached image"
ls -l dyrv*
echo 
echo 
