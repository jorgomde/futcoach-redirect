# update-redirect.ps1
Start-Process ngrok -ArgumentList "http 8080" -NoNewWindow
Start-Sleep -Seconds 5

$response = Invoke-RestMethod -Uri http://127.0.0.1:4040/api/tunnels
$url = $response.tunnels[0].public_url + "/api/"

$redirect = @"
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv='refresh' content='0; url=$url' />
    <title>Redireccionando a backend...</title>
  </head>
  <body>
    <p>Redireccionando a <a href='$url'>$url</a></p>
  </body>
</html>
"@

Set-Content -Path "index.html" -Value $redirect

git add index.html
git commit -m "Update redirect to $url"
git push
