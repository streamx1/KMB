param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProcessIDorName,

    [Parameter(Mandatory=$false, Position=1)]
    [switch]$Delete
)

# Проверяем, задан ли параметр Delete
$shouldDelete = $Delete.IsPresent

# Остальная часть скрипта остается без изменений
$process = $null
if ($ProcessIDorName -match '^\d+$') {
    $process = Get-Process -Id $ProcessIDorName -ErrorAction SilentlyContinue
} else {
    $process = Get-Process -Name $ProcessIDorName -ErrorAction SilentlyContinue
}

if ($process) {
    if ($shouldDelete) {
        $process | Stop-Process -Force
        Write-Host "Процесс $($process.Name) (ID: $($process.Id)) успешно удален."
    } else {
        Write-Host "Имя процесса: $($process.Name)"
        Write-Host "ID процесса: $($process.Id)"
    }
} else {
    Write-Host "Процесс не найден."
}
