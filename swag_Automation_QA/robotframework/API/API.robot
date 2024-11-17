# C:\Users\crazy\Downloads\code\swag\swag_Automation_QA\robotframework\API\api_sources.robot
*** Variables ***
&{API}  PROXY_URL=http://xx.xxx.xxx.xx
...     PROXY_PORT=xxxx

*** Keywords ***
Get Proxy Dictionary
    Run Keyword And Return  Create Dictionary
    ...  http=${API.PROXY_URL}:${API.PROXY_PORT}
    ...  https=${API.PROXY_URL}:${API.PROXY_PORT}

Log Json Response
    [Arguments]  ${response}
    Log             "response.status=" ${response.status_code}
    ${json_dump}=  Json To String  ${response.json()}
    ${pretty_json}=  Pretty Print Json  ${json_dump}
    Log             ${pretty_json}
    RETURN  ${json_dump}

Set String To Json
    [Documentation]  請使用  json_string  key1  value1  key2  value2  設定
    [Arguments]  ${json_string}  @{key_value_pairs}
    ${json}=  Json To Dictionary  ${json_string}
    Set To Dictionary  ${json}  @{key_value_pairs}
    ${json_stringify}=  Dictionary To Json  ${json}
    RETURN  ${json_stringify}

Set Number To Json
    [Documentation]  請使用  json_string  key1  value1  key2  value2  設定
    [Arguments]  ${json_string}  @{key_value_pairs}
    ${json}=  Json To Dictionary  ${json_string}
    FOR  ${key}  ${value}  IN  @{key_value_pairs}
        Set To Dictionary  ${json}  ${key}  ${${value}}
    END
    ${json_stringify}=  Dictionary To Json  ${json}
    RETURN  ${json_stringify}

Set Array To Json
    [Documentation]  請使用  json_string  key1  value1  key2  value2  設定
    [Arguments]  ${json_string}  @{key_value_pairs}
    ${json}=  Json To Dictionary  ${json_string}
    FOR  ${key}  ${value}  IN  @{key_value_pairs}
        ${value_list}=  Json To Dictionary  ${value}
        Set To Dictionary  ${json}  ${key}  ${value_list}
    END
    ${json_stringify}=  Dictionary To Json  ${json}
    RETURN  ${json_stringify}

Set Object To Json
    [Documentation]  請使用  json_string  key1  value1  key2  value2  設定
    [Arguments]  ${json_string}  @{key_value_pairs}
    ${json}=  Json To Dictionary  ${json_string}
    FOR  ${key}  ${value}  IN  @{key_value_pairs}
        ${value_dict}=  Json To Dictionary  ${value}
        Set To Dictionary  ${json}  ${key}  ${value_dict}
    END
    ${json_stringify}=  Dictionary To Json  ${json}
    RETURN  ${json_stringify}

Json To Dictionary
    [Arguments]  ${json_string}
    Run Keyword And Return  Evaluate  json.loads('''${json_string}''')  json

Dictionary To Json
    [Arguments]  ${dict}
    Run Keyword And Return  Evaluate  json.dumps(${dict})    json

# element 比較
取得Json元素
    [Documentation]  使用JsonPath
    [Arguments]  ${json_string}  ${expr}  ${index}=${EMPTY}
    ${elements}=  JsonValidator.Get Elements  ${json_string}  ${expr}
    ${return_data} =  Set Variable If
    ...                         "${index}" == "${EMPTY}"    ${elements}
    ...                       ELSE
    ...                         @{elements}[${index}]
    Log     ${return_data}
    RETURN  ${return_data}

Json元素需相等
    [Arguments]  ${json_string}  ${expr}  ${expected_value}  ${index}=0
    ${element}=  API.取得Json元素  ${json_string}  ${expr}  ${index}
    Should Be Equal  ${element}  ${expected_value}
