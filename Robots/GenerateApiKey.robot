*** Settings ***
Library     SeleniumLibrary
Library     ./Libraries/config.py

*** Variables ***
${BROWSER}      Chrome


*** Test Cases ***
Generate API KEY
    [Documentation]     Fazer o login na pagina e gerar a key para a api
    Open Browser To LOGIN Page      ${endereco}
    Login In Clash  ${usuario}  ${senha}

*** Keywords ***
Open Browser To LOGIN Page 
    [Arguments]   ${endereco}  
    Open Browser  ${endereco}  ${BROWSER}
    Maximize Browser Window  
    Wait Until Page Contains Element  //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    click Link   //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
Login In Clash
    [Arguments]      ${usuario}      ${senha}
    Wait Until Page Contains Element  //input[@id="email"]
    Input Text  //input[@id="email"]  ${usuario}
    Input Password  //input[@id="password"]  ${senha}
    Click Button  //button[@type="submit"]