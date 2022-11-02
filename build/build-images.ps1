param ($version='latest')

$currentFolder = $PSScriptRoot
$slnFolder = Join-Path $currentFolder "../"

$bookingServiceFolder = Join-Path $slnFolder "services/booking/src/Booking.Service"
$commonServiceFolder = Join-Path $slnFolder "services/common/src/Common.Service"

### Gateway Folders
$webGatewayFolder = Join-Path $slnFolder "gateways/web/src/WebGateway"


Write-Host "*** BUILDING PRIVATE GATEWAY ***" -ForegroundColor Green
Set-Location $slnFolder
docker build -f "$webGatewayFolder/Dockerfile" -t eventtix/gateway-web:$version .
Write-Host "===== COMPLETED BUILDING PRIVATE GATEWAY =====" -ForegroundColor Yellow 


### BOOKING-SERVICE
Write-Host "*** BUILDING BOOKING-SERVICE ***" -ForegroundColor Green
Set-Location $slnFolder
docker build -f "$bookingServiceFolder/Dockerfile" -t eventtix/service-booking:$version .
Write-Host "===== COMPLETED BUILDING BOOKING-SERVICE MICROSERVICES =====" -ForegroundColor Yellow 

### COMMON-SERVICE
Write-Host "*** BUILDING COMMON-SERVICE ***" -ForegroundColor Green
Set-Location $slnFolder
docker build -f "$commonServiceFolder/Dockerfile" -t eventtix/service-common:$version .
Write-Host "===== COMPLETED BUILDING  COMMON-SERVICE MICROSERVICES =====" -ForegroundColor Yellow 

### ALL COMPLETED
Write-Host "ALL COMPLETED" -ForegroundColor Green
Set-Location $currentFolder