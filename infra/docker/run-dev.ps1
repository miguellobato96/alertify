$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
Push-Location $repoRoot

try {
    docker compose -f .\infra\docker\docker-compose.yml up -d

    Write-Host ""
    Write-Host "Test URLs:"
    Write-Host "  http://localhost:8080/api/health"
    Write-Host "  http://localhost:8080/actuator/health"
    Write-Host ""

    & .\apps\backend\mvnw.cmd -f .\apps\backend\pom.xml spring-boot:run "-Dspring-boot.run.profiles=dev"
}
finally {
    Pop-Location
}
