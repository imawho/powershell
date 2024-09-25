import-module servermanager

#Can be change to true /false to protect the OU from being deleted  
New-ADOrganizationalUnit -name "Toronto" -ProtectedFromAccidentalDeletion $true

Get-ADOrganizationalUnit -Filter "name -like 'Toronto'" 
Remove-ADOrganizationalUnit -Identity "OU=Toronto, DC=iatek, DC=ca"

#change paramenters of a OU or users or group with SET 
Set-ADOrganizationalUnit -Identity "Ou-Toronto, DC=iatek,DC=ca"

#Create new group
New-ADGroup -Name "AMG" -GroupCategory Security -GroupScope Global -Path "OU=Toronto,DC=iatek,DC=ca"

#Create new users 
New-ADUser -Name "username" -GivenName "Ionut" - Surname "Anghelache" -DisplayName "Batman" -Path "OU=Toronto,DC=iatek,DC=ca" -SamAccountNameonut" -UserPrincipalName "ionut@iatek.ca" 

#Or make it a bulk

#Add users into a group
Add-ADGroupMember -Identity "AMG" -Members ianghelache

#making smb
New-smbshare -Name "staff" -Fullaccess nima\AMG -path "C:\Users\Administrator\Desktop\Centennial\"

