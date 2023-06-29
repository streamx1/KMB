param (
    [Parameter(Mandatory=$true)]
    [int]$Port
)

# �������� ���������� � ��������, ��������� ����
$process = Get-NetTCPConnection | Where-Object { $_.LocalPort -eq $Port }

if ($process) {
    $processId = $process.OwningProcess
    $processName = (Get-Process -Id $processId).Name

    Write-Host "���� $Port ������ ���������: $processName (ID: $processId)"
} else {
    Write-Host "���� $Port �� ������ �� ����� ��������� �� ��������� ������."
}

