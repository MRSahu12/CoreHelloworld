

#FROM mcr.microsoft.com/dotnet/runtime:3.1 AS base
#WORKDIR /app
#
#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /src
#COPY ["CoreHelloworld.csproj", "."]
#RUN dotnet restore "./CoreHelloworld.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "CoreHelloworld.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "CoreHelloworld.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "CoreHelloworld.dll"]
#

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app
COPY *.csproj .
RUN dotnet restore .
COPY . .
RUN dotnet publish -c Release -o /publish /restore --no-restore .
FROM mcr.microsoft.com/dotnet/runtime:3.1 AS runtime-env
WORKDIR /app
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "CoreHelloworld.dll"]
