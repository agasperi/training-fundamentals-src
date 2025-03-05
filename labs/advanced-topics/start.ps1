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

# Crear el topic "vehicle-positions" en Kafka
kafka-topics --bootstrap-server kafka:9092 `
    --topic vehicle-positions `
    --create `
    --partitions 6 `
    --replication-factor 1

# Ejecutar el contenedor "producer"
docker container run -d `
    --name producer `
    --network advanced-topics_confluent `
    cnfltraining/vp-producer:v2
