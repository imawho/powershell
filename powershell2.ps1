#install dhcp	
get-windowsfeature dhcp
install-windows feature DHCP - IncludeAllSubFeature - IncludeManagement Tools

#assign DHCP
Add-DhcpServerv4Scope -Name "VLAN1" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -state Active

#find dhcp scope id specs
Get-DhcpServerv4Scope -ScopeId 192.168.1.0

#exclude dhcp range
Add-DhcpServerv4Exclusion Range -ScopeId 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10

#set dhcp server value
Set-DhcpServerv40ptionValue -OptionId 3 -Value 192.168.1.1 -ScopeId 192.168.1.0 -ComputerName DC01.iatek.ca
set-DhcpSeverv4OptionValue -DnsDomain dc01.iatek.ca -IPAddress 192.168.1.200

#Dhcp to dns 
Add-DhcpServerInDC -DnsName DC01.iatek.ca -IPAddress 192.168.1.200

#lease DHCP
Get-DHCPSeverv4Lease -ScopeId192.168.1.0

#remove DHCP
remove-windowsfeature DHCP -IncludeManagementTools

#reserve IP DHCP
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.25 -ClientId "USERMACID" -Description "PC01 reservation"
Get-DhcpServerv4Reservation -ScopeId 192.168.1.0

#release and renew ip address (automatic ip) on a new VM
#sudo dhclient -r
#sudo dhclient -v
#DO NOT PERFORM THIS IN BRIDGED NETWORK ADAPTER
