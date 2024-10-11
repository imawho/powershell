Install-WindowsFeature wds-deployment -includemanagementtools 


#mandatory when No mapping is appear
Get-Service -Name RpcSs | Start-Service
Get-Service -Name RpcLocator | Start-Service
Restart-Service WDSServer

#initilze PXE boot so can push deployment over the network

$wdsUtilResults = wdsutil /initialize-server /remInst:"C:\RemoteInstall"
$wdsUtilResults | select -last 1
#bootloader to start over the network

#create a new Group caleld WIn 10
New-WdsInstallImageGroup -Name "Win10"

Import-WdsBootImage -Path "D:\sources\boot.wim" -newimagename "Win10"



#name of the ISO we have into the BOOT
Get-WindowsImage -imagePath "D:\sources\install.wim" | select Imagename

#pipline the Image so when we import the new image it will refere to the $imagename

$imageName = 'Windows 10 Enterprise Evaluation'

Import-WdsInstallImage -ImageGroup "Win10" -Path "D:\sources\install.wim" -ImageName $imageName



Import-WdsInstallImage -Path "D:\sources\install.wim" -ImageGroup "Win10"