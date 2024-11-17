import requests
import jenkins
import json
import yaml
import re
from bs4 import BeautifulSoup

class parsingJenkinsInfo :
    def getJobData(j):
        data = j.get_jobs()
        return data

    def getJobName(data):
        fullname = data[0]['fullname']
        return fullname
    
    def getURL(data):
        url = data[0]['url']
        return url

    def getLastBuildData(j, job_name):
        data = j.get_job_info(job_name)
        lastBuildData = data['lastBuild']
        return lastBuildData
        
    def getLastBuildNumber(data):
        lastBuildNumber = data['number']
        return lastBuildNumber
    
    def getLastBuildURL(data):
        lastBuildURL = data['url']
        return lastBuildURL
    
    def getBuildJobInfo(j, job_name, job_number):
        job_info = j.get_build_info(job_name, job_number)
        return job_info

    def getTriggerName(job_info):
        user_name = job_info['actions'][1]['causes'][0]['userName']
        return user_name

    def getBranch(job_info):
        try:
            branch_name = job_info['actions'][0]['parameters'][0]['value']  #手動觸發
        except (IndexError, KeyError, TypeError):

            try:
                branch_name = job_info['actions'][1]['parameters'][0]['value']  #排程觸發
            except (IndexError, KeyError, TypeError):

                branch_name = None
        return branch_name

    def getResult(user_name, pwd, ip, port, job_name, number):
        page = requests.get("http://"+user_name+":"+pwd+"@"+ip+":"+port+"/job/"+job_name+"/"+number+"/console")
        soup = BeautifulSoup(page.text, 'html.parser')
        soup_text = soup.find('pre')
        consoleLog = soup_text.prettify()
        consoleLogList = consoleLog.split('\n')
        lenth = len(consoleLogList)
        for lenth in range(lenth) :
            if 'TestCase                                                              | ' in consoleLogList[lenth] :
                resultInfo = consoleLogList[lenth]
            lenth-=1
        order = consoleLogList.index(resultInfo)
        print(order)
        resultInfo_target = consoleLogList[order+1]
        resultList = resultInfo_target.split(',')
        passed = re.sub(' passed','',resultList[1])
        failed = re.sub(' failed','',resultList[2])
        return passed, failed

    def getTestResults(report_file):
        with open(report_file, 'r', encoding='utf-8') as file:
            html_content = file.read()
        soup = BeautifulSoup(html_content, 'html.parser')
        script_tag = soup.find('script', text=re.compile(r'window\.output\["stats"\]'))
        if script_tag:
            script_content = script_tag.string
            # 使用正規表示式找到 JavaScript
            match = re.search(r'window\.output\["stats"\]\s*=\s*(\[\[.*?\]\])', script_content)
            if match:
                json_data = match.group(1)
                stats_data = json.loads(json_data)
        # 提取第一個列表中的第一個dic
        first_entry = stats_data[0][0]
        # 取得資料
        elapsed = first_entry['elapsed']
        pass_ = first_entry['pass']
        fail_ = first_entry['fail']
        return pass_, fail_

    def getSkin(job_name, branch):
        with open('C:/ProgramData/Jenkins/.jenkins/workspace/'+job_name+'/'+branch+'_domain.yaml', 'r', encoding='utf-8') as file:
            data = yaml.safe_load(file)
            skin_value = data.get('SKIN')
            skin_value = "白金" if skin_value is None else skin_value
        return skin_value
