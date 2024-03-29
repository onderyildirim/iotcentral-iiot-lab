cd ~/iotcentral-iiot-lab 
rgname="iotchol"
regionname="eastus2"
instanceid="$RANDOM"
adxname="{youradx}"
adxrgname="{youradx resource group}"
appname="iotchol-$instanceid"
appid=$(az iot central app show -n $appname  --query applicationId --output tsv)
networkName="iotchol-network-$instanceid"
opcVM="opcdevicevm-$instanceid"
plcVM="plcdevicevm-$instanceid"
adminUserSshPublicKey=$(cat $(readlink -f ~/.ssh/id_rsa.pub))

echo "================= Variables set ==============="
echo "   rgname=$rgname"
echo "   regionname=$regionname"
echo "   instanceid=$instanceid"
echo "   appname=$appname"
echo "   networkName=$networkName"
echo "   opcVM=$opcVM"
echo "   plcVM=$plcVM"
echo "   adminUserSshPublicKey=$adminUserSshPublicKey"
echo "   adxname=$adxname"
echo "   adxrgname=$adxrgname"
echo "=============================================="


