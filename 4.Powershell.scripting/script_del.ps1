param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProcessIDorName,

    [Parameter(Mandatory=$false, Position=1)]
    [switch]$Delete
)

# ���������, ����� �� �������� Delete
$shouldDelete = $Delete.IsPresent

# ��������� ����� ������� �������� ��� ���������
$process = $null
if ($ProcessIDorName -match '^\d+$') {
    $process = Get-Process -Id $ProcessIDorName -ErrorAction SilentlyContinue
} else {
    $process = Get-Process -Name $ProcessIDorName -ErrorAction SilentlyContinue
}

if ($process) {
    if ($shouldDelete) {
        $process | Stop-Process -Force
        Write-Host "������� $($process.Name) (ID: $($process.Id)) ������� ������."
    } else {
        Write-Host "��� ��������: $($process.Name)"
        Write-Host "ID ��������: $($process.Id)"
    }
} else {
    Write-Host "������� �� ������."
}
