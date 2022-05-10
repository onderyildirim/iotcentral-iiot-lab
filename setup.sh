#slide 1
rgname="iotcoeehol"
regionname="eastus2"

appname="iotcoeehol-$RANDOM"
echo "Your application name is: $appname"


appid = (az iot central app create \
--resource-group $rgname \
--name $appname --sku ST0 --location $regionname \
--subdomain $appname  \
--display-name 'OEE HOL').applicationId


echo "App Id is $appid"
echo "You can now navigate to: https://$appname.azureiotcentral.com/device-templates"

#slide 2

#slide 3
deviceid="asset1"
appid="4d4e578b-d125-4f14-a7f9-55a276ac0851"
appname="iotcoee-111111"

devicetemplate="BoltMaker"

devicetemplateid=($(az iot central device-template list --app-id $appid --compact --query "[?displayName.contains(@, '$devicetemplate')].\"@id\"" -o tsv))

az iot central device create --app-id $appid --device-id $deviceid --template $devicetemplateid

scopeid=($(az iot central device show-credentials --app-id $appid --device-id $deviceid --query "idScope" -o tsv))
devicekey=($(az iot central device show-credentials --app-id $appid --device-id $deviceid --query "symmetricKey.primaryKey" -o tsv))


#slide 4
vmname="iotcholedge-$RANDOM"
vmpassword="Password@12345"

az deployment group create \
  --name $vmname \
  --resource-group $rgname \
  --template-file edgeModuleVMDeploy.json \
  --parameters dnsLabelPrefix="$appname" \
  --parameters adminUsername="azureuser" \
  --parameters adminPassword="$vmpassword" \
  --parameters scopeId="$scopeid" \
  --parameters deviceId="$deviceid" \
  --parameters deviceKey="$devicekey"

echo "You can now navigate to: https://$appname.azureiotcentral.com/devices"