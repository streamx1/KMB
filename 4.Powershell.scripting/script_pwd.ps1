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
