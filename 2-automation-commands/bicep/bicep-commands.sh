# Adapted from James Tighe's excellent example for using Bicep to deploy AVD
# Find his solution here: https://github.com/jamesatighe/AVD-BICEP

# We are going to use Azure CLI authentication to deploy the Bicep template
# If you aren't already logged in
az login

# Set the subscription you want to deploy to
az account set -s "Your_Subscription_Name"

# Deploy the template to the subscription
az deployment sub create --location "westus" --template-file "main.bicep" \
  --parameters location="westus" prefix="avd" 