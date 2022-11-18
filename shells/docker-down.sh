#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen$white ⬇  $nc   $job    $green START $nc"
echo    '  Will stop running containers (VMs):'
echo 'Running:'
echo -e "  $BGgreen$white>$nc PROJECT_NAME="$2" docker-compose down --remove-orphans"
echo

# do job
PROJECT_NAME="$2" docker-compose -p $2-prod---projectname -f docker-compose.prod.yml down
PROJECT_NAME="$2" docker-compose -p $2-dev---projectname -f docker-compose.yml down
#  --remove-orphans

# report
echo
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
# echo -e "  ==>  OUTPUT ->  $green $2-prod-img  $nc  into your local docker images"
echo "Report of remaining containers:"
docker container ls -a | grep -e "-dev-img" -e "-prod-img" -e "CONTAINER"
echo
echo -e "  ==>  $BGmagenta$white NEXT $nc USE    $yellow npm run d:save-tar $nc   to output a *.tar.gz file"
echo
echo 