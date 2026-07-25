*** Settings ***
Library  RequestsLibrary
Library  String
Library  JSONLibrary

*** Variables ***
${HOST}  https://serverest.dev 
${RESPONSE_ATUAL}
${RESPONSE_DELIT}
${RESPONSE_CARRI}
#Rotas
${delet_usuarios}  usuarios/id_usuario         

*** Keywords ***
#-------------------------------CT01--------------------------------------------
Quando não deletar nennhum usuario    
    [Arguments]   ${id}  
  &{headers}    Create Dictionary    Accept=application/json
  ${delet_usuarios}=  Replace String    ${delet_usuarios}   id_usuario   ${id} 
      
     ${response}=   DELETE  url=${HOST}/${delet_usuarios}  headers=&{headers}  expected_status=200
     Set Test Variable    ${RESPONSE_ATUAL}    ${response} 
    RETURN    ${response}

Então o retorno da API deve ser ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_ATUAL.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


#---------------------------------CT02---------------------------------------------
Quando eu deleto um usuario    
    [Arguments]   ${id}  
  &{headers}    Create Dictionary    Accept=application/json
  ${delet_usuarios}=  Replace String    ${delet_usuarios}   id_usuario   ${id} 
      
     ${response}=   DELETE  url=${HOST}/${delet_usuarios}  headers=&{headers}  expected_status=200
     Set Test Variable    ${RESPONSE_DELIT}    ${response} 
    RETURN    ${response}

Então a API deve retornar ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_DELIT.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}

#----------------------------CT03-----------------------------------------------------------
Quando eu deleto um usuario com carrinho cadastrado     
    [Arguments]   ${id}  
  &{headers}    Create Dictionary    Accept=application/json
  ${delet_usuarios}=  Replace String    ${delet_usuarios}   id_usuario   ${id} 
      
     ${response}=   DELETE  url=${HOST}/${delet_usuarios}  headers=&{headers}  expected_status=400
     Set Test Variable    ${RESPONSE_CARRI}    ${response} 
    RETURN    ${response}

Então a API deve retornar a mensagem ${mensagem_esperada}
    ${json_body}=    Set Variable    ${RESPONSE_CARRI.json()}
    ${mensagem_api}=    Set Variable    ${json_body['message']}
    Should Be Equal As Strings    ${mensagem_api}    ${mensagem_esperada}


    

*** Test Cases ***
CT01- deletar nennhum usuario
#O ID de usuario não deve existir na base de dados
      Quando não deletar nennhum usuario  id=PrB9BjYbIt9VvIBn
      Então o retorno da API deve ser Nenhum registro excluído

CT02- deletar um usuario
#O ID de usuario deve existir na base de dados, incluir um usuario antes caso seja necessario e alterar o ID do caso
    Quando eu deleto um usuario  id=OVolk2rJCwz3IQgH
    Então a API deve retornar Registro excluído com sucesso

CT03- Usuário com carrinho cadastrado  
     Quando eu deleto um usuario com carrinho cadastrado  id=qbMqntef4iTOwWfg
     Então a API deve retornar a mensagem Não é permitido excluir usuário com carrinho cadastrado