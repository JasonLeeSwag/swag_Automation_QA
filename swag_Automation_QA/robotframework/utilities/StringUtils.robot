*** Keywords ***
Get String Length
    [Documentation]  全形會被判斷為長度 2
    [Arguments]  ${string}
    # 半形
    ${half_char_list}=  Get Regexp Matches  ${string}  [\x00-\xff]
    ${half_length}=  Get Length  ${half_char_list}
    # 全形
    ${all_char_list}=  Get Regexp Matches  ${string}  [^\x00-\xff]
    ${all_length}=  Get Length  ${all_char_list}
    # Sum
    ${char_length}=  Evaluate  ${half_length} + ${all_length} * 2
    RETURN  ${char_length}

String Url Encode
    [Arguments]  ${str}
    # python2
    ${Encode_Status}  ${Encode_Result}=  Run Keyword And Ignore Error  Evaluate  urllib.quote_plus( "${str}" )  modules=urllib
    # python3
    Run Keyword And Return If  "${Encode_Status}" == "FAIL"
    ...  Evaluate  urllib.parse.quote_plus( "${str}" )  modules=urllib
    RETURN  ${Encode_Result}

Catenate Xpth For Container
    [Arguments]  ${baseXpth}  ${abbreviation}  @{values}
    ${xpath} =      Set Variable  ${baseXpth}
    :FOR  ${value}  IN  @{values}
    \  ${xpath} =   Catenate      SEPARATOR=  ${xpath}  [ contains( ${abbreviation}, "${value}" ) ]
    RETURN  ${xpath}