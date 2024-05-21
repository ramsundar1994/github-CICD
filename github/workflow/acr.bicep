param acrName string = 'acr${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param acrSku string = 'Basic'
resource acrResource 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}

@description('Output the login server property for later use')
output loginServer string = acrResource.properties.loginServer
