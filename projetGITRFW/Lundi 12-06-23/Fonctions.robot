*** Settings ***
Library    SeleniumLibrary
Library    String
Library    ExcelLibrary
Resource    Elements.robot

*** Keywords ***
Ouvrir navigateur
    Open Browser    https://www.saucedemo.com/    chrome
    Maximize Browser Window

Connexion formulaire login
    [Arguments]    ${valeur}
    Input Text    ${user_login_champ}    ${valeur}

Connexion formulaire password
    [Arguments]    ${valeur}
    Input Text    ${user_password_champ}    ${valeur}

Recup JDD
    # [Arguments]     ${JDD}     feuille    ligne    colonne
    Open Excel Document    ${JDD1}     docname1
    ${data}=    Read Excel Cell    ligne    colonne    feuille
    [Return]    ${data}

# Fermer le navigateur
#     Close Browser
#     Log    Fermeture du navigateur