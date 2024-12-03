# -*- coding: utf8 -*-
########
# Email SMTP Client Library for Robot Framework
########

import smtplib
import time
# Import the email modules we'll need
from email.mime.text import MIMEText
# Open a plain text file for reading.  For this example, assume that
# the text file contains only ASCII characters.
import smtplib
import time
# Import the email modules we'll need
from email.mime.text import MIMEText
from email.utils import formatdate

class smtpbot:
    def send_test_mail(self, mail_address, SMTP_server, Subject = None, content = None):
        # Open a plain text file for reading.  For this example, assume that
        # the text file contains only ASCII characters.
        timestamp = time.strftime('%X')
        mail_content = content if content else timestamp
        msg = MIMEText(mail_content)
        Subject = Subject if Subject else 'Test Mail, TimeStamp:{}'.format(timestamp)
        msg['Subject'] = Subject
        msg["Date"] = formatdate(localtime=True)
        msg['From'] = mail_address
        msg['To'] = mail_address
        # Send the message via our own SMTP server, but don't include the
        # envelope header.
        s = smtplib.SMTP(SMTP_server)
        s.sendmail(mail_address, [mail_address], msg.as_string())
        s.quit()
        return msg['Subject']
