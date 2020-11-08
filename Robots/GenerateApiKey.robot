*** Settings ***
Library     SeleniumLibrary
Library     ../Libraries/ApiConsumer.py
Library     ../Libraries/Logger.py
                

*** Variables ***
${BROWSER}      Chrome
${ip}       201.13.103.203    
${Key}  
${Status}

*** Test Cases ***
Generate CSV 
    [Documentation]    Faz o login na pagina e gera o arquivo csv.
    Open Browser To LOGIN Page      ${endereco}
    Login In Clash                  ${usuario}  ${senha}
    Navegate To Generate Key Page
    Generate Key    ${nomeKey}      ${descricao}   
    Get API KEY
    Generate CSV FILE  ${Key}

*** Keywords ***
Open Browser To LOGIN Page 
    [Documentation]     Acessa a pagina de login.
    [Arguments]   ${endereco}  
    Logger        INFO      Abrindo Browser e navengando ate a tela de login.
    Open Browser  ${endereco}  ${BROWSER}        
    Maximize Browser Window  
    ${Status}   Run Keyword And Return Status    Wait Until Page Contains Element  //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    Run Keyword If  ${Status} is False  Logger  ERROR    Pagina nao encontrada.
    click Link    //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    Logger        INFO      Abrindo pagina de Login
Login In Clash
    [Documentation]     Executa o Login na pagina de login.
    [Arguments]     ${usuario}      ${senha}
    Logger        INFO        Realizando login
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //input[@id="email"]
    Run Keyword If  ${Status} is False  Logger  ERROR    Pagina nao encontrada.
    Input Text      //input[@id="email"]     ${usuario}
    Input Password  //input[@id="password"]  ${senha}
    Click Button    //button[@type="submit"]
    
Navegate To Generate Key Page  
    [Documentation]     Navega ate a pagina de geraçao da API Key.
    Wait Until Page Contains Element  //button[@data-toggle="dropdown"]  
    Click Element   //button[@data-toggle="dropdown"]  
    Click Element   //a[@data-reactid=".0.2.0.0.0.0.2.0.0.1.0.0"]
Generate Key
    [Documentation]     Gera a API KEY.
    [Arguments]     ${nomeKey}      ${descricao}
    Wait Until Page Contains Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Click Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Wait Until Page Contains Element  //textarea[@id="description"]
    Input Text     //input[@id="name"]  ${nomeKey}
    Input Text     //textarea[@id="description"]  ${descricao}
    Input Text     //input[@id="range-0"]  ${ip}
    Click Button   //button[@type="submit"]
Get API KEY
    [Documentation]     Obter a API KEY gerada.
    Wait Until Page Contains Element  //span[@class="dev-site-icon-key dev-site-icon"][1]
    Click Element       //span[@class="dev-site-icon-key dev-site-icon"][1]  
    Wait Until Page Contains Element  //samp[@data-reactid=".0.2.0.1.0.0.0.1.0.0.1.0"]  
    ${Key}  Get Text    //samp[@data-reactid=".0.2.0.1.0.0.0.1.0.0.1.0"] 
    Set Global Variable     ${Key}  
Generate CSV FILE
    [Documentation]     Escreve no Arquivo csv o resultado da lista obtida atraves da api.
    [Arguments]         ${Key}
    Generate CSV        ${Key}