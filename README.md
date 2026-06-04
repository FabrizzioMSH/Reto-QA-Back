# Reto de Automatización QA - BackEnd (ServeRest)

Este repositorio contiene la suite de pruebas automatizadas para la API de Usuarios de [ServeRest](https://serverest.dev/).

## 1. Prerrequisitos del Sistema

Para ejecutar este proyecto en un entorno local, se requiere la instalación de las siguientes herramientas:
* **Java JDK:** Versión 11 o superior.
* **Apache Maven:** Versión 3.8 o superior (configurado en las variables de entorno `MAVEN_HOME` y `Path`).
* **Visual Studio Code:** Se recomienda para la edición, junto con las extensiones: "Karate Runner" y "Extension Pack for Java".

## 2. Configuración e Instalación

1. Clona este repositorio en tu máquina local:
   ```bash
   git clone <tu-enlace-de-github>

2. Navega hasta la raíz del proyecto, que es donde se encuentra el archivo `pom.xml`:
   ```bash
   cd RetoBack

3. Descarga las dependencias iniciales del proyecto a través de Maven. En caso de no ejecutarse correctamente, reintentar colocando el parámetro "-DskipTests"entre comillas:
   ```bash
   mvn clean install -DskipTests

## 3. Instrucciones de Ejecución

El proyecto está configurado para ejecutarse fácilmente desde la terminal.

1. Ejecutar toda la suite de pruebas:
   ```bash
   mvn test
   
2. Una vez que la ejecución haya concluido, Karate generará automáticamente un reporte detallado, el cual puede abrirse desde un navegador sobre el siguiente archivo:
`target/karate-reports/karate-summary.html`