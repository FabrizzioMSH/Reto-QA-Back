Feature: Buscar Usuario por ID
  
  Scenario: Buscar un usuario existente por su ID [CASO POSITIVO]
    # Se extrae el caso positivo de "post-usuarios.feature", junto con su ID
    * def creacion = call read('post-usuarios.feature@CreateUser')
    * def idBuscado = creacion.response._id

    Given url baseUrl
    And path '/usuarios', idBuscado
    When method GET
    Then status 200
    And match response._id == idBuscado

  Scenario: Intentar buscar un usuario que no existe [CASO NEGATIVO]
    Given url baseUrl
    And path '/usuarios', 'idfalsoqa1234567'
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'