# Creating an Azure Enterprise Agreement Subscription
To programmatically create an Azure Enterprise Agreement (EA) subscription, some pre-requisites must be met. The codes in this repos will help you meet some of the pre-requisites to prepare you for creation of an EA subscription. 

For more information refer to original [documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-cli#create-subscriptions-under-a-specific-enrollment-account) on Microsoft website.

## Pre-requisites
1- An Azure EA enrollment must exist. If you do not have an EA enrollment.

2- The Enterprise Administrator of your enrollment can make you an Account Owner. Please refer to this [link](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/direct-ea-administration#add-an-account-and-account-owner) for more information on how to do this.

3- You need to create a Service Principal. You must have sufficient permission you require Application.ReadWrite.Allpermission. This permission is available to following roles: 
- Global Administrator
- Application Administrator
- Cloud Application Administrator
- Application Owner
- Directory Writer

Please refer to this [link](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal) for more information on how to create a Service Principal.

4- Account Owner need to grant the right permission to the Service Principal.

## Codes in this repo
This repo contains the following codes:
- *'03 - Create Service Principal.sh'*: This codes creates a Service Principal. You just need to have the right permission as per pre-requisite 3 above.
- *'04 - sub-pre-requisites.sh'*: This code grants the right permission to the Service Principal. You need to be an Account Owner as per pre-requisite 2 above.

## next steps
Once you completed step 3 and 4 you can programmatically create EA subcription using

Option A. [REST, PowerShell, or Azure CLI](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#create-subscriptions-under-a-specific-enrollment-account)

Option B. [Azure Resource Manager template or Bicep](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#use-arm-template-or-bicep)

Option C. [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription)

Option D. [CAF Terraform Modules](https://github.com/aztfmod/terraform-azurerm-caf/tree/main/examples/subscriptions/100-create-subscription)