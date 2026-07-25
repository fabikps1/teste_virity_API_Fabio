# Titulo
Cenários de API para a empresa Verity.

## Descrição
-Esse projeto se utiliza os métodos , para realizar as suas chamadas.
○ GET /users: Retorna uma lista de todos os usuários.
○ POST /users: Cria um novo usuário.
○ GET /users/{id}: Retorna os detalhes de um usuário específico.
○ PUT /users/{id}: Atualiza as informações de um usuário.
○ DELETE /users/{id}: Exclui um usuário.

## Do que se trata?
- Optei por utilizar o VS Code como editor de código.
- Utilizando o Robot Framework para automação. 
- Foram criados 4 casos de teste que visam contemplar todos os cenários da API de Usuário. Mesmo que na API tenha Produtos e Carrinhos, para o teste foi solicitado somente o Usuário. Dentro de cada caso, tem alguns cenários, cada um com a sua finalidade.
- Cada cenário foi escrito em BDD para facilitar o entendimento de cada etapa. 
- Cada etapa do cenário faz uma validade da mensagem de retorno.

## Detalhes técnicos. 
- Para todos os cenários foi utilizado a API https://serverest.dev/
- Em alguns testes, o retorno da API https://serverest.dev/ para alguns cenários estava diferente do especificado, mas isso só ocorreu em poucos testes realizados.


 ## intrução de instalação 
 - Para o ambiente 
    - visual studio code
    - Python (Stable Releases)
    - pip   install selennium
    - pip instal robotframework
    - pip install robotframework-seleniumlibrary
    - pip install robotframework-requests
    - pip install robotframework-jsonlibrary
## Para as variáveis
    - Para alguns cenários, é de muita importância mudar a variável, seja ela o ID, Nome, etc..

## instrução de Uso
 - Executar cada cenario pelo proprio VS Code.
