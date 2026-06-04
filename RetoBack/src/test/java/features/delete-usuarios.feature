Feature: Eliminar Usuario en ServeRest

  Scenario: Eliminar un usuario existente [CASO POSITIVO]
    # Se llama a "post-usuarios"
    * def creacion = call read('post-usuarios.feature@CreateUser')
    * def idParaEliminar = creacion.response._id

    Given url baseUrl
    And path '/usuarios', idParaEliminar
    When method DELETE
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Intentar eliminar un usuario inexistente [CASO NEGATIVO]
    Given url baseUrl
    And path '/usuarios', 'idfalsoqa1234567'
    When method DELETE
    Then status 200
    And match response.message == 'Nenhum registro excluído'

  Scenario: Intentar eliminar un usuario con un carrito registrado [CASO NEGATIVO]
    # Se crea un usuario para acceder con su contraseña
    * def creacion = call read('post-usuarios.feature@CreateUser')
    * def idUsuario = creacion.response._id
    * def emailUsuario = creacion.emailAleatorio
    * def passwordUsuario = creacion.payloadUsuario.password 

    # Se inicia sesión para captar el token de autorización
    Given url baseUrl
    And path '/login'
    And request { email: '#(emailUsuario)', password: '#(passwordUsuario)' }
    When method POST
    Then status 200
    * def tokenAutenticacion = response.authorization

    # Se busca un producto que añadir al carrito
    Given url baseUrl
    And path '/produtos'
    When method GET
    Then status 200
    * def idProducto = response.produtos[0]._id

    # Se registra un carrito para el usuario, que se autentica con el token que se obtuvo en el login
    Given url baseUrl
    And path '/carrinhos'
    And header Authorization = tokenAutenticacion
    And request { produtos: [{ idProduto: '#(idProducto)', quantidade: 1 }] }
    When method POST
    Then status 201

    # Se intenta eliminar un usuario con un carrito activo
    Given url baseUrl
    And path '/usuarios', idUsuario
    When method DELETE
    Then status 400
    And match response.message == 'Não é permitido excluir usuário com carrinho cadastrado'