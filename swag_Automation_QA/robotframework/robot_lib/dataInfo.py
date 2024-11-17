# -*- coding: utf-8 -*-
from re import X


class data:
    def jenkins_username():
        jenkins_username = "jason"
        return jenkins_username
    
    def jenkins_pwd():
        jenkins_pwd = "1qaz2wsx"
        return jenkins_pwd
    
    def server_ip():
        server_ip = "10.0.1.251"
        return server_ip

    def ip():
        ip = "47.238.120.200"
        return ip

    def port():
        port = "8080"
        return port

    def bot_token():
        bot_token = "6968270418:AAGlX7tNpfnIuueB2hAssZWzwuNCMjR6ryE"
        return bot_token

    def chat_id():
        chat_id = "-4181504714"
        return chat_id

    def report_path(job_name, build_number):
        path = "C:/ProgramData/Jenkins/.jenkins/jobs/"+job_name+"/builds/"+build_number+"/robot-plugin/report.html"
        return path

    def secret_key():
        secret_key = "OVR24IJFAB3X5JL2"
        return secret_key
