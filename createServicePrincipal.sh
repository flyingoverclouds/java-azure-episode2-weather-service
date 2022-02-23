#!/bin/sh
# From https://github.com/flyingoverclouds/azure-spring-cloud-training/blob/master/11-configure-ci-cd/README.md 
# Prevents a Git bash issue. Not necessary outside of Windows:
export MSYS_NO_PATHCONV=1

# replace the value with YOUR resource group name
AZ_RESOURCE_GROUP="springcloudtraining2"

# Get the ARM resource ID of the resource group
RESOURCE_ID=$(az group show --name "$AZ_RESOURCE_GROUP" --query id -o tsv)
echo "RESOURCE_ID=$RESOURCE_ID"
# Create a service principal with a Contributor role to the resource group.
SPNAME="sp-$(az spring-cloud list --query '[].name' -o tsv)"
echo "SPNAME=$SPNAME"
az ad sp create-for-rbac --name "${SPNAME}" --role contributor --scopes "$RESOURCE_ID" --sdk-auth
echo
echo ">>>>> ATTENTION : COPY ALL THE JSON IN A GITHUB SECRET NAMED 'AZURE_CREDENTIALS' <<<<<<"