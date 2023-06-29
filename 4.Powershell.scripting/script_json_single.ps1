param (
    [Parameter(Mandatory=$true)]
    [string]$FileName,

    [Parameter(Mandatory=$true)]
    [string]$PropertyName,

    [Parameter(Mandatory=$true)]
    [string]$NewValue
)

# Загружаем содержимое JSON-файла
$jsonContent = Get-Content -Raw -Path $FileName | ConvertFrom-Json

# Изменяем значение свойства
$jsonContent.$PropertyName = $NewValue

# Сохраняем измененное содержимое обратно в файл
$jsonContent | ConvertTo-Json -Depth 4 | Set-Content -Path $FileName
