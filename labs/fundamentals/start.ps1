# Running with
# PowerShell -ExecutionPolicy Bypass -File .\start.ps1

# Ejecutar docker-compose para iniciar los contenedores
docker-compose up -d

Write-Output "Waiting for Kafka to launch on port 9092..."

# Esperar hasta que el puerto 9092 en el contenedor 'kafka' esté disponible
while (-not (Test-NetConnection -ComputerName "kafka" -Port 9092 -InformationLevel Quiet)) {
    Start-Sleep -Seconds 1
    Write-Output "Kafka not yet ready..."
}

Write-Output "Kafka is now ready!"
