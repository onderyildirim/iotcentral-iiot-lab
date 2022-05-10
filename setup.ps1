$location="eastus2"
$vmSize="Standard_B1ms" #"Standard_D3_v2"
#$suffix=(New-Guid).Guid.Replace('-', '').Substring(0, 6).ToLower()
$suffix="111111"
$subscriptionid=""

$resourceGroup="iotcoeehol"
$iotcappname="iotcoee-$($suffix)"
$iotcsubdomain="iotcoee$($suffix)"
$iotcdisplayname="IoT Central OEE HOL"
$devicetemplatefilename="BoltMaker.json"
$devicetemplateid="dtmi:iotcoeehol:BoltMakerV1"

if ($subscriptionid -ne ""){
    az account set -s $subscriptionid
}


az group create --name $resourceGroup --location $location
az extension update --name azure-iot
$appid = $(az iot central app create --name $iotcappname --resource-group $resourceGroup --subdomain $iotcsubdomain --display-name $iotcdisplayname --location $location --sku ST0).applicationId
#az iot central device-template create -n $appid -k "boltmaker2.json" --dtid "dtmi:iotcoeehol:BoltMakerV1"



#$appid = $((az iot central app show --name $iotcappname | Out-String).ToLower() | ConvertFrom-Json).applicationId
#$appid=$((az iot central app show --name "iotcoee-111111" | Out-String).ToLower() | ConvertFrom-Json).applicationId
#appid="4d4e578b-d125-4f14-a7f9-55a276ac0851"

#Invoke-WebRequest -Uri "https://github.com/Azure/iot-central-industrial-OEE/raw/main/setup/BoltMaker.json" -Outfile ".\$($devicetemplatefilename).orig"

#(Get-Content ".\$($devicetemplatefilename).orig") -Replace 'parnellAerospace', 'iotcoeehol' | Set-Content ".\$($devicetemplatefilename)"

#$devicetemplatecontent=(Get-Content ".\$($devicetemplatefilename)").Replace('"','\"')
#$devicetemplatecontent=Get-Content ".\$($devicetemplatefilename)" | ConvertFrom-Json





# az iot central device-template create --app-id $appid --content ".\$($devicetemplatefilename)" --device-template-id $devicetemplateid
# az iot central device-template create --app-id $appid --content $devicetemplatecontent --device-template-id $devicetemplateid


az iot central device-template create -n $appid -k "BoltMakerTemplate.json" --dtid "dtmi:iotcoeehol:BoltMakerV1"

# az iot central device-template show --app-id $appid --dtid "dtmi:iotcoeehol:BoltMakerV1"
# az iot central device-template show --app-id $appid --dtid "edgetemplate"
# az iot central device-template list --app-id $appid






#docker run --rm -it -p 50000:50000 -p 8080:8080 --name opcplc mcr.microsoft.com/iotedge/opc-plc:latest --pn=50000 --autoaccept --sph --sn=5 --sr=10 --st=uint --fn=5 --fr=1 --ft=uint --ctb --scn --lid --lsn --ref --gn=5
# {
#     "Hostname": "opcplc",
#     "Cmd": [
#         "--pn=50000",
#         "--autoaccept",
#         "--sph",
#         "--sn=5",
#         "--sr=10",
#         "--st=uint",
#         "--fn=5",
#         "--fr=1",
#         "--ft=uint",
#         "--ctb",
#         "--scn",
#         "--lid",
#         "--lsn",
#         "--ref",
#         "--gn=5"
#     ],
#     "HostConfig": {
#         "PortBindings": {
#             "50000/tcp": [
#                 {
#                     "HostPort": "50000"
#                 }
#             ],
#             "8080/tcp": [
#                 {
#                     "HostPort": "8080"
#                 }
#             ]
#         }
#     }
# }
