# Implement-an-AVD-Infrastructure

Exercise files to accompany my Pluralsight course

## Prerequisites

I really do hope you'll follow along and gain some hands on experience with AVD. Here are the prerequisites you'll need in place to use the exercise files:

* Azure CLI
* PowerShell 7.1+
* Terraform 1.1+
* Azure subscription
* Azure AD tenant

Check out the details in the README.md for the `1-create-domain-controller` directory for more information.

### Terraform? I thought this was a Microsoft certification

I chose to use Terraform for a lot of the deployment for two reasons. First, I have been using Terraform actively for many years now and I am most familiar with it. Could I do the whole thing with ARM templates or PowerShell commands? Sure. But that would have been a tremendous amount of effort, and I honestly don't think it's worth it. Which leads me to reason two, Terraform is becoming the de facto standard for deploying infrastructure in the cloud. Yes, there are folks who prefer to use Bicep or want to hand-craft ARM templates, but when I mentioned on Twitter that I was creating a course for AVD, the first question I got was whether there would be automation with Terraform. That says a lot about what folks are expecting to use!

That being said, you **do not need to know Terraform** to take advantage of the included exercise files. Each directory with a Terraform config includes a README or script file with directions and example commands on how to run Terraform. In particular, the README in the `1-create-domain-controller` directory is pretty detailed and should set you up for success with the rest of the files.

## Assumptions

Most of the scripts assume you are using the `westus` region, since that was the cheapest at the time of recording. But you should be able to update all of them to work with your preferred region.

## COST $ $ $

Resources in Azure are **not free** and as such running through the exercises will cost you money. I recommend shutting down VMs when they are not in use. You can also choose smaller VM sizes or pick a lower tier of storage for the OS disk. Special caution goes for the Azure Firewall deployment, which cannot be "turned off" and runs about $1.25 an hour. Likewise, Azure Bastion is about $0.19 per hour, which is not as bad, but could still rack up some bills if you leave it deployed.
