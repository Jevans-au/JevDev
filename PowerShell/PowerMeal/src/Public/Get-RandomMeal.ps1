<#
.NOTES
    Developed one evening when we could not think of what to order in.
    Code development process powered by hunger.

    Created:    28/06/2020
    Author:     jevans_
#>

Function Get-RandomMeal {
    [CmdletBinding()]
    param (
        [Parameter()]
        [Switch]
        $Delivered,
        [Parameter()]
        [Switch]
        $Favourite
    )
    # Import parameters
    $PowerMealParams = Get-Content -Path "$PSScriptRoot\..\PowerMealParams.json" | ConvertFrom-Json
    Write-Verbose "Params loaded:"
    Write-Verbose $PowerMealParams
    # Delivery
    If($Delivered){
        # Get date, used to determine what is open when function is run
        $Date = Get-Date
        $FoodEstablishment = $PowerMealParams.delivery.psobject.properties.Name | ForEach-Object {
            If($_ -notlike "*template*"){
                $_
            }
        }
        do {
            $RandomFoodEstablishment = Get-Random $FoodEstablishment | Where-Object {
                ((Get-Date $PowerMealParams.Delivery.$_.CloseTime) -gt $Date) -and
                ((Get-Date $PowerMealParams.Delivery.$_.OpenTime) -lt $Date)
            }
        } until ($null -ne $RandomFoodEstablishment)
        Write-Host "Food Establishment Picked: " -NoNewline -ForegroundColor Yellow
        Write-Host $RandomFoodEstablishment -ForegroundColor Green
            # Favourite
            If($Favourite){
                Write-Host "K's favourites: " -ForegroundColor Yellow
                $PowerMealParams.Delivery.$RandomFoodEstablishment.KellyFavourites | ForEach-Object {
                    Write-Host $_ -ForegroundColor Green
                }
                Write-Host "J's favourites: " -ForegroundColor Yellow
                $PowerMealParams.Delivery.$RandomFoodEstablishment.JeffFavourites | ForEach-Object {
                    Write-Host $_ -ForegroundColor Green
                }
            }
        Write-Host "Open\Close Times: " -ForegroundColor Yellow
        Write-Host ($PowerMealParams.Delivery.$RandomFoodEstablishment.OpenTime + '-' + $PowerMealParams.Delivery.$RandomFoodEstablishment.CloseTime) -ForegroundColor Cyan
    }
}