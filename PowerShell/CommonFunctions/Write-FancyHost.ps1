<#
.SYNOPSIS
    Saves on the tedious effort required to separate and write to host with multiple colours in a line, and helps keep the effect consistent across functions.
.PARAMETER Message
    The message returned to the terminal, if the $Object parameter isn't specified it will still write the message but no words will be highlighted.
    Still useful if you are using a default set of colours for your messages to the host and want to save on typing anything extra or any overhead of having to update the colours multiple times in a script.
.PARAMETER Object
    The word to be highlighted in the message, if the message does not contain the word provided in this parameter it will simply return the message entirely in the context colour.
.PARAMETER ContextColour
    The colour that the message is returned in.
    Default colour is cyan unless another value is provided, these values must match those provided by the 'foregroundcolor' parameter for Write-Host
.PARAMETER ObjectColour
    The colour used to highlight the Object word in the message.
    Default colour is magenta unless another value is provided, these values must match those provided by the 'foregroundcolor' parameter for Write-Host
.NOTES
    Author:     Jeff Evans
    Created:    2020/08/28
#>

function Write-FancyHost {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Message,
        # The word to be highlighted in the message
        [Parameter(Mandatory = $false)]
        [string]
        $Object,
        # The colour that the rest of the message will present in
        [Parameter(Mandatory = $false)]
        [Alias("ContextColor")]
        [string]
        $ContextColour = 'cyan',
        # The colour that the highlighted object in the message will present in
        [Parameter(Mandatory = $false)]
        [Alias("ObjectColor")]
        [string]
        $ObjectColour = 'magenta'
    )
    If($Object){
        $SplitMessage = $Message -split [regex]::Escape($Object)
    }
    If($SplitMessage){
        ForEach($Item in $SplitMessage){
            If($Item -eq $SplitMessage[-1]){
                Write-Host $Item -ForegroundColor $ContextColour
            }
            Else{
                Write-Host $Item -NoNewline -ForegroundColor $ContextColour
                Write-Host $Object -ForegroundColor $ObjectColour -NoNewline
            }
        }
    }
    Else{
        Write-Host $Message -ForegroundColor $ContextColour
    }
}