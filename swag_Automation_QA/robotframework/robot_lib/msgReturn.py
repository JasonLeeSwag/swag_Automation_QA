# -*- coding: utf-8 -*-
import requests # type: ignore
import jenkins # type: ignore
import telegram # type: ignore
import asyncio
import json
from dataInfo import data
from jenkinsInfo import parsingJenkinsInfo as JenkinsInfo


j = jenkins.Jenkins("http://"+data.server_ip()+":"+data.port(), username=data.jenkins_username(), password=data.jenkins_pwd())
jobData = JenkinsInfo.getJobData(j)
jobName = JenkinsInfo.getJobName(jobData)
lastBuildData = JenkinsInfo.getLastBuildData(j, jobName)
lastBuildNumber = JenkinsInfo.getLastBuildNumber(lastBuildData)
lastBuildURL = JenkinsInfo.getLastBuildURL(lastBuildData)
job_info = JenkinsInfo.getBuildJobInfo(j, jobName, lastBuildNumber)
# userName = JenkinsInfo.getTriggerName(job_info)
# branchName = JenkinsInfo.getBranch(job_info)
passed, failed = JenkinsInfo.getTestResults(data.report_path(jobName, str(lastBuildNumber)))
# skin = JenkinsInfo.getSkin(jobName, branchName)
ip = data.ip()
port = data.port()
tgBot_token = data.bot_token()
tgChat_id = data.chat_id()

# BuildNameStr = jobName+"\n"
# SkinStr = "- Skin: "+str(skin)+"\n"+"\t"
# TriggerStr = "- Trigger: "+userName+"\n"+"\t"
# EnvironmentStr = "- Environment: "+branchName+"\n"+"\t"
# ResultStr = "- Passed: "+str(int(passed))+" ,  Failed: "+str(int(failed))+"\n"+"\t"
# LogStr = "- Log(#"+str(lastBuildNumber)+"): "+lastBuildURL+"robot/report/log.html"
# success_msg = "✅ PASS ✅"+"\n"+BuildNameStr+"Test Status: "+"\n"+"\t"+SkinStr+TriggerStr+EnvironmentStr+ResultStr+LogStr
# fail_msg = "❌ FAIL ❌"+"\n"+BuildNameStr+"Test Status: "+"\n"+"\t"+SkinStr+TriggerStr+EnvironmentStr+ResultStr+LogStr


output = {
    # 'skin': skin,
    # 'trigger': userName,
    # 'environment': branchName,
    'passed': passed,
    'failed': failed,
    'number': lastBuildNumber,
    'ip': ip,
    'port': port,
    'bot_token': tgBot_token,
    'chat_id': tgChat_id
}

print(json.dumps(output))


# async def main(msg):
#     bot = telegram.Bot(token=data.bot_token())
#     await bot.send_message(chat_id=data.chat_id(), text=msg)

# if str(int(failed)) != '0':
#     asyncio.run(main(fail_msg))
# else:
#     asyncio.run(main(success_msg))
