Import-Module Azure
$proxy = [System.Net.CredentialCache]::DefaultCredentials
[System.Net.WebRequest]::DefaultWebProxy.Credentials = $proxy
#Login to Azure RM - Use REGULAR IDB Account (it needs proxy)
Add-AzureRMAccount
#Get-AzureRmSubscription
#Set-AzureRmContext -SubscriptionName "Enterprise Dev/Test"
$resourcegroup = "rg-p-pw-paloalto"
New-AzureRmResourceGroup -Name $resourcegroup -Force -Location "East US2"
$rmtem = "C:\dev\azure-applicationgateway-master\azure-applicationgateway-master\azuredeploy.json"
$rmpar = "C:\dev\azure-applicationgateway-master\azure-applicationgateway-master\azureDeploy.parameters.json"

Get-AzureRmMarketplaceTerms -Publisher "paloaltonetworks" -Product "vmseries1" -Name "byol" | Set-AzureRmMarketplaceTerms -Accept

New-AzureRmResourceGroupDeployment -Name $resourcegroup -ResourceGroupName $resourcegroup -TemplateFile $rmtem -DeploymentDebugLogLevel All -TemplateParameterFile $rmpar -Verbose