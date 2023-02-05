*** Settings ***
Library           RequestsLibrary
Resource      ../Config.txt
Library    JSONLibrary

*** Variables ***

*** Keywords ***
Make post call and return Response
    [Arguments]   ${uri}   ${payload}
    Create Session    create_tran    ${base_url}
    ${tran_res}=    post on session    create_tran    ${uri}    data=${payload}
    [Return]       ${tran_res}

Get Transaction Details and return response
    [Arguments]   ${uri}
    Create Session    get_tran    ${base_url}
    ${get_res}=    get on session    get_tran    ${uri}
    [Return]       ${get_res}


