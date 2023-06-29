param (
    [Parameter(Mandatory=$true)]
    [string]$substring
)

# Получаем имя файла из переменной среды
$fileName = $env:FileName

# Проверяем, существует ли файл
if (Test-Path $fileName) {
    # Читаем содержимое файла
    $content = Get-Content $fileName

    # Фильтруем строки, удаляя те, которые содержат подстроку
    $filteredContent = $content | Where-Object { $_ -notmatch $substring }

    # Записываем отфильтрованное содержимое обратно в файл
    $filteredContent | Set-Content $fileName
}
