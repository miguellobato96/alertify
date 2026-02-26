# Alertify Monorepo

## Project overview
Alertify is organized as a monorepo to keep backend services, mobile applications, shared packages, and infrastructure definitions in one place.

## Directory structure
```text
alertify/
├─ apps/
│  ├─ backend/          # Spring Boot backend service
│  ├─ android/          # Android app
│  └─ ios/              # iOS app
├─ packages/
│  └─ shared/           # Shared code/contracts
├─ infra/
│  └─ docker/           # Docker Compose and infra helpers
└─ .github/
   └─ workflows/        # CI workflows
```

## How to run locally
1. Install Java 17 and Maven 3.9+.
2. Set backend environment variables (PowerShell example):
   ```powershell
   $env:SPRING_PROFILES_ACTIVE="dev"
   $env:DB_HOST="localhost"
   $env:DB_PORT="5432"
   $env:DB_NAME="alertify"
   $env:DB_USER="alertify"
   $env:DB_PASSWORD="alertify"
   ```
3. Start backend:
   ```powershell
   cd apps/backend
   mvn spring-boot:run
   ```

## How to develop backend
1. Backend source lives in `apps/backend/src/main/java`.
2. Health endpoint:
   - `GET /api/health` returns `OK`
3. Dev datasource settings are in `apps/backend/src/main/resources/application-dev.properties` and resolve values from `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, and `DB_PASSWORD`.
4. Run tests:
   ```powershell
   cd apps/backend
   mvn test
   ```

## How to run docker compose
1. Build and start containers:
   ```powershell
   cd infra/docker
   docker compose up --build
   ```
2. Stop containers:
   ```powershell
   docker compose down
   ```

## How to contribute (branch strategy, PR reviews)
1. Create feature branches from `main` with naming format:
   - `feature/<short-description>`
   - `fix/<short-description>`
2. Keep pull requests focused and small enough for practical review.
3. Require at least one reviewer approval before merge.
4. Ensure backend CI passes before requesting final review.
5. Prefer squash merge to keep commit history clean.

## Local dev profile with Docker DB
1. Start PostgreSQL:
   ```powershell
   docker compose -f infra/docker/docker-compose.yml up -d
   ```
2. Run backend with the `dev` profile:
   ```powershell
   cd apps/backend
   .\mvnw.cmd spring-boot:run "-Dspring-boot.run.profiles=dev"
   ```
   PowerShell note: unquoted `-D...` args with dots can be split before they reach Maven. Quote each `-D` arg (or use `--%`).
3. Verify:
   - `http://localhost:8080/api/health`
   - `http://localhost:8080/actuator/health` (if Actuator is enabled)

Ruleset/CI validation PR.
