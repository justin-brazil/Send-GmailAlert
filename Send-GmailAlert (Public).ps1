#####################SCRIPT_CONTROLS##
#!#Name:   Send-GmailAlert
#!#Author:  Justin Brazil
#!#Description:  Authenticates to gMail and sends an email message
#!#Tags:  gMail,email,SMTP,alert,Send,message,body,contents
#!#Type:   Function
#!#Product:  PowerShell, gMail
#!#Modes:  Scripting
#!#Notes:   Enter your username/password in the "AUTHENTICATION" section.  Requires "Simple Authentication" username/password to be configured in gMail: https://support.google.com/accounts/answer/6010255?hl=en
#!#Link:    https://support.google.com/accounts/answer/6010255?hl=en
#!#Group:   
#!#Special: "Universal"
####################/SCRIPT_CONTROLS##


function Send-GmailAlert
<#
	.SYNOPSIS
		Authenticates to gMail and sends an email message
	
	.DESCRIPTION
		Authenticates to gMail and sends an email message.  

		Requires "Simple Application Authentication" credentials to be created in gMail and added to the "AUTHENTICATION" section of the function.

	.PARAMETER To
		The target SMTP address
	
	.PARAMETER From
		The address from which the message will be sent (the authenticated "from" address).
	
	.PARAMETER Subject
		The SMTP subject line
	
	.PARAMETER Body
		The SMTP message body contents
	
	.PARAMETER TestMessage
		Sends a test message using the provided credentials
	
	.NOTES
		Set your default "To" and "From" addresses in the parameters section to streamline daily use.

		Set your "Simple Application Authentication" credentials in the "AUTHENTICATION" section: https://support.google.com/accounts/answer/6010255?hl=en
		
	.EXAMPLE
		Send-GmailAlert -To 'myaddress@gmail.com' -From 'myaddress@gmail.com' -TestMessage
#>

{
	param
	(
		[Parameter(Mandatory = $false,
				   HelpMessage = 'The target SMTP address')]
					[string]$To = 'youraddress@gmail.com',              #Set your default "To" address here
		
		[Parameter(Mandatory = $false,
				   HelpMessage = 'The "From" address')]
					[string]$From = 'youraddress@gmail.com',			#Set your default "From" address here
		
		[Parameter(Mandatory = $false,
				   HelpMessage = 'The SMTP subject line')]
					[string]$Subject = "Alert from $env:Computername",
		
		[Parameter(Mandatory = $false,
				   HelpMessage = 'The SMTP message body')]
					[string]$Body,
		
		[Parameter(HelpMessage = 'Switch parameter to send a test message')]
					[switch]$TestMessage
	)
	
	###  AUTHENTICATION  ###						#Authenticates to gMail using Simple Application Credentials: https://support.google.com/accounts/answer/6010255?hl=en
	
	$GmailAuthAccount = 'gMailAuthUsername'                 #Your GMAIL simple authentication username (usually your email address without the '@gmail.com' section)
	$GmailAuthPassword = 'yoursimpleauthpasswordhere' 				#Your GMAIL simple authentication password
	
	$SMTPServer = 'smtp.gmail.com'
	
	###  TEST MESSAGE SWITCH  ###					#Automatically populates SUBJECT and BODY parameters
	
	if ($TestMessage)
	{
		$Subject = "Test Message Sent from $ENV:Computername"
		$Body = "Success!  You have successfully authenticated to gMail and sent an SMTP message."
	}
	
	###  SEND MESSAGE  ###							#Sends message using .NET simple SMTP client
	$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
	$SMTPClient.EnableSsl = $true
	$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($GmailAuthAccount, $GmailAuthPassword);
	$SMTPClient.Send($From, $To, $Subject, $Body)
}

