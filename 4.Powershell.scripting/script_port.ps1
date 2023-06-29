param (
    [Parameter(Mandatory=$true)]
    [int]$Port
)

# Получаем информацию о процессе, открывшем порт
$process = Get-NetTCPConnection | Where-Object { $_.LocalPort -eq $Port }

if ($process) {
    $processId = $process.OwningProcess
    $processName = (Get-Process -Id $processId).Name

    Write-Host "Порт $Port открыт процессом: $processName (ID: $processId)"
} else {
    Write-Host "Порт $Port не открыт ни одним процессом на локальной машине."
}

