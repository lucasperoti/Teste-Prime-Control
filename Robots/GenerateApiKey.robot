*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}      Chrome
${ip}       201.13.103.203


*** Test Cases ***
Generate API KEY
    [Documentation]     Fazer o login na pagina e gerar a key para a api
    Open Browser To LOGIN Page      ${endereco}
    Login In Clash                  ${usuario}  ${senha}
    Navegate To Generate Key Page
    Generate Key    ${nomeKey}      ${descricao}    

*** Keywords ***
Open Browser To LOGIN Page 
    [Arguments]   ${endereco}  
    Open Browser  ${endereco}  ${BROWSER}
    Maximize Browser Window  
    Wait Until Page Contains Element  //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    click Link                        //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
Login In Clash
    [Arguments]     ${usuario}      ${senha}
    Wait Until Page Contains Element  //input[@id="email"]
    Input Text      //input[@id="email"]     ${usuario}
    Input Password  //input[@id="password"]  ${senha}
    Click Button    //button[@type="submit"]
Navegate To Generate Key Page  
    Wait Until Page Contains Element  //button[@data-toggle="dropdown"]  
    Click Element   //button[@data-toggle="dropdown"]  
    Click Element   //a[@data-reactid=".0.2.0.0.0.0.2.0.0.1.0.0"]
Generate Key
    [Arguments]     ${nomeKey}      ${descricao}
    Wait Until Page Contains Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Click Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Wait Until Page Contains Element  //textarea[@id="description"]
    Input Text  //input[@id="name"]  ${nomeKey}
    Input Text  //textarea[@id="description"]  ${descricao}
    Input Text  //input[@id="range-0"]  ${ip}
    Click Button  //button[@type="submit"]