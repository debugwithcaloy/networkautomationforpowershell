# Function to check network connectivity
function Test-NetworkConnectivity {
    param (
        [string]$destination
    )
    
    $result = Test-Connection -ComputerName $destination -Count 1 -Quiet
    if ($result) {
        Write-Output "Network connectivity to $destination is OK."
    } else {
        Write-Output "Network connectivity to $destination is not available."
    }
}

# Function to ping a host
function Ping-Host {
    param (
        [string]$destination
    )
    
    $result = Test-Connection -ComputerName $destination -Count 4
    Write-Output $result
}

# Function to perform a traceroute
function Trace-Route {
    param (
        [string]$destination
    )
    
    $result = Test-NetConnection -TraceRoute $destination
    Write-Output $result
}

# Function to check port connectivity
function Test-PortConnectivity {
    param (
        [string]$destination,
        [int]$port
    )
    
    $result = Test-NetConnection -ComputerName $destination -Port $port
    Write-Output $result
}

# Function to get network interface information
function Get-NetworkInterfaceInfo {
    $result = Get-NetIPAddress | Select-Object -Property InterfaceAlias, IPAddress, PrefixLength, AddressFamily
    Write-Output $result
}

# Function to perform a WHOIS lookup
function Perform-WHOISLookup {
    param (
        [string]$domain
    )
    
    $result = nslookup $domain | Out-String
    Write-Output $result
}

# Function to perform a DNS lookup
function Perform-DNSLookup {
    param (
        [string]$domain
    )
    
    $result = Resolve-DnsName $domain
    Write-Output $result
}

# Function to perform an Nmap scan
function Perform-NmapScan {
    param (
        [string]$destination
    )
    
    $result = nmap -Pn $destination
    Write-Output $result
}

# Main script
Write-Output "Welcome to the Network Automation Script for Windows!"

# Prompt user for destination
$destination = Read-Host "Enter the destination (e.g., hostname or IP address):"

# Test network connectivity
Test-NetworkConnectivity $destination

# Ping the destination
Ping-Host $destination

# Perform a traceroute
Trace-Route $destination

# Prompt user for port to test
$port = Read-Host "Enter the port number to test connectivity:"

# Test port connectivity
Test-PortConnectivity $destination $port

# Get network interface information
Get-NetworkInterfaceInfo

# Prompt user for domain for WHOIS and DNS lookup
$domain = Read-Host "Enter the domain for WHOIS and DNS lookup:"

# Perform WHOIS lookup
Perform-WHOISLookup $domain

# Perform DNS lookup
Perform-DNSLookup $domain

# Prompt user for destination for Nmap scan
$nmapDestination = Read-Host "Enter the destination for Nmap scan:"

# Perform Nmap scan
Perform-NmapScan $nmapDestination
