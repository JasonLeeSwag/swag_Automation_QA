# swag_Automation_QA\keyword\swag\Swag.sources.robot
*** Settings ***
Library    Process
Library    OperatingSystem
Library   ${EXECDIR}/robotframework/robot_lib/Calculate.py
Library   ${EXECDIR}/robotframework/robot_lib/GoogleAuthenticator.py

Resource  ../../robotframework/browser/browser_sources.robot
Resource  ../../robotframework/API/api_sources.robot
Resource  ../../robotframework/utilities/utilities_sources.robot

Resource  component/Swag_Footer.robot

Resource  domain/Swag_LoginService.robot

Resource  page/login/Swag_Login.robot

Resource  page/myprofile/settings/Swag_Settings.robot

Resource  page/myprofile/Swag_MyProfile.robot

Resource  page/register/Swag_Register.robot

Resource  page/video/Swag_Video.robot

Resource  page/Swag_Home.robot