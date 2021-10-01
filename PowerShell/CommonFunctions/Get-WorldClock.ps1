function Get-WorldClock {
    # TODO - Jeff Evans (jevans.dev) - some kind of helpful commenty block thing here
    # TODO - Jeff Evans (jevans.dev) - a param block may be useful, as I'm sure some may actually be interested in having UTC zones returned as well
    $TimeZone = Get-TimeZone -ListAvailable | Where-Object {$_.Id -notlike "*UTC*"}
    $GMTTime = [DateTime]::UtcNow
    $LocalTime = [DateTime]::Now
    $WorldClock = ForEach($Zone in $TimeZone){
        [pscustomobject]@{
            TimeZone = $Zone.Id
            CurrentTime = $GMTTime.AddMinutes($Zone.BaseUtcOffset.TotalMinutes)
        }
    }
    $WorldClock = $WorldClock | Sort-Object CurrentTime
    Write-Output $WorldClock
}