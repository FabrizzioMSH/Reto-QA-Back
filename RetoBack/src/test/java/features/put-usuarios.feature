Feature: Actualizar Usuario

  Background:
    * def payloadActualizar = read('classpath:/data/actualizarUsuario.json')
    * def generadorDatos = read('classpath:/helpers/dataGenerator.js')

  Scenario: Actualizar los datos de un usuario existente [CASO POSITIVO]
    # Se crea el nuevo usuario mediante el caso positivo de "post-usuarios", y se toma su id
    * def creacion = call read('post-usuarios.feature@CreateUser')
    * def idParaActualizar = creacion.response._id

    # Se genera un correo aleatorio para insertarlo en el JSON de la edición de usuario
    * def nuevoEmail = generadorDatos()
    * set payloadActualizar.email = nuevoEmail

    Given url baseUrl
    And path '/usuarios', idParaActualizar
    And request payloadActualizar
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

  Scenario: Crear un usuario enviando un ID inexistente
    * def idInexistente = 'idfalsoqa9999999'
    * def nuevoEmail = generadorDatos()
    * set payloadActualizar.email = nuevoEmail

    Given url baseUrl
    And path '/usuarios', idInexistente
    And request payloadActualizar
    When method PUT
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'
    
  Scenario: Intentar actualizar un usuario con un correo de otro usuario [CASO NEGATIVO]
    # Se crea el Usuario A, que es que se modificará
    * def creacionA = call read('post-usuarios.feature@CreateUser')
    * def idUsuarioA = creacionA.response._id

    # Se crea el Usuario B, del cual se tomará el correo para la consulta errónea
    * def creacionB = call read('post-usuarios.feature@CreateUser')
    # Se toma la variable creada para el correo aleatorio en "post-usuarios", y se inserta en el JSON de la consulta
    * def emailUsuarioB = creacionB.emailAleatorio 
    * set payloadActualizar.email = emailUsuarioB

    Given url baseUrl
    And path '/usuarios', idUsuarioA
    And request payloadActualizar
    When method PUT
    Then status 400
    And match response.message == 'Este email já está sendo usado'