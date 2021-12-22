FROM mcr.microsoft.com/dotnet/sdk:6.0.101-bullseye-slim-arm64v8 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY /HelloArm64/HelloArm64.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY /HelloArm64/*.cs ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:6.0.1-bullseye-slim-arm64v8
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "HelloArm64.dll"]