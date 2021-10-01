function Get-TemperatureConversion {
    <#
    .SYNOPSIS
    Function that will take a temperature (string\int) and unit (celsius, fahrenheit, kelvin) and return an object
    with the converted temperature value for all 3.

    .PARAMETER Temperature
    The temperature value you wish to convert.

    .PARAMETER Unit
    The unit of measurement the provided temperature is based on, must be one of the following:
        - Celsius
        - Fahrenheit
        - Kelvin

    .EXAMPLE
    Get-TemperatureConversion -Temperature 20 -Unit Celsius

    celsius fahrenheit kelvin
    ------- ---------- ------
         20         68 293.15

    Returns an object displaying what 20 degrees celsius would be in fahrenheit and kelvin.
    Celsius is also returned as a consistent point of reference between the three units of measurement, the same would occur
    if the unit had been fahrenheit or kelvin.

    .NOTES
        Version:    0.1.0
        Author:     Jeff Evans (jevans.dev)
        Created:    2021/9/20
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $Temperature, # It grinds my gears to leave this without a type, but it's usually best to leave it to decide for itself
        [Parameter(Mandatory=$true)]
        [ValidateSet('celsius','fahrenheit','kelvin')]
        [string]
        $Unit
    )
    $OutputObject = [PSCustomObject]@{
        celsius     = $null
        fahrenheit  = $null
        kelvin      = $null
    }
    # Just return the conversion for the other two by default
    switch ($unit) {
        'celsius' {
            $OutputObject.celsius       = $Temperature
            $OutputObject.fahrenheit    = ($Temperature * 1.8) + 32
            $OutputObject.kelvin        = $Temperature + 273.15
        }
        'fahrenheit' {
            $OutputObject.celsius       = ($Temperature - 32) / 1.8
            $OutputObject.fahrenheit    = $Temperature
            $OutputObject.kelvin        = $OutputObject.celsius + 273.15
        }
        'kelvin' {
            $OutputObject.celsius       = $Temperature - 273.15
            $OutputObject.fahrenheit    = ($OutputObject.celsius * 1.8) + 32
            $OutputObject.kelvin        = $Temperature
        }
    }
    Write-Output $OutputObject
}