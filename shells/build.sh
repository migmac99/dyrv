#!/usr/bin/env bash
source shells/term-colors.sh

#prep
nJob="$BGblack$yellow npm run build $nc"
sJob="$BGblack$magenta ./shells/${0##*/} $nc"
job="$nJob ==> $sJob"
echo -e "  ==>  $BGgreen ⬇  $nc   $job    $green START $nc"
echo    '  Will do a vite build to create ./build/ with:'
echo -e "    1.  index.html"
echo -e "    2.  copy of all ./public/ files"
echo -e "    3.  special index_########.html for hashed lockup purposes"
echo -e "$BGgreen$white>$nc cp index.html index_bak.html"
echo -e "$BGgreen$white>$nc cat index.html|grep -v \"_REMOVE_LINE_IN_PROD_\" > index_auth.html"
echo -e "$BGgreen$white>$nc cp index_react.html index.html"
echo -e "$BGgreen$white>$nc tsc"
echo -e "$BGgreen$white>$nc vite build"
echo -e "$BGgreen$white>$nc mv ./build/index.html ./build/index_936353623.html"
echo -e "$BGgreen$white>$nc cp ./index_auth.html ./build/index.html"
echo -e "$BGgreen$white>$nc cp index_auth.html index.html"
echo -e "$BGgreen$white>$nc shx cp index_bak.html index.html"
echo -e "$BGgreen$white>$nc shx cp empty.html ./build/empty.html"
echo -e "$BGgreen$white>$nc rm index_auth.html"
echo -e "$BGgreen$white>$nc rm index_bak.html"
echo -e "$BGgreen$white>$nc find ./build/* -exec du -h {} + | grep \"\\..*\\.\" | grep -v \"DS_Store\""
echo
echo

# do job
cp index.html index_bak.html
cat index.html | grep -v "_REMOVE_LINE_IN_PROD_" > index_auth.html
cp index_react.html index.html
tsc
vite build
mv ./build/index.html ./build/index_936353623.html
cp ./index_auth.html ./build/index.html
cp index_auth.html index.html
shx cp index_bak.html index.html
shx cp empty.html ./build/empty.html
rm index_auth.html
rm index_bak.html
find ./build/* -exec du -h {} + | grep "\..*\." | grep -v "DS_Store"

# report complete
echo -e "\n\n  ==>  $BGgreen$white  ✅  $nc   $job    $green COMPLETE $nc"
echo '  ==>  ./build/ folder contains deploy-ready, minified code.'
echo -e "  ==>   $BGmagenta$white NEXT $nc USE    $yellow npm run serve  $nc  to test the build folder "
echo -e "         with a simple $yellow vite preview $nc node server"
echo 
echo 
