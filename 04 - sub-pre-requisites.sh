# Log in to the AAD as the Account Owner of Enterprise Agreement
az login --use-device-code --allow-no-subscriptions

# az rest --method get --uri https://management.azure.com/providers/Microsoft.Billing/billingaccounts/?api-version=2020-05-01
# The billing account should be in the form of
# /providers/Microsoft.Billing/billingAccounts/7777777/enrollmentAccounts/666666
enrollmentAccount=$(az rest --method get \
  --uri "https://management.azure.com/providers/Microsoft.Billing/billingaccounts?api-version=2020-05-01" \
  --query "value[?properties.agreementType=='EnterpriseAgreement'].{id:properties.enrollmentAccounts[0].id}" -o tsv)

# Object to delegate the subscription creation role.
# Set the ObjectID of the AAD App SP
# Set the principalID of the MSI
tenantId=$(az account show --query tenantId -o tsv)


# Create a new AAD App Registration
# refer to this link https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app#register-an-application

## grant that service principal the ability to create subscriptions.
# Get the billing role definition id for "Enrollment account subscription creator" role
billing_role_definition_id=$(az rest --method GET --url "https://management.azure.com${enrollmentAccount}/billingRoleDefinitions?api-version=2020-05-01" --query "value[?properties.roleName=='Enrollment account subscription creator'].{id:id}" -o tsv)

# Assign the role to the service principal
az rest --method PUT --url "https://management.azure.com/${enrollmentAccount}/billingRoleAssignments/${spn_obj_id}?api-version=2020-05-01" --body "{\"properties\": {\"principalId\": \"${spn_obj_id}\",\"principalTenantId\": \"${tenantId}\",\"roleDefinitionId\": \"${enrollmentAccount}/billingRoleDefinitions/${billing_role_definition_id}\"}}"


# Login as the principalId and create a subscription to confirm the delegation of permission is effective.
az login --service-principal -u $clientid -p $password --tenant $tenantId --allow-no-subscriptions --output none

##### Important run next step just to test the service principal can create a subscription
# create a subscription to confirm the delegation of permission is effective.
az account alias create \
  --name $subscriptionName \
  --billing-scope "${enrollmentAccount}" \
  --display-name $subscriptionNameDisplayName \
  --workload "Production"
