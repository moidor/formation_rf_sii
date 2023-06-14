*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    Elements.robot
Resource    Fonctions.robot 
Test Setup        Ouvrir navigateur
Test Teardown     Close Browser


*** Test Cases ***
Consulter les logs
    Log To Console    "Mon premier message"
    Should Be Equal As Strings    ${premiere variable}    ${seconde variable}
    # Run Keyword And Continue On Failure    Should Be Equal As Strings    ${premiere variable}    Au revoir
    Should Be Equal As Integers    1    1


Doit contenir
    Should Contain    ${container}    ${item}
    Should Not Contain    Robot Framework    Python
    Should Start With     Bonjour    Bon
    Should End With       Salut !    !

Accéder à une page web
    Open Browser    https://www.saucedemo.com/    chrome
    Maximize Browser Window
    Get Window Titles    CURRENT
    Input Text    ${user_login_champ}    ${user_login}
    # Capture Element Screenshot    ${user_login_champ}
    Input Text    ${user_password_champ}    ${user_password}
    # ${button_locator}    Get Element Attribute    //*[@id="login-button"]    value
    # Log To Console    ${button_locator}
    Click Button    ${login_button}
    
    # Sélection du produit "Sauce Labs Bike Light" dans le catalogue
    ${product_title_catalog}    Get Text    //*[@id="item_0_title_link"]/div
    ${product_price_catalog}    Get Text    //*[@id="inventory_container"]/div/div[2]/div[2]/div[2]/div
    ${price_catalog_without_dollar}    Get Substring    ${product_price_catalog}    1
    Click Button    //*[@id="add-to-cart-sauce-labs-bike-light"]

    # Section dans le panier de commandes
    Click Link    //*[@id="shopping_cart_container"]/a
    ${product_title_cart}    Get Text    //*[@id="item_0_title_link"]/div
    ${product_price_cart}    Get Text    //*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[2]/div
    ${price_cart_without_dollar}    Get Substring    ${product_price_catalog}    1
    # Comparaison du nom du produit entre le catalogue et le panier
    Should Be Equal As Strings    ${product_title_catalog}    ${product_title_cart}

    # Comparaison du prix du produit entre le catalogue et le panier
    Should Be Equal  ${price_catalog_without_dollar}    ${price_cart_without_dollar}
    ${product_description}    GET Text    //*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[1]

    Should Contain    ${product_description}    the desired state
    Log To Console    Catalogue : ${product_title_catalog} - Panier : ${product_title_cart}

    # Checkout
    Click Button    //*[@id="checkout"]
    Input Text    ${first_name}    Cham
    Input Text    ${last_name}    Zein
    Input Text    //*[@id="postal-code"]    44000
    Click Button    //*[@id="continue"]
    # Capture de la page de récapitulatif de la commande, finalisation puis retour à l'accueil
    Capture Page Screenshot
    Click Button    //*[@id="finish"]
    Click Button    //*[@id="back-to-products"]

Accéder à une page web avec un user bloqué
    [Tags]        erreur
    Ouvrir navigateur
    Input Text    ${user_login_champ}    locked_out_user
    Input Text    ${user_password_champ}    ${user_password}
    Click Button    ${login_button}

    ${message_erreur}    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${message_erreur}    Epic sadface: Sorry, this user has been locked out.

Connexion sans login
    [Tags]        erreur
    Ouvrir navigateur
    Input Text    ${user_login_champ}    ${EMPTY}
    Input Text    ${user_password_champ}    ${user_password}
    Click Button    ${login_button}

    ${message_erreur}    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${message_erreur}    Epic sadface: Username is required

Connexion sans mot de passe
    [Tags]        erreur
    Ouvrir navigateur
    Connexion formulaire login       standard_user
    Input Text    ${user_password_champ}    ${EMPTY}
    Click Button    ${login_button}

    ${message_erreur}    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${message_erreur}    Epic sadface: Password is required



