az login --use-device-code --allow-no-subscriptions

# az ad app create --display-name "${app_display_name}" 
# Create Azure AD app registration
clientid=$(az ad app create --display-name $app_display_name --query appId --output tsv)
objectid=$(az ad app show --id $clientid --query id --output tsv)


# Create Azure AD service principal
az ad sp create --id "${objectid}" --output none
spn_obj_id=$(az ad sp list --display-name $app_display_name --query '[].{appId:id}' --output tsv)

# Create client secret
password=$(az ad sp create-for-rbac --name $app_display_name --years 1 --query password --output tsv)

echo $clientid
echo $objectid
echo $spn_obj_id