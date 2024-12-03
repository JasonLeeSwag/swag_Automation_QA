# -*- coding: utf8 -*-
########
# Email POP3 Client Library for Robot Framework
########

import email
import poplib
import re
from email.parser import Parser
from email.header import decode_header
from email.utils import parseaddr, parsedate_tz, mktime_tz, formatdate
try:
    from html.parser import HTMLParser
except:
    from HTMLParser import HTMLParser # type: ignore
from robot.api import logger
from time import gmtime, strftime
from collections import OrderedDict

# 输入邮件地址, 口令和POP3服务器地址:
# email = raw_input('Email: ')
# password = raw_input('Password: ')
# pop3_server = raw_input('POP3 server: ')

class pop3bot:
    """
    This is a library to access and validate pop3 messages on an email server.
    """
    __version__ = '1.0'

    def __init__(self):
        self.user = ''
        self.password = ''
        self.pop3_server = ''

    def pop3_login(self, host, user, password):
        self.user = user
        self.password = password
        self.pop3_server = host
        # 连接到 POP3 服务器:
        self.server = poplib.POP3(self.pop3_server)
        # 可以打开或关闭调试信息:
        # server.set_debuglevel(1)
        # 可选:打印POP3服务器的欢迎文字:
        # print(self.server.getwelcome())
        # 身份认证:
        self.server.user(user)
        self.server.pass_(password)

    def pop3_logout(self):
        self.server.quit()

    def get_status(self):
        # stat() 返回邮件数量和占用空间:
        # print('Messages: %s. Size: %s' % self.server.stat())
        # list() 返回所有邮件的编号:
        self.resp, self.mails, self.octets = self.server.list()
        # 可以查看返回的列表类似['1 82923', '2 2184', ...]
        # print(self.mails)

    def select_first_mail(self):
        # 將棄用，請使用 self.select_mail
        self.select_mail(0)

    def select_mail(self, index = 0):
        # 原 select_first_mail 新增參數供選擇其餘信件
        self.index = len(self.mails) - int(index)
        # import pdb; pdb.set_trace()
        print(u'信件數量:' + str(self.index))
        self.resp, self.lines, self.octets = self.server.retr(self.index)
        # lines 存储了邮件的原始文本的每一行,
        # 可以获得整个邮件的原始文本:
        self.lines = [_.decode("utf-8") for _ in self.lines]
        # byte 轉 unicode
        self.msg_content = '\r\n'.join(self.lines)
        # 稍后解析出邮件:
        self.msg = Parser().parsestr(self.msg_content)
        print(u'信件內容:' + str(self.msg))

    def check_mail_time(self, sub_min = 5):
        sub_min = int(sub_min)
        # 原 check_first_mail_time，但並非檢查第一筆故改名
        now_d = strftime("%d")
        # 統一格式與信件相同，只為易讀
        if now_d.find('0', 0) == 0:
            now_d = now_d.lstrip('0')
            now_time = strftime("%a, " + now_d + " %b %Y %H:%M:%S +0800")
        else:
            now_time = strftime("%a, %d %b %Y %H:%M:%S +0800")
        print(u'現在時間: ' + now_time)
        # 取出信件的時間
        pattern = re.compile(r'Date\:\s[\w|\,|\s|\:|\+]*')
        mail_time = pattern.search(
            str(self.msg)).group(0).replace('Date: ', '')
        print(u'信件時間: ' + mail_time)
        now_timestamp = mktime_tz(parsedate_tz(now_time))
        mail_timestamp = mktime_tz(parsedate_tz(mail_time))
        if now_timestamp - mail_timestamp > sub_min * 60:
            raise AssertionError("信件時間與當前時間差距超過: '%s' 分鐘" % (sub_min))

    def check_mail_title(self, expected_title):
        mail_title = self.decode_str(self.msg['Subject'])
        if mail_title != expected_title:
            raise AssertionError("Mail title '%s' is not '%s'" % (mail_title, expected_title))

    def get_mail_link(self, url):
        # 原 get_first_link，但並非取得第一筆的 link 故改名
        return self.print_info(self.msg, url)

    # indent 用于缩进显示:
    def print_info(self, msg, url, indent = 0):
        if indent == 0:
            # 邮件的 From, To, Subject 存在于根对象上:
            for header in ['From', 'To', 'Subject']:
                value = msg.get(header, '')
                if value:
                    if header == 'Subject':
                        # 需要解码 Subject 字符串:
                        value = self.decode_str(value)
                    else:
                        # 需要解码 Email 地址:
                        hdr, addr = parseaddr(value)
                        name = self.decode_str(hdr)
                        value = u'%s <%s>' % (name, addr)
                # print('%s%s: %s' % ('  ' * indent, header, value))
        if (msg.is_multipart()):
            # 如果邮件对象是一个 MIMEMultipart,
            # get_payload() 返回 list，包含所有的子对象:
            parts = msg.get_payload()
            for n, part in enumerate(parts):
                # print('%spart %s' % ('  ' * indent, n))
                # print('%s--------------------' % ('  ' * indent))
                # 递归打印每一个子对象:
                self.print_info(part, indent + 1)
        else:
            # 邮件对象不是一个 MIMEMultipart,
            # 就根据 content_type 判断:
            content_type = msg.get_content_type()
            if content_type == 'text/plain' or content_type == 'text/html':
                # 纯文本或 HTML 内容:
                content = msg.get_payload(decode = True)
                # 要检测文本编码:
                charset = self.guess_charset(msg)
                if charset:
                    content = content.decode(charset)
                # print('%sText: %s' % ('  ' * indent, content + '...'))
                DOMparser = self.LinkParser()
                DOMparser.feed(content)
                DOMparser.close()
                print(DOMparser.links[:])
                for Http_Link in DOMparser.links:
                    if re.search(url, Http_Link):
                        return Http_Link
            else:
                # 不是文本,作为附件处理:
                print('%sAttachment: %s' % ('  ' * indent, content_type))

    def decode_str(self, s):
        value, charset = decode_header(s)[0]
        if charset:
            value = value.decode(charset)
        return value

    def guess_charset(self, msg):
        # 先从 msg 对象获取编码:
        charset = msg.get_charset()
        if charset is None:
            # 如果获取不到，再从 Content-Type 字段获取:
            content_type = msg.get('Content-Type', '').lower()
            pos = content_type.find('charset=')
            if pos >= 0:
                charset = content_type[pos + 8:].strip()
        return charset

    def get_mail_content(self):
        content_type = self.msg.get_content_type()
        if content_type == 'text/plain' or content_type == 'text/html':
            content = self.msg.get_payload(decode = True)
            charset = self.guess_charset(self.msg)
            if charset:
                content = content.decode(charset)  # 取得信件內文
                return content

    def search_mail_title(self, test_mail_title, expected_title, identification=None):
        """
        1. 目標是解決本來預期 test mail 後只會收到要收的信（一封）
        但如果收到的是數封信，而預期要收到的信又參雜在裡面那就會誤判
        所以應該是從第一封信逐一往後檢查一直到 test mail 為止
        2. 解決如果 test mail 後收到兩封一樣抬頭的信，這邊改用 identification 這個參數來做判別
        如果信中有出現設定的關鍵字，那才是符合測試需求的信件
        """
        index = 0
        compare_matched_index = []
        self.select_mail(index=index)
        mail_title = self.decode_str(self.msg['Subject'])
        while mail_title != test_mail_title:
            if mail_title == expected_title:
                compare_matched_index.append(index)
            index += 1
            self.select_mail(index=index)
            mail_title = self.decode_str(self.msg['Subject'])
        if len(compare_matched_index) == 1:  # 只有一封一樣名稱的信，無庸置疑就是這封
            return True
        elif len(compare_matched_index) > 1:  # 超過兩封一樣名稱的信，做第二輪檢查
            fin_res = 0
            for index in compare_matched_index:
                self.select_mail(index=index)
                mail_content = self.get_mail_content()
                if str(identification) in str(mail_content):  # 除了檢查信件名稱也檢查信件內文是否有關鍵字
                    fin_res += 1
            if fin_res == 1:  # 如果同時符合信件抬頭與內文關鍵字的信只有一封，那要的信就是這封了
                return True
            elif fin_res > 1:  # 如果同時符合信件抬頭與內文關鍵字的信不只一封，那可能需要更改關鍵字增加識別度
                raise AssertionError("信件名稱:'%s'\n關鍵字:'%s'\n關鍵字同時出現在在至少兩封以上的信件內容中，因無法辨識哪封為此次測試所寄故判定 FAIL，請改用一個更有鑑別度的關鍵字" % (expected_title, identification))
            else:
                raise AssertionError("沒有同時符合信件抬頭(expected_title)與信件內文(identification)的信件存在，請更改尋找的關鍵字(identification)")
        else:
            raise AssertionError("找不到叫做 '%s' 的信件名稱" % (expected_title))


    class LinkParser(HTMLParser):
        def __init__(self):
            HTMLParser.__init__(self)
            self.links = []

        def handle_starttag(self, tag, attrs):
            if tag != 'a':
                return
            self.links.append(dict(attrs)['href'])
