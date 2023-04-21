$tenantId="22809cb4-512e-4048-840f-e3319a8e6159" #replace with your tenant ID

$authBody=@{
    client_id="8f9f420d-606c-4e13-889e-837072dbfb42" #replace with your client ID
    client_secret="6f40f249-7498-4fec-af6e-534667f3da0f" #replace with your client secret
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
