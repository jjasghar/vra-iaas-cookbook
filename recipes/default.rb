#
# Cookbook Name:: vra-iaas-cookbook
# Recipe:: default
#
# TODO: you should add code here ;)
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'iis'
include_recipe 'iis::mod_aspnet45'
include_recipe 'iis::mod_auth_windows'
include_recipe 'iis::mod_isapi'
include_recipe 'java::windows'

## TODO ##
##------------------------------------------------------##
# Configure Java.
# Install 64-bit Java 1.8 or later. Do not use 32-bit.
# Set the JAVA_HOME environment variable to the Java installation folder.
# Verify that %JAVA_HOME%\bin\java.exe is available.
##------------------------------------------------------##


## Windows Service Requirements
# Enable the Distributed Transaction Coordinator (DTC) service. 
# IaaS uses DTC for database transactions and actions such as workflow creation.
windows_service 'MSDTC' do
    action :start
    startup_type :automatic
end

# Start the Secondary Logon Service during installation
# This service may be disabled after IaaS installation
windows_service 'seclogon' do
    action :start
end

## IIS Role Requirements
# Sets the static content section for Default Web Site and root to unlocked
iis_section 'Unlock staticContent of Default Web Site' do
    section 'system.webServer/staticContent'
    site 'Default Web Site'
    action :unlock
end

#Unlock the Windows Authentication Section 
iis_section "Unlock windowsAuthentication of Default Web Site" do 	
    section 'system.webServer/security/authentication/windowsAuthentication' 	
    site 'Default Web Site'
    action :unlock 
end

#Enable Windows Authentication 
iis_config "\"Default Web Site\" -section:system.webServer/security/authentication/windowsAuthentication /enabled:\"True\"" do 	
    action :set 
end

#Disable Anonymous Authentication 
iis_config "\"Default Web Site\" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:\"False\"" do 	
    action :set 
end


## TODO ##
##------------------------------------------------------##
## Add Windows Firewall Port Rules
# Table 2‑4. Incoming Ports
# Port  Protocol    Component                       Comments
# 443   TCP         Manager Service                 Communication with IaaS components and vRealize Automation appliance over HTTPS
# 443   TCP         vRealize Automation appliance   Communication with IaaS components and vRealize Automation appliance over HTTPS
# 443   TCP         Infrastructure Endpoint Hosts   Communication with IaaS components and vRealize Automation appliance over HTTPS. 
#                                                   Typically, 443 is the default communication port for virtual and cloud infrastructure 
#                                                   endpoint hosts, but refer to the documentation provided by your infrastructure 
#                                                   hosts for a full list of default and required ports
# 1433  TCP         SQL Server instance             MSSQL

# Table 2‑5. Outgoing Ports
# Port  Protocol    Component                       Comments
# 53    TCP, UDP    All                             DNS
# 67, 
# 68, 
# 546, 
# 547   TCP, UDP    All                             DHCP
# 123   TCP, UDP    All                             Optional. NTP
# 443   TCP         Manager Service                 Communication with vRealize Automation appliance over HTTPS
# 443   TCP         Distributed Execution Managers  Communication with Manager Service over HTTPS
# 443   TCP         Proxy agents                    Communication with Manager Service and infrastructure endpoint hosts over HTTPS
# 443   TCP         Management Agent                Communication with the vRealize Automation appliance
# 443   TCP         Guest agent                     Communication with Manager Service over HTTPS
#                   Software bootstrap agent
# 1433  TCP         Manager Service Website         MSSQL
# 5480  TCP         All                             Communication with the vRealize Automation appliance.
##------------------------------------------------------##

