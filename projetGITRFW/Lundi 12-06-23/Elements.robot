*** Variables ***
${premiere variable}    Bonjour
${seconde variable}     Bonjour
${container}            Nantes
${item}                 Nantes
${JDD1}        ../Lundi 12-06-23/JDD.csv

# Open browser
${user_login}       standard_user
${user_password}    secret_sauce

# Par xPath de l'id
${user_login_champ}       //*[@id="user-name"]
${user_password_champ}    //*[@id="password"]

# Par "id" du bouton issu du code HTML
${login_button}    login-button
${first_name}    //*[@id="first-name"]
${last_name}    //*[@id="last-name"]