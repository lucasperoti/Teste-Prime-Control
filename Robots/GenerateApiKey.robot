*** Settings ***
Library     SeleniumLibrary
Library     ../Libraries/ApiConsumer.py
Library     ../Libraries/Logger.py
                

*** Variables ***
${BROWSER}      Chrome
${ip}           
${Key}  
${Status}

*** Test Cases ***
Generate CSV 
    [Documentation]    Faz o login no site de api do clash of clans, cria um token e o utiliza para gerar um  arquivo csv com o resultado de uma chamada de api,retornando os membros do clan.  
    Open Browser To LOGIN Page      ${endereco}
    Login In Clash                  ${usuario}  ${senha}
    Navegate To Generate Key Page
    Generate Key    ${nomeKey}      ${descricao}   
    Get API KEY
    Generate CSV FILE  ${Key}
    Terminate

*** Keywords ***
Open Browser To LOGIN Page 
    [Documentation]     Acessa a pagina de login.
    [Arguments]   ${endereco}  
    Logger        INFO  Abrindo Browser e navengando ate a tela de login.
    Open Browser  ${endereco}  ${BROWSER}        
    Maximize Browser Window  
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    Run Keyword If  ${Status} is False  Logger  ERROR    Pagina inicial nao encontrada.
    Run Keyword If  ${Status} is False  Close Browser
    click Link    //a[@data-reactid=".0.2.0.0.0.0.2.0.2"]
    Logger        INFO  pagina de login
    
Login In Clash
    [Documentation]     Executa o Login na pagina de login.
    [Arguments]     ${usuario}      ${senha}
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //input[@id="email"]
    Run Keyword If  ${Status} is False  Logger  ERROR    Pagina de login nao encontrada.
    Run Keyword If  ${Status} is False  Terminate
    Logger        INFO        Digitando usuario e senha
    Input Text      //input[@id="email"]     ${usuario}
    Input Password  //input[@id="password"]  ${senha}
    Click Button    //button[@type="submit"]
    ${Status}   Run Keyword And Return Status  Wait Until Page Contains Element   //span[@data-reactid=".0.2.0.1.0.0.0.0.1.0.0.2"]  
    Run Keyword If  ${Status} is True  Logger  ERROR     Login ou senha incorretos.
    Run Keyword If  ${Status} is True  Terminate
    
Navegate To Generate Key Page  
    [Documentation]     Navega ate a pagina de geraçao da API Key.
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //button[@data-toggle="dropdown"]
    Run Keyword If  ${Status} is False  Logger  ERROR   Menu inicial nao encontrado. 
    Run Keyword If  ${Status} is False  Terminate
    Click Element   //button[@data-toggle="dropdown"]  
    Logger  INFO    Selecionando item My account no dropdown menu
    Click Element   //a[@data-reactid=".0.2.0.0.0.0.2.0.0.1.0.0"]
    
Generate Key
    [Documentation]     Gera a API KEY.
    [Arguments]     ${nomeKey}      ${descricao}
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Run Keyword If  ${Status} is False  Logger  ERROR   Pagina de geraçao de API KEY nao encontrada.
    Run Keyword If  ${Status} is False  Terminate
    Logger  INFO    Gerando a API KEY
    Click Element  //span[@data-reactid=".0.2.0.1.1.0.0.1.1.0.1"]
    Wait Until Page Contains Element  //textarea[@id="description"]
    Input Text     //input[@id="name"]  ${nomeKey}
    Input Text     //textarea[@id="description"]  ${descricao}
    ${ip}   get_ip
    Input Text     //input[@id="range-0"]  ${ip}
    Click Button   //button[@type="submit"]
    Logger  INFO    API KEY gerada com sucesso
    

Get API KEY
    [Documentation]     Obter a API KEY gerada.
    ${Status}   Run Keyword And Return Status   Wait Until Page Contains Element  //span[@class="dev-site-icon-key dev-site-icon"][1]
    Run Keyword If  ${Status} is False  Logger  ERROR   Pagina com a chave gerada nao encontrada.
    Run Keyword If  ${Status} is False  Terminate
    Click Element       //span[@class="dev-site-icon-key dev-site-icon"][1]  
    ${Status}   Run Keyword And Return Status  Wait Until Page Contains Element  //samp[@data-reactid=".0.2.0.1.0.0.0.1.0.0.1.0"]  
    Run Keyword If  ${Status} is False  Logger  ERROR   Token nao encontrado.
    Run Keyword If  ${Status} is False  Terminate
    Logger  INFO    Token encontrado com sucesso
    ${Key}  Get Text    //samp[@data-reactid=".0.2.0.1.0.0.0.1.0.0.1.0"] 
    Set Global Variable     ${Key}  

Generate CSV FILE
    [Documentation]     Escreve no Arquivo csv o resultado da lista obtida atraves da api.
    [Arguments]         ${Key}
    Logger  INFO    Gerando o arquivo CSV
    Generate CSV        ${Key}

Terminate
    Logger  INFO    Fechando BROWSER
    Close Browser       

# para executar o processo utilizar seguinte comando : pipenv run robot -V .\Libraries\config.py Robots\GenerateApiKey.robot

