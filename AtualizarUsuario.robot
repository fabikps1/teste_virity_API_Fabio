*** Settings ***
Library  RequestsLibrary
Library  String
Library  JSONLibrary

*** Variables ***
${HOST}  https://serverest.dev 
${RESPONSE_ATUAL}
${RESPONSE_USADO}
${RESPONSE_CADAST}
#Rotas
${atualiza_usuarios}  usuarios/id_usuario         

*** Keywords ***
#----------------------------ct01----------------
Quando atualizo o usuario    
    [Arguments]   ${id}    ${nome}      ${email}     ${password}    ${administrador}

  &{headers}    Create Dictionary    Content-Type=application/json  
  &{headers}    Create Dictionary    Accept=application/json
  &{body}    Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${administrador}
  ${atualiza_usuarios}=  Replace String    ${atualiza_usuarios}   id_usuario   ${id} 
     ${response}=   PUT  url=${HOST}/${atualiza_usuarios}  headers=&{headers}  json=&{body}  expected_status=200
      Set Test Variable    ${RESPONSE_ATUAL}    ${response}
     RETURN    ${response}

Então o retorno da API deve ser ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_ATUAL.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


#-------------------------CT02------------------------------------------------

Quando o usuario não cadastrado com email em uso

   [Arguments]   ${id}    ${nome}      ${email}     ${password}    ${administrador}

  &{headers}    Create Dictionary    Content-Type=application/json  
  &{headers}    Create Dictionary    Accept=application/json
  &{body}    Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${administrador}
  ${atualiza_usuarios}=  Replace String    ${atualiza_usuarios}   id_usuario   ${id} 
      
     ${response}=   PUT  url=${HOST}/${atualiza_usuarios}  headers=&{headers}  json=&{body}  expected_status=400
    Set Test Variable    ${RESPONSE_USADO}    ${response}
     RETURN    ${response}

Então a API deve ser retornar ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_USADO.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


#------------------------------CT03-------------------------------------------

Quando eu crio um usuario   
    [Arguments]   ${id}    ${nome}      ${email}     ${password}    ${administrador}

  &{headers}    Create Dictionary    Content-Type=application/json  
  &{headers}    Create Dictionary    Accept=application/json
  &{body}    Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${administrador}
  ${atualiza_usuarios}=  Replace String    ${atualiza_usuarios}   id_usuario   ${id} 
      
        ${response}=  PUT  url=${HOST}/${atualiza_usuarios}  headers=&{headers}  json=&{body}  expected_status=201
    Set Test Variable    ${RESPONSE_CADAST}   ${response}
     RETURN    ${response}

Então a API deve ser retornar a mensagem ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_CADAST.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


*** Test Cases ***
CT01- Atualizar usuario
#Para o ID informado, deve existir na base o nome, o e-mail e a senha, que podem ser alterados desde que estejam no padrão aceito.
      Quando atualizo o usuario  id=0uxuPY0cbmQhpEz1  nome=fabioh  email=fabioh@qa.com.br  password=puth  administrador=true
      Então o retorno da API deve ser Registro alterado com sucesso
      
CT02- email utilizado     
#O Email precisa existir na base de dados 
      Quando o usuario não cadastrado com email em uso  id=0uxuPY0cbmQhpEz1  nome=fabioq  email=beltrano@qa.com.br  password=putq  administrador=true
      Então a API deve ser retornar Este email já está sendo usado

CT03-usuario não cadastrado mas incluido
#Fiz alguns testes e às vezes funciona e às vezes não. Acredito que todas as informações passadas não devam existir na base de dados.     
      Quando eu crio um usuario  id=PrB9BjYbIt9VvIB8  nome=fabioz  email=fabioz@qa.com.br  password=putz  administrador=true
      Então a API deve ser retornar a mensagem Cadastro realizado com sucesso
      