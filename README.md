# Implement-an-AVD-Infrastructure

Welcome to Implementing an Azure Virtual Desktop Infrastructure. These exercise files are meant to accompany my course on Pluralsight. The course was originally developed in May of 2022, using PowerShell version 7.2.2, Azure PowerShell module version 7.5.0, Azure CLI version 2.30.0, and Terraform 1.1.2. All of the exercise files should continue to be valid on the current major version of each platform.

## Using the files

The exercise files are broken up into directories that are called out during the course. There are some things that happen in the portal that are not included in the exercise files, but I have tried to minimize that or replicate it where possible.

The exercises do build on each other to a certain degree, but really the most important directory is `1-create-domain-controller`. That lays down the base configuration used by all the other exercises.

## Prerequisites

I really do hope you'll follow along and gain some hands on experience with AVD. Here are the prerequisites you'll need in place to use the exercise files:

* Azure CLI
* PowerShell 7.1+
* Terraform 1.1+
* Azure subscription
* Azure AD tenant

Check out the details in the [README.md](1-create-domain-controller/README.md) for the `1-create-domain-controller` directory for more information.

### Terraform? I thought this was a Microsoft certification

I chose to use Terraform for a lot of the exercises for two reasons. First, I have been using Terraform actively for many years now and I am most familiar with it. Could I do the whole thing with ARM templates or PowerShell commands? Sure. But that would have been a tremendous amount of effort, and I honestly don't think it's worth it. Which leads me to reason two, Terraform is becoming the de facto standard for deploying infrastructure in the cloud. Yes, there are folks who prefer to use Bicep or want to hand-craft ARM templates, but when I mentioned on Twitter that I was creating a course for AVD, the first question I got was whether there would be automation with Terraform. That says a lot about what folks are expecting to use!

That being said, you **do not need to know Terraform** to take advantage of the included exercise files. Each directory with a Terraform config includes a README or script file with directions and example commands on how to run Terraform. In particular, the README in the `1-create-domain-controller` directory is pretty detailed and should set you up for success with the rest of the files.

## Assumptions

Most of the scripts assume you are using the `westus` region, since that was the cheapest at the time of recording. But you should be able to update all of them to work with your preferred region.

## COST $ $ $

Resources in Azure are **not free** and as such running through the exercises will cost you money. I recommend shutting down VMs when they are not in use. You can also choose smaller VM sizes or pick a lower tier of storage for the OS disk. Special caution goes for the Azure Firewall deployment, which cannot be "turned off" and runs about $1.25 an hour. Likewise, Azure Bastion is about $0.19 per hour, which is not as bad, but could still rack up some bills if you leave it deployed.

## Learning Path

This is just one course in the larger Azure Virtual Desktop learning path to help you know the AVD product better and prepare yourself for the AZ-140 exam. I think studying for a certification is a great way to motivate yourself to learn a technology, but I would also caution you to focus on more than just the exam objectives if you plan to operate AVD in a real-world scenario. While the objectives listed give you a great starting point, I can say from experience that running a VDI service is more about working with end users and less about managing the control plane.

## Conclusion

I hope you enjoy taking this course as much as I did creating it. I'd love to hear feedback and suggestions for revisions. Find me on Twitter ([@ned1313](https://twitter.com/Ned1313)) or drop an issue in this repository. Good luck and happy building!

Ned
