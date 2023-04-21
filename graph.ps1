$tenantId="" #replace with your tenant ID

$authBody=@{
    client_id="" #replace with your client ID
    client_secret="" #replace with your client secret
    scope="https://graph.microsoft.com/.default"
    grant_type="client_credentials"
}

$uri="https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

$accessToken=Invoke-WebRequest -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $authBody -Method Post -ErrorAction Stop

$accessToken=$accessToken.content | ConvertFrom-Json

$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'="Bearer " + $accessToken.access_token
    'ExpiresOn'=$accessToken.expires_in
}

$URLsend = "https://graph.microsoft.com/v1.0/"   #Replace with the Graph API URL that you need


<#
    Now you're ready to use the Graph API
#>

Invoke-RestMethod -Method GET -Uri $URLsend -Headers $authHeader 
