# Script Test-Connection – Verifica quais computadores estão ligados e desligados - Créditos Gabriel Luiz - www.gabrielluiz.com ##


$servers = Get-Content C:\Scripts\ESTACOES.txt # Caminho do arquivo de texto com os hostnames dos computadores.
$data = Get-Date -uformat “%d.%m.%Y.%R” | ForEach-Object { $_ -replace ":", "." }
New-Item -Path "c:\Scripts\$data" -ItemType directory
$collection = $()
foreach ($server in $servers)
{
    $status = @{ "Computadores" = $server; "Datas" = (Get-Date -uformat “%d/%m/%Y-%R”) }
    if (Test-Connection $server -Count 1 -ea 0 -Quiet)
    { 
        $status["Status"] = "Ligado"
    } 
    else 
    { 
        $status["Status"] = "Desligado" 
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus 

}
$collection | Select Computadores, Datas, Status | Export-Csv -Path "c:\Scripts\$data\ComputadorStatus.csv" -NoTypeInformation # Caminho aonde será gerado o arquivo CSV.

<# 

Referências:

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.1&WT.mc_id=WDIT-MVP-5003815

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1&WT.mc_id=WDIT-MVP-5003815

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.1&WT.mc_id=WDIT-MVP-5003815

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1&WT.mc_id=WDIT-MVP-5003815

https://gallery.technet.microsoft.com/scriptcenter/Ping-servers-in-TXT-file-26d12fa4

#>