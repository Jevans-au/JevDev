<#
.SYNOPSIS
    Function used to determine what the largest files on a drive\volume are.
    Intended to assist with the task of finding large files to delete.
.NOTES
    Author:     Jeff Evans
    Created:    2020/08/28
#>
function Get-LargestFiles {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $FilePath,
        [Parameter(Mandatory = $false)]
        [int]
        $ResultCount,
        [Parameter()]
        [switch]
        $AsJob,
        [Parameter()]
        [switch]
        $Recursive
    )
    try {
        # Confirm path exists
        $FilePathCheck = Test-Path -Path $FilePath
        If ($FilePathCheck) {
            $SearchSplat = @{
                Path        = $FilePath
                ErrorAction = 'silentlycontinue'
            }
            If ($Recursive) {
                $SearchSplat.Add('Recurse', $true)
            }
            try {
                $SearchResult = Get-ChildItem @SearchSplat
            }
            catch {
                $_
            }
        }
        Else {
            Write-Error "File path could not be verified: $FilePath" -ErrorAction Stop
        }
    }
    catch {
        $_
    }
    finally {
        $OutputObject = $SearchResult | Select-Object FullName, Length | Sort-Object Length -Descending
        if($ResultCount){
            Write-Output $OutputObject[0..($ResultCount -1)]
        }
        Else{
            Write-Output $OutputObject
        }
    }
}