*** Settings ***
Library   ../functions/api_functions.py
Resource    ../functions/API_keywords.robot

*** Test Cases ***

Task 1:Create Transaction
    [Documentation]  This test case will create new transaction
    ${amt1}    getRandomNumber
    ${amt2}    getRandomNumber
    set suite variable   ${amt1}
    set suite variable   ${amt2}
    ${user_body} =    Catenate    SEPARATOR=    {"coin1": "INR","coin2":"USTD","coin1Amount":${amt1},  "coin2Amount":${amt2}    }
    ${res}   Make post call and return Response        /transaction   ${user_body}
    ${json_res}    set variable   ${res.json()}
    should be equal as strings   ${res.status_code}   200
    should be equal as strings   ${json_res["sentCoinAmount"]}   ${amt1}
    should be equal as strings   ${json_res["receivedCoinAmount"]}    ${amt2}
    should be equal as strings   ${json_res["sentCoin"]}   INR
    should be equal as strings   ${json_res["receivedCoin"]}    USTD
    ${id}   set variable   ${json_res["id"]}
    set suite variable   ${id}

Task 2 : Get Transaction details
    ${tran_details}    Get Transaction Details and return response    /transaction/${id}
    ${tran_json}   set variable     ${tran_details.json()}
    should be equal as strings   ${tran_details.status_code}   200
    should be equal as strings   ${tran_json["id"]}   ${id}
    should be equal as strings   ${tran_json["sentCoinAmount"]}   ${amt1}
    should be equal as strings   ${tran_json["receivedCoinAmount"]}    ${amt2}
    should be equal as strings   ${tran_json["sentCoin"]}   INR
    should be equal as strings   ${tran_json["receivedCoin"]}    USTD
    ${amt3}   return_divided_value   ${amt1}     ${amt2}
    should be equal as strings   ${tran_json["receivedCoinMarketPrice"]}     ${amt3}


