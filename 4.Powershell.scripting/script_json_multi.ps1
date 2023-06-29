param (
    [Parameter(Mandatory=$true)]
    [string]$FileName,

    [Parameter(Mandatory=$true)]
    [string[]]$PropertyName,

    [Parameter(Mandatory=$true)]
    [string[]]$NewValue
)

# Загружаем содержимое JSON-файла
$jsonContent = Get-Content -Raw -Path $FileName | ConvertFrom-Json

# Проходим по массиву свойств и новых значений
for ($i = 0; $i -lt $PropertyName.Length; $i++) {
    $property = $PropertyName[$i]
    $value = $NewValue[$i]

    # Изменяем значение свойства
    $jsonContent.$property = $value
}

# Сохраняем измененное содержимое обратно в файл
$jsonContent | ConvertTo-Json -Depth 4 | Set-Content -Path $FileName
