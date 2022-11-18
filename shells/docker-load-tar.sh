#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$yellow npm run $1 $nc"
sJob="$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
FILE="$2-prod-docker-img.tar.gz"
output="$green $FILE $nc loaded into your local docker images"

echo -e "  ==>  $BGgreen$white  ⬇   $nc   $job    $green START $nc"
echo    '  Result will be:'
echo -e "    1. $output"
echo '  Running:'
echo -e "    $BGgreen$white>$nc docker image load -i $FILE"


if [ -f "$FILE" ]; then
  PROBLEM="ok"
else
  PROBLEM="MISSING"
fi
echo "PROBLEM = $PROBLEM"
if [ "$PROBLEM" == "ok" ]; then 
  FILESIZE=$(ls -l $FILE | awk '{print $5}')
  echo "FILESIZE '$FILESIZE'"
  if (( FILESIZE < 5000000)); then 
    PROBLEM="TOO SMALL ($FILESIZE) to be real"
  fi
fi

if [ "$PROBLEM" == "ok" ]; then 
  echo -e "    Check:$green PASS $nc  -  File found and size is $green good $nc ($FILESIZE)"
else
  echo -e "    Check:$BGred$white FAIL! $nc"
  echo -e "    $BGred$white ERROR>>> $BGblack$red file IS $PROBLEM $nc"
  echo -e "    $BGmagenta$white NEXT $nc $yellow npm run d:build-tar $nc to make a $green real $nc docker image $nc"
  exit
fi
echo
echo
# do job
docker image load -i $FILE

# report
echo
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo -e "  ==>  OUTPUT -> $output"
echo
docker images "*prod*" | sed 's/^/       /'
echo
echo -e "  ==>  $BGmagenta$white NEXT $nc USE    $yellow npm run d:run-prod $nc   to output a *.tar.gz file"
echo
echo 
