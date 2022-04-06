function Get-FrameWorkElementType {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $ElementType
    )
    $FrameWorkElement = [System.Windows.FrameworkElement]
    Write-Output $FrameWorkElement.Assembly.DefinedTypes
}