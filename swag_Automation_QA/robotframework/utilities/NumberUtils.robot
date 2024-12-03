*** Keywords ***
Get Random One Number
    [Arguments]  ${start}=0  ${end}=100
    ${random_int} =	Evaluate	random.randint(${start}, ${end})	modules=random
    RETURN  ${random_int}

Get Random Number
    [Arguments]  ${length}  ${int}=0123456789
    ${random_int} =  Generate Random String  ${length}  ${int}
    RETURN  ${random_int}

Get Random Number With Alphabet
    [Arguments]  ${length}=10
    ${random_str} =  Generate Random String  ${length}
    RETURN  ${random_str}
