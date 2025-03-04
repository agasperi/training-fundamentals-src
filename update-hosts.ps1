# Running with
# PowerShell -ExecutionPolicy Bypass -File .\update-hosts.ps1

$hostsFile = "C:\Windows\System32\drivers\etc\hosts"
$marker = "# FUN host entries"

# Leer el contenido actual
$existingContent = Get-Content $hostsFile | Where-Object { $_ -notmatch "ksqldb-server" }

# Verificar si ya existe la entrada
if ($existingContent -contains $marker) {
    Write-Output "Already done!"
    exit 0
}

# Agregar las nuevas entradas
$entries = @"
$marker
127.0.0.1 kafka
127.0.0.1 zookeeper
127.0.0.1 schema-registry
127.0.0.1 connect
127.0.0.1 ksqldb-server
127.0.0.1 postgres
"@

# Reemplazar el contenido completo del archivo
$existingContent + $entries | Set-Content $hostsFile -Force

Write-Output "Done!"
