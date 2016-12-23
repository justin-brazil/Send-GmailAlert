# Send-GmailAlert

Send-GmailAlert is a function designed to authenticate to gMail and send an SMTP email message.

"Simple Application Authentication" must be enabled on the gMail account, and the credentials need to be entered into the "AUTHENTICATION" section by the user.  Instructions": https://support.google.com/accounts/answer/6010255?hl=en

The user should also configure the default "To" and "From" property values in the parameter block section in order to streamline daily use of this function.

Example:  Send-GmailAlert -To 'myaddress@gmail.com' -From 'myaddress@gmail.com' -Subject "Alert Message from $env:ComputerName" -Body "Warning - there is less than 10% disk space remaining on drive $DRIVE."
		
The -TestMessage switch parameter can be called to automatically populate the "Subject" and "Body" fields for easy testing during setup.



Enjoy!
Justin
		
