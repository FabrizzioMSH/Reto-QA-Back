Feature: Obtener la Lista de Usuarios

  Background:
    * def esquemaUsuario = read('classpath:/data/esquemaUsuario.json')

  Scenario: Obtener la lista de todos los usuarios exitosamente
    Given url baseUrl
    And path '/usuarios'
    When method GET
    Then status 200
    And match response == { quantidade: '#number', usuarios: '#array' }

  Scenario: Validar el esquema JSON de los usuarios devueltos
    Given url baseUrl
    And path '/usuarios'
    When method GET
    Then status 200
    And match response.usuarios[0] == esquemaUsuario