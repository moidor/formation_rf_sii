*** Settings ***
Documentation    
...    Accéder à eBay
...    Rechercher "iPhone 14 pro max"
...    Récupérer les 3 premiers résultats
...    Sélectionner le moins cher
...    Vérifier le panier

Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${refus des cookies}    //*[@id="gdpr-banner-decline"]
${barre de recherche}    //*[@id="gh-ac"]
@{liste des produits trouves}    Get WebElements    //*[@id="srp-river-results"]/ul/li
${nb}     Get Length    ${liste des produits trouves}


*** Test Cases ***
Accéder à ebay.fr
    [Documentation]    Après la connexion au site ebay.fr, refus des cookies
    Ouvrir navigateur pour accéder à ebay.fr
    Sleep    3
    Click Button    ${refus des cookies}
    Rechercher un iphone 14 Pro Max
    Recuperer la liste des produits trouves


*** Keywords ***
Ouvrir navigateur pour accéder à ebay.fr
    Open Browser    https://www.ebay.fr/    chrome
    Maximize Browser Window

Rechercher un iphone 14 Pro Max
    Input Text    ${barre de recherche}    iPhone 14 Pro Max
    Click Button    //*[@id="gh-btn"]

Recuperer la liste des produits trouves    
    @{ListElements}    Get WebElements    //*[@id="srp-river-results"]/ul/li
    @{liste des 3 premiers}    Create List
    FOR    ${element}    IN    ${ListElements}
        Log    ${element}
        ${texte element}     Get Text    ${element}
        Log    ${texte element}
        ${contains}   Should Contain    ${element.text}    EUR
        run keyword if     'EUR' in '${element}'    Run Keyword   
        ...    Append To List    ${liste des 3 premiers}    ${element}
                        
            ${longueur liste}    Get Length    ${liste des 3 premiers}
            Exit For Loop If    ${longueur liste}==3
        END
    Log    ${liste des 3 premiers}
    FOR    ${element}    IN    @{liste des 3 premiers}
        Log    ${element.text}
    END




    # Créer une liste d'une longueur maximum de 3
    # Insérer chaque produit qui contient EUR && iPhone
    # Comparer les prix et sélectionner le moins cher
    



#Exit For Loop If    ${liste des 3 premiers.__len__()} == 3
    # FOR    ${mon_element}    IN    @{liste des produits trouves}
    #     Log    ${mon_element}
    # END
    # Log To Console    ${nb}
    # FOR    ${i}    IN RANGE    2    ${nb-1}
    #     ${text}    Get Text    //*[@id="srp-river-results"]/ul/li[${i}]
    #     Log    ${text}
    # END

    