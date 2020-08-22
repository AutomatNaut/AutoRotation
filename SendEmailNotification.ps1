param([Parameter(Mandatory=$true)][string]$Subject,
      [Parameter(Mandatory=$true)][string]$Body,
      [Parameter(Mandatory=$false)][string]$Attachment1,
      [Parameter(Mandatory=$false)][string]$Attachment2)
$From = "your_email@gmail.com"
$To = "your_email@gmail.com"
$SMTPServer = "smtp.gmail.com"
$secpasswd = ConvertTo-SecureString "your_password" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("your_email@gmail.com", $secpasswd)

if($Attachment1 -ne "")
{
    $Attachments = @()
    $Attachments += $Attachment1
    $Attachments += $Attachment2

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -UseSsl -SmtpServer $SMTPServer -Port 587 -Credential $cred -Attachments $Attachments
}
else
{
    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -UseSsl -SmtpServer $SMTPServer -Port 587 -Credential $cred
}
