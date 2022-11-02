FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443



FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY "Eventtix.sln" "Eventtix.sln"

COPY ["gateways/web/src/WebGateway/WebGateway.csproj", "gateways/web/src/WebGateway/"]

COPY ["services/booking/src/Booking.Service/Booking.Service.csproj", "services/booking/src/Booking.Service/"]
COPY ["services/common/src/Common.Service/Common.Service.csproj", "services/common/src/Common.Service/"]
RUN dotnet restore "Eventtix.sln" --interactive -nowarn:msb3202,msb3277,nu1503

COPY . .
WORKDIR "/src/services/common/src/Common.Service"
RUN dotnet publish -nowarn:msb3202,msb3277,nu1503 -c Release -o /app 
FROM build AS publish



RUN dotnet publish "Common.Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Common.Service.dll"]
