
echo "step3-verify.sh"

if [ $(docker ps | grep 'tutum/hello-world' | wc  -l) -lt 1 ];
then
   echo "Merci de faire le docker run correct";
else
  echo "ok"
fi