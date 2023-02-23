(New-Object -ComObject shell.application).toggleDesktop()

$MsgText = "Is what you're doing more important than rest?"
$MsgTitle = "title"

#[System.Windows.MessageBox]::Show($message)


param (
        [Parameter(Mandatory=$true)]
          [String]$MsgTitle,
        [Parameter(Mandatory=$true)]
          [String]$MsgText
)

Add-Type -AssemblyName Microsoft.VisualBasic 

# ----------------  add a helper  --------------------
$showWindowAsync = Add-Type –memberDefinition @” 
[DllImport("user32.dll")] 
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow); 
“@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

function Show-PowerShell() { 
     [void]$showWindowAsync::ShowWindowAsync((Get-Process –id $pid).MainWindowHandle, 10) 
}

function Hide-PowerShell() { 
    [void]$showWindowAsync::ShowWindowAsync((Get-Process –id $pid).MainWindowHandle, 2) 
}

# ------------------ End Helper -------------------------------


Clear-Host

Hide-PowerShell

$MsgBox = [Microsoft.VisualBasic.Interaction]

[void] $MsgBox::MsgBox($MsgText,0,$MsgTitle)

Show-PowerShell