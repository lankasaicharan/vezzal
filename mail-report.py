import smtplib,ssl
import sys
from email.message import EmailMessage

msg=EmailMessage()
msg['Subject']='Testing Result: '+sys.argv[1]
msg['From']='vezzaltool@gmail.com'
mails=sys.argv[2].split(",")
msg['To']=mails

with open('/vezzal/testcases/netgen/final_report.txt','r') as f:
    file_data=f.read()

msg.set_content(file_data)

context=ssl.create_default_context()

with smtplib.SMTP('smtp.gmail.com',587) as smtp:

    smtp.starttls(context=context)
    smtp.login('vezzaltool@gmail.com',sys.argv[3])
    smtp.send_message(msg)

