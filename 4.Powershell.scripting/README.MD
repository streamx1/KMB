### Powershell scripting.
#### Parameters / Conditions / Variables.
#### Replacement script: edit a file with name passed as an environment variable - remove all lines that contain a substring passed as a parameter


```bash


in PowerShall:
Set-ExecutionPolicy -Scope CurrentUser Unrestricted

--script:

param (
    [Parameter(Mandatory=$true)]
    [string]$substring
)

# Получаем имя файла из заранее установленной переменной среды
$fileName = $env:FileName

# Проверяем, существует ли файл
if (Test-Path $fileName) {
    # Читаем содержимое файла
    $content = Get-Content $fileName

    # Фильтруем строки и удаляем те, которые содержат подстроку введённую параметром скрипта
    $filteredContent = $content | Where-Object { $_ -notmatch $substring }

    # Записываем отфильтрованное содержимое обратно в файл
    $filteredContent | Set-Content $fileName
}

--original file C:\test.txt:

test1
test2
test3
test4
test5

--run:
$env:FileName = "C:\test.txt"
.\script.ps test2

--result file C:\test.txt:

test1
test3
test4
test5

```

### Monitoring. 
#### Get a process name by ID or ID by name passed as parameters, delete a process by name or ID.

```bash 


--script:

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


--run:
PS C:\> ./scriptdel.ps1 notepad

--output:
Имя процесса: notepad notepad
ID процесса: 12408 12776

--run:
PS C:\> ./scriptdel.ps1 notepad -delete

--output:
Процесс notepad notepad (ID: 12408 12776) успешно удален.

```

### Monitoring.
#### Check if a port (passed as a parameter) is opened locally, get name of the process that opened a specified port.

```bash
--script:

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


--run:
PS C:\> .\scriptport.ps1 -Port 3389

--output:
Порт 3389 открыт процессом: svchost (ID: 1112 1112)

```

### General.
#### Create a random password with letters and digits with specified length passed as a parameter.

```bash

--script:

param (
    [Parameter(Mandatory=$true)]
    [int]$Length
)

# Создаем массив символов, состоящий из букв и цифр
$characters = @(
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
)

# Генерируем случайный пароль
$password = ''
for ($i = 1; $i -le $Length; $i++) {
    $randomIndex = Get-Random -Minimum 0 -Maximum $characters.Length
    $password += $characters[$randomIndex]
}

# Выводим сгенерированный пароль
$password

--run:

PS C:\> .\scriptpwd.ps1 -Length 10
F2pXL9egro

PS C:\> .\scriptpwd.ps1 -Length 15
g29RZydjLcBeWyI

PS C:\> .\scriptpwd.ps1 -Length 20
szO52ci4PFoDRXK0cX6u

```


### Conversion.
#### Change value of a property in a JSON file. Value, property name and file name passed as parameters.

```bash

--file data.json:
{
    "name":  null,
    "age":  null,
    "gender":  null,
    "hobbies":  null,
    "address":  null
}

--script with enter single property name:

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

--run:
PS C:\> .\script.ps1 -FileName "data.json" -PropertyName "name" -NewValue "Pavel"

--output file data.json:

{
    "name":  "Pavel",
    "age":  null,
    "gender":  null,
    "hobbies":  null,
    "address":  null
}

--script with enter multiple property name:

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


--run:
PS C:\> .\script_json_multi.ps1 -FileName "data.json" -PropertyName "name","age","gender","hobbies","address" -NewValue "Pavel","33","man","cycling,hiking","Belarus"
--output file data.json:
{
    "name":  "Pavel",
    "age":  "33",
    "gender":  "man",
    "hobbies":  "cycling,hiking",
    "address":  "Belarus"

```

### Files.
#### Get names and sizes of files in a specified folder whose names contain a specified substring, both passed as parameters.

```bash

-- script 

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

-- run 
PS C:\> .\script_file.ps1 -FolderPath "C:\" -Substring "script"

--output:
File Name: script.ps1, Size: 698 bytes
File Name: script_del.ps1, Size: 861 bytes
File Name: script_file.ps1, Size: 547 bytes
File Name: script_json_multi.ps1, Size: 791 bytes
File Name: script_json_single.ps1, Size: 581 bytes
File Name: script_port.ps1, Size: 476 bytes
File Name: script_pwd.ps1, Size: 715 bytes

```
