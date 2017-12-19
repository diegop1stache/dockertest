FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Node
COPY package.json package.json
RUN npm install -g

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o out
#Development mode
ENTRYPOINT ["dotnet", "out/Equiver.dll"]

#Production mode
# Build runtime image
# FROM microsoft/aspnetcore:2.0
# WORKDIR /app
# COPY --from=build-env /app/out .
# ENTRYPOINT ["dotnet", "Equiver.dll"]