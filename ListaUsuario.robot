*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${HOST}  https://serverest.dev 

#Rotas
${lOGIN}  login
${Get_usuarios}  usuarios
${Get_unico_usuario}  usuarios/id_usuario   #A busca no sistema é feita vida ID, e para isso precisamos utilizar a variavel ${Get_usuarios} e a ${Get_unico_usuario}


*** Keywords ***
#--------------------------------CT01----------------------------------------------
E realizo o acessar APÌ
   #passando informações de acesso, que seriam o e-mail e a senha
   &{headers}    Create Dictionary    Authorization=fulano@qa.com teste
   &{payload}    Create Dictionary    email=fulano@qa.com    password=teste   
   POST    url=${HOST}/${lOGIN}  json=${payload}  headers=${headers}  expected_status=200
#--------------------------------CT02----------------------------------------------
Dado que possuo um email invalido ao acessar a API
  #[Arguments]   ${email} 
  &{headers}    Create Dictionary    Authorization=fulano@qa teste
  &{payload}    Create Dictionary    email=fulano    password=teste    
   POST    url=${HOST}/${lOGIN}  json=${payload}  headers=${headers}  expected_status=400


#--------------------------------CT03----------------------------------------------
E realizo a busca de todos os usuarios
     #enviando a URL para que a API me forneça todos os usuários 
    GET  url=${HOST}/${Get_usuarios}  expected_status=200

#--------------------------------CT04----------------------------------------------
Dado que possuo o ID de um usuário cadastrado ${id}
      #enviando a URL para que a API me forneça um usuário específico  
      #o teste está me fornecendo o Id que pode mudar conforme o cenário, mas o código já está preparado para acomodar essa mudança, independentemente do valor 
        ${Get_unico_usuario}=  Replace String    ${Get_unico_usuario}   id_usuario   ${id}    
        ${response}=  GET  url=${HOST}/${Get_unico_usuario}

         RETURN   ${response}

#--------------------------------CT05----------------------------------------------
    #O ID não deve existir na base de dados
Dado que o ID de um usuario não foi encontrado ${id}
    ${Get_unico_usuario}=  Replace String    ${Get_unico_usuario}   id_usuario   ${id}    
    ${response}=  GET  url=${HOST}/${Get_unico_usuario}  expected_status=400
        RETURN   ${response}


*** Test Cases ***    
CT01- realizar o login
#A duração do token retornado em authorization é de 600 segundos (10 minutos). Caso esteja expirado irá receber status code 401 (Unauthorized).
    E realizo o acessar APÌ

CT02- Email invalido
     Dado que possuo um email invalido ao acessar a API  
  
CT03- realizar a busca de todos os usuarios
    E realizo a busca de todos os usuarios

CT04- realizar a busca de um unico usuario    
    ${response}=  Dado que possuo o ID de um usuário cadastrado 0uxuPY0cbmQhpEz1
     Should Be Equal As Strings  ${response.status_code}  200
    
CT05-Usuario não encontrado
  ${response}=  Dado que o ID de um usuario não foi encontrado 0uxuPY0cbmQhpEz2
  


