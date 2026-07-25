*** Settings ***
Library  RequestsLibrary
Library  String
Library  JSONLibrary

*** Variables ***
${HOST}  https://serverest.dev 
${RESPONSE_ATUAL}
${RESPONSE_USADO}
#Rotas
${Get_usuarios}  usuarios
    

*** Keywords ***
#--------------------------------CT01-----------------------------------------
Dado que adiciono um novo usuário    
    [Arguments]      ${nome}      ${email}     ${password}    ${administrador}

  &{headers}    Create Dictionary    Content-Type=application/json  
  &{headers}    Create Dictionary    Accept=application/json
  &{body}    Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${administrador}
  ${response}=  POST  url=${HOST}/${Get_usuarios}  headers=&{headers}  json=&{body}  expected_status=201
        Set Test Variable    ${RESPONSE_ATUAL}    ${response}
    RETURN    ${response}


Então o retorno da API deve ser ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_ATUAL.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


#--------------------------------------CT02------------------------------------


Dado que Cadastro um usuario com e-mail já utilizado
  [Arguments]      ${nome}      ${email}     ${password}    ${administrador}
  &{headers}    Create Dictionary    Content-Type=application/json  
  &{headers}    Create Dictionary    Accept=application/json
  &{body}    Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${administrador}
      ${response}=  POST  url=${HOST}/${Get_usuarios}  headers=&{headers}  json=&{body}  expected_status=400
      Set Test Variable    ${RESPONSE_USADO}    ${response}
    RETURN    ${response}

Então a mensagem de retornno da API deve ser ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_USADO.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}

        

*** Test Cases ***

# Os parametos passados não devem existir na base de dados.
CT01- Realizar adição de um novo usuario
   Dado que adiciono um novo usuário   nome=Fabiox  email=Fabiox@g.com.br  password=postx  administrador=true
   Então o retorno da API deve ser Cadastro realizado com sucesso

#Para teste pode utilizar o mesmo paramentro que foi utilizado no cenario CT01
CT02- Email já utilizado ao cadastrar um usuario     
    Dado que Cadastro um usuario com e-mail já utilizado  nome=Fabiof  email=Fabiof@g.com.br  password=postf  administrador=true
    Então a mensagem de retornno da API deve ser Este email já está sendo usado
