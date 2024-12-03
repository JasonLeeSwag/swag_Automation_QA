*** Settings ***
Library   DateTime

*** Keywords ***
Get System Date
    [Arguments]  ${datetime_basis}=now
    ${datetime_now}=    Run Keyword If  "${datetime_basis}"=="now"  Get Time  datetime  NOW
    ${datetime_other}=  Run Keyword If  "${datetime_basis}"!="now"  Get Time  datetime  NOW ${datetime_basis}
    # Set Variable Fot List That Are Not Empty
    ${datetime}=  Set Variable If  "${datetime_now}"=="None"   ${datetime_other}  ${datetime_now}
    # Covert Date To Python's DateTime Format
    ${datetime}=  Convert Date  ${datetime}  DateTime
    RETURN  ${datetime}

Convert Date/Time To Year/Month/Day String
    [Arguments]  ${datetime}
    ${datetime}=  Convert To String  ${datetime}
    ${datetime}=  Remove String Using Regexp  ${datetime}  (\\s\\d+:\\d+:\\d+)  # Remove Time
    RETURN  ${datetime}

Convert Date/Time To Day/Month/Year String
    [Arguments]  ${datetime}
    ${datetime} =     Convert To String  ${datetime}
    ${datetime} =     Remove String Using Regexp  ${datetime}  (\\s\\d+:\\d+:\\d+)  # Remove Time
    ${datetime_ls} =  Split String  ${datetime}  -
    ${dd} =           Get From List  ${datetime_ls}  2
    ${mm} =           Get From List  ${datetime_ls}  1
    ${yyyy} =         Get From List  ${datetime_ls}  0
    ${datetime} =     Set Variable  ${dd}-${mm}-${yyyy}
    RETURN  ${datetime}

Get Epoch Time
    [Arguments]  ${time}=
    Run Keyword And Return If  "${time}" == "${EMPTY}"  Get Time  epoch
    Run Keyword And Return  Get Time  epoch  ${time}

Get Time In Timezone New York
    [Arguments]  ${datetime}
    ${new_york_time} =  Add Time To Date    ${datetime}      -12 hours
    ${new_york_time}=   Convert Date        ${new_york_time}  DateTime    %Y-%m-%d %H:%M:%S
    RETURN  ${new_york_time}
