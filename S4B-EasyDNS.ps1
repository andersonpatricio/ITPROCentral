# S4B-EasyDNS.ps1 
# Script created by Anderson Patricio
# This script will create all entries required for Skype for Business Server 2015
#
# More info: ITPROCentral.com
#

$tmpDomain = $args[0]
$tmpIP = $args[1]
$tmpZone = get-dnsserverzone $tmpDomain -ErrorAction:Silent

If (($tmpzone).ZoneName -eq $null) { 
	write-host 'Creating the Forward Zone' $tmpDomain
	Add-DnsServerPrimaryZone $tmpDomain -ReplicationScope Forest -DynamicUpdate None
	} 

#Adding the DNS entries..
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A admin
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A dialin
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A meet
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A scheduler
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A lyncdiscoverinternal
Add-DnsServerResourceRecord -ZoneName $tmpDomain -IPv4Address $tmpIP -A sip
Add-DnsServerResourceRecord -ZoneName $tmpDomain -Srv -Name _sipinternaltls._tcp -DomainName ("sip." + $tmpDomain) -Port 5061 -Priority 0 -Weight 0 
