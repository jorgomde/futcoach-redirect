# update-redirect.ps1
Start-Process ngrok -ArgumentList "http 8080" -NoNewWindow
Start-Sleep -Seconds 5

$response = Invoke-RestMethod -Uri http://127.0.0.1:4040/api/tunnels
$url = $response.tunnels[0].public_url + "/api/"

$html = @"
<!DOCTYPE html>
<html>
  <head>
    <title>Backend URL</title>
  </head>
  <body>
    <p id='backend-url'>$url</p>
  </body>
</html>
"@

Set-Content -Path "index.html" -Value $html

git add index.html
git commit -m "Update backend URL to $url"
git push
