# Setting up FSLogix

If you don't want to set up the storage account through the portal, you can do so with the included Terraform configuration. Once the Storage account and file share are created, you'll need to take the following steps:

1. Create a group in Active Directory that will hold your FSLogix users
1. Make sure the group syncs to Azure AD
1. Grant the synced group in Azure AD the proper permissions to the storage account
1. Log into the domain controller and join the storage account to the domain
1. Configure the proper NTFS permissions on the file share
1. Install FSLogix on your session host(s)
1. License your FSLogix users and associate them with the Desktop Application Group that contains the session host(s) with FSLogix

There are two scripts you'll need to complete these tasks. The first one is located in this directory, [`DomainJoinScript.ps1`](DomainJoinScript.ps1). The second installs FSLogix on a session host and is available [here](https://raw.githubusercontent.com/DeanCefola/Azure-WVD/master/PowerShell/FSLogixSetup.ps1).