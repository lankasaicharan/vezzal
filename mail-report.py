##########################################################################
## Written by Sai Charan Lanka (Author of "Vezzal" tool)
## GNU GENERAL PUBLIC LICENSE
## Version 3, 29 June 2007
##
## Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
## Everyone is permitted to copy and distribute verbatim copies
## of this license document, but changing it is not allowed.
##
##########################################################################
import smtplib,ssl
import sys
from email.message import EmailMessage

msg=EmailMessage()
msg['Subject']='Testing Result: '+sys.argv[2]+'|Tool name: '+sys.argv[1]
msg['From']='vezzaltool@gmail.com'
mails=sys.argv[3].split(",")
msg['To']=mails
path="/vezzal/testcases/"+sys.argv[1]+"/final_report.txt"
with open(path,'r') as f:
    file_data=f.read()

msg.set_content(file_data)

context=ssl.create_default_context()

with smtplib.SMTP('smtp.gmail.com',587) as smtp:

    smtp.starttls(context=context)
    smtp.login('vezzaltool@gmail.com',sys.argv[4])
    smtp.send_message(msg)

