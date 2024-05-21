param appServiceName string = toLower('AppServicePlan-${webAppName}')
param webAppName string = uniqueString(resourceGroup().id) 
param containerRegistryName string = 'acrbz2rqmviaywx4'
param dockerImageNameTag string = 'my-image:latest'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServiceName
  location: resourceGroup().location
  kind: 'linux'
  properties: {
    reserved: true
  }
    sku: {
      name: 'B1'
      tier: 'Basic'
      size: 'B1'
      family: 'B'
    }
  }


resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: webAppName
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: null
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: '${containerRegistryName}.azurecr.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: null
        }
      ]
      linuxFxVersion: 'DOCKER|${containerRegistryName}.azurecr.io:my-image:latest'
    }
    serverFarmId: appServicePlan.id
  }
}

output appServiceUrl string = webApp.properties.siteConfig.appSettings[0].value 
