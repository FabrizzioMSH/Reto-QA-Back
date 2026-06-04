Feature: Registrar Usuarios

  Background:
    * def payloadUsuario = read('classpath:/data/nuevoUsuario.json')
    * def generadorDatos = read('classpath:/helpers/dataGenerator.js')

@CreateUser  
Scenario: Registrar un usuario nuevo exitosamente usando un correo dinámico [CASO POSITIVO]
    # Se genera un correo aleatorio y se inserta en el JSON
    * def emailAleatorio = generadorDatos()
    * set payloadUsuario.email = emailAleatorio

    Given url baseUrl
    And path '/usuarios'
    And request payloadUsuario
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

  Scenario: Intentar registrar un usuario ya existente [CASO NEGATIVO]
    * def emailAleatorio = generadorDatos()
    * set payloadUsuario.email = emailAleatorio

    # Se ingresa el usuario por primera vez
    Given url baseUrl
    And path '/usuarios'
    And request payloadUsuario
    When method POST
    Then status 201

    # Se intenta ingresar el mismo usuario por segunda vez
    Given url baseUrl
    And path '/usuarios'
    And request payloadUsuario
    When method POST
    Then status 400
    And match response.message == 'Este email já está sendo usado'