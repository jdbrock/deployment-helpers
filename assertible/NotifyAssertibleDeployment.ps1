function Notify-AssertibleDeployment {
    param(
        [parameter(Mandatory=$true)][string] $token,
        [parameter(Mandatory=$true)][string] $service,
        [parameter(Mandatory=$true)][string] $environment,
        [parameter(Mandatory=$true)][string] $version,
        [parameter(Mandatory=$true)][string] $sourceRef
    )

    Write-Host "Token: " + $token
    Write-Host "Service: " + $service
    Write-Host "Environment: " + $environment
    Write-Host "Version: " + $version
    Write-Host "SourceRef: " + $sourceRef

    $shortVersion = ($version.Split('-'))[0];

    $body = @{
        "service" = $service
        "environmentName" = $environment
        "version" = $shortVersion
        "ref" = $version
    }

    $jsonBody = $body | ConvertTo-Json

    Invoke-RestMethod -Uri "https://assertible.com/deployments" `
        -Headers @{Authorization = "Basic $token" } `
        -Method Post `
        -Body $jsonBody `
        -ContentType 'application/json'        
}

Set-PSDebug -Trace 1

Notify-AssertibleDeployment -Token "$env:ASSERTIBLE_TOKEN" -Service "$env:ASSERTIBLE_SERVICE" -Environment "$env:ASSERTIBLE_ENV" -Version "$env:BUILD_BUILDNUMBER" -SourceRef "$env:BUILD_SOURCEVERSION"