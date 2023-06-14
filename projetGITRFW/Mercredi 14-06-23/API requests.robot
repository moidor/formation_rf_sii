*** Settings ***
Library    JSONLibrary
Library    RequestsLibrary
Library    DateTime

*** Variables ***
${url}    https://jsonplaceholder.typicode.com
${url_post}    https://jsonplaceholder.typicode.com/posts


*** Test Cases ***
Tester API requete GET
    Create Session    ma_session_get    ${url}
    ${reponse}    GET On Session    ma_session_get    ${url}/posts    expected_status=200
    Request Should Be Successful

    # Variables issues de la requête GET
    ${code}    Set Variable    ${reponse.status_code}
    ${headers}    Set Variable    ${reponse.headers}
    ${content}    Set Variable    ${reponse.content}
    ${reason}    Set Variable    ${reponse.reason}

    # Logs
    Log    ${headers}
    Log    ${content}
    Log    ${code}
    Log    ${reason}

    # Récupération de différentes valeurs en vue de les manipuler
    # 1. Manipulation du code retour de la requête
    Status Should Be    200
    Should Be Equal As Strings  OK    ${reason}
    Should Be Equal As Integers    200    ${code}
        
    # 2. Manipulation des headers de la requête
    Should Not Be Empty    ${headers}
    ${JSON_value} =     Get Value From Json    ${headers}     [Date]
    Log    ${JSON_value}    
    # Récupération de la date
    ${currentDate}=    Get Current Date    time_zone=UTC    result_format=%a, %d %b %Y %H:%M:%S
    Should Start With    ${headers}[Date]    ${currentDate}

    # 3. Manipulation du contenu de la requête
    ${Conversion en JSON} =    To Json    ${content}
    ${Content_JSON_value} =     Get Value From Json    ${Conversion en JSON}     $[1][title]    fail_on_empty=${True}
    Log    ${Content_JSON_value}  
    
Tester API requete POST
    Create Session    ma_session_post    ${url}
    Session Exists    ma_session_post    
    ${body}=    Create Dictionary    title="foo"    body="Robot Framework"    userId="25"    id="101"
    ${header_post}=    Create Dictionary    Content-Type="application/json"    

    ${response}=    POST On Session    ma_session_post    ${url}/posts    data=${body}    headers=${header_post}
    ${strContent}=    Convert To String    ${response.reason}
    Should Contain    ${strContent}    Created
    Should Be Equal As Integers    ${response.status_code}    201

    Log    ${response.headers}
    Log    ${response.content}
    Log    ${response.status_code}
    Log    ${response.reason}


Exercice fichier JSON
    ${json_obj}=    Load Json From File    C:\\Users\\Formation\\Desktop\\projetGITRFW\\Mercredi 14-06-23\\data.json
    ${json_data1}=    Get Value From Json    ${json_obj}    $.name
    Log    ${json_data1}
    ${json_data2}=    Get Value From Json    ${json_obj}    $.translations
    Log    ${json_data2}
    # Récupération du code de l'objet au sein du tableau Currencies
    ${json_data3}=    Get Value From Json    ${json_obj}    $.currencies[1].code
    Log    ${json_data3}

