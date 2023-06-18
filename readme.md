# Creating an Azure Enterprise Agreement Subscription
To programmatically create an Azure Enterprise Agreement (EA) subscription, some pre-requisites must be met. The codes in this repos will help you meet some of the pre-requisites to prepare you for creation of an EA subscription. 

For more information refer to original [documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-cli#create-subscriptions-under-a-specific-enrollment-account) on Microsoft website.

## Pre-requisites
1- An Azure EA enrollment must exist. If you do not have an EA enrollment.

2- The Enterprise Administrator of your enrollment can make you an Account Owner. Please refer to this [link](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/direct-ea-administration#add-an-account-and-account-owner) for more information on how to do this.

3- You need to create a Service Principal. You must have sufficient Azure AD Permission *Application.ReadWrite.All*. This permission is available to following [Azure AD Built in roles](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference): 
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

  - logs in to Azure. User should have one of the roles highlighted in step 3 above.
  - creates a Service Principal.
  - creates a secret for the Service Principal.

- *'04 - sub-pre-requisites.sh'*: This code grants the right permission to the Service Principal. You need to be an Account Owner as per pre-requisite 2 above.
  - logs in to Azure. User should have one EA Account Owner role.
  - Get's the first available EA Account ID.
  - Grants the right permission (Enrollment account subscription creator) to the Service Principal.
  - Log ins to Azure using the Service Principal credetials.
  - Creates a subscription for validation purposes.

## Next steps: create subscription (not covered in this repo)
Once you completed step 3 and 4 you can programmatically create EA subcription using

Option A. [REST, PowerShell, or Azure CLI](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#create-subscriptions-under-a-specific-enrollment-account)

Option B. [Azure Resource Manager template or Bicep](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#use-arm-template-or-bicep)

Option C. [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription)

Option D. [CAF Terraform Modules](https://github.com/aztfmod/terraform-azurerm-caf/tree/main/examples/subscriptions/100-create-subscription)