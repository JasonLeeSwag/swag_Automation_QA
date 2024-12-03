*** Settings ***
Library   Screenshot

*** Variables ***
&{PageAction}
...                     screenshot_index=${0}

*** Keywords ***
Scroll Page
    [Arguments]         ${direction}
    ${direction} =      Convert To Uppercase        ${direction}
    Run Keyword If      '${direction}' == 'DOWN'    Execute Javascript  window.scrollTo(0, document.body.scrollHeight);
    Run Keyword If      '${direction}' == 'UP'      Execute Javascript  window.scrollTo(0, 0);
    Run Keyword If      '${direction}' == 'RIGHT'   Execute Javascript  window.scrollTo(document.body.scrollWidth, 0);
    Run Keyword If      '${direction}' == 'LEFT'    Execute Javascript  window.scrollTo(-document.body.scrollWidth, 0);

Scroll Page To Location
    [Arguments]  ${x}=0  ${y}=0
    Execute JavaScript  window.scrollTo( ${x}, ${y} )

Scroll One Page
    [Arguments]  ${direction}
    ${direction} =      Convert To Uppercase        ${direction}
    Run Keyword If      '${direction}' == 'DOWN'    Execute Javascript  window.scrollBy(0, screen.height);
    Run Keyword If      '${direction}' == 'UP'      Execute Javascript  window.scrollBy(0, -screen.height);

Scroll Particular Element By Id
    [Arguments]  ${id_name}
    Execute Javascript  window.document.getElementById("${id_name}").scrollIntoView(true);

Scroll Particular Element By Class
    [Documentation]  For leftMenu Parlay Proceess Bet Btn
    [Arguments]  ${class_name}
    Execute JavaScript  window.document.getElementsByClassName("${class_name}")[1].scrollIntoView(true);

Zoom Page
    [Documentation]  請填入浮點數 ex:size=0.9，預設調回 1
    [Arguments]  ${size}=1  ${zoom_page_delay}=1s
    Execute Javascript  document.body.style.zoom = '${size}'
    Sleep  ${zoom_page_delay}

保存網頁截圖
    ${fileName} =            PageAction.取得檔案名稱
    Capture Page Screenshot  ${fileName}-{index}.png

保存螢幕截圖
    ${index} =               PageAction.取得截圖編號
    ${fileName} =            PageAction.取得檔案名稱
    Take Screenshot          ${fileName}-${index}

向下捲動部份頁面
    [Documentation]  在特定螢幕解析度下 避免連結被遮蔽
    [Arguments]  ${jsExpression}=screen.height / 4
    ${pixel} =  Execute Javascript  return ${jsExpression}
    Log  ${pixel}
    Scroll Page To Location  0  ${pixel}

取得檔案名稱
    @{time} =                Get Time  year month day hour min sec
    ${fileName} =            Catenate  SEPARATOR=  @{time}
    RETURN  ${fileName}

取得截圖編號
    ${index} =               Get Variable Value              ${PageAction.screenshot_index}  ${0}
    Set Global Variable      ${PageAction.screenshot_index}  ${index.__add__( 1 )}
    RETURN  ${PageAction.screenshot_index}