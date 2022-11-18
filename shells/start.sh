#!/usr/bin/env bash
source shells/term-colors.sh


if [ -f ".env" ]; then
    echo ".env exists."
else 
    echo -e "$BGred$white ==================================== $nc"
    echo -e "$BGred$white  .env does not exist in root folder. $nc"
    echo -e "$red Run this from the root: $nc"
    echo -e "$green  echo 'MAGIC_LOCKUP=XXsome_passwordXX' > .env $nc"
    echo -e "$white  Replace XXsome_passwordXX with the site lockup password you want $nc"
    echo -e "$BGred$white ==================================== $nc"
    exit
fi

source .env

#prep
nJob="$BGblack$yellow npm run start $nc"
sJob="$BGblack$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen ⬇  $nc   $job    $green START $nc"
echo    '  Start local server:'
echo -e "    1.  calculate a token suffix NNNN"
echo -e "    2.  copy index_react.html to index_react_NNNN.html"
echo -e "    3.  run a local server: http://localhost:3000/'"
tok_suffix=`node -e "function hashCode(str){ return (str.split('').reduce((agg, x)=>{  agg = (agg << 5) - agg + x.charCodeAt(0);  return Math.abs(agg & agg) }, 0) )}; console.log(hashCode('$MAGIC_LOCKUP' + '9Z8d*s42fDhi'))"`
echo -e "$BGgreen$white>$nc \$MAGIC_LOCKUP=$MAGIC_LOCKUP"
echo -e "$BGgreen$white>$nc tok_suffix=node -e ""    function hashCode(str){ return (str.split('').reduce((agg, x)=>{  agg = (agg << 5) - agg + x.charCodeAt(0);  return Math.abs(agg & agg) }, 0) )}; console.log(hashCode('\$MAGIC_LOCKUP' + '9Z8d*s42fDhi'))"""
echo -e "$BGgreen$white>$nc cp index_react.html to index_react_$tok_suffix.html"
echo -e "$BGgreen$white>$nc vite --host 0.0.0.0 --port 3000"
echo

# do job
cp index_react.html index_react_$tok_suffix.html
vite --host 0.0.0.0 --port 3000

# report complete
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo '  ==>  DONE. local server shut down!!!'
echo -e "  ==>   $BGmagenta$white NEXT $nc USE    $yellow npm run build  $nc  to make a production deployable build folder"
echo 
