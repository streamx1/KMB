param (
    [Parameter(Mandatory=$true)]
    [string]$FolderPath,

    [Parameter(Mandatory=$true)]
    [string]$Substring
)

# Получаем список файлов в указанной папке
$files = Get-ChildItem -Path $FolderPath | Where-Object { $_.Name -like "*$Substring*" }

# Обходим каждый файл и выводим его имя и размер
foreach ($file in $files) {
    $fileName = $file.Name
    $fileSize = $file.Length

    Write-Output "File Name: $fileName, Size: $fileSize bytes"
}