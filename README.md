# MeliChallenge

## Descripción

**MeliChallenge** es una aplicación desarrollada en Swift que utiliza SwiftUI para la interfaz de usuario y Combine para el manejo de eventos asíncronos. Esta aplicación permite a los usuarios buscar productos, ver una lista de resultados y acceder a un detalle completo de un producto. Está diseñada para funcionar de manera fluida y eficiente, manteniendo el estado de la vista al rotar la pantalla y manejando adecuadamente los errores tanto desde la perspectiva del desarrollador como del usuario.

## Funcionalidades

- **Pantalla de búsqueda:** Un campo de texto que permite a los usuarios buscar productos.
- **Pantalla de resultados de búsqueda:** Muestra los productos relacionados con la búsqueda en una lista.
- **Pantalla de detalle de producto:** Proporciona información detallada de un producto seleccionado.
- **Soporte de rotación de pantalla:** Mantiene el estado de cada pantalla al rotar el dispositivo.
- **Manejo de errores:** Tanto a nivel de código como en la experiencia de usuario, ofreciendo feedback adecuado en caso de fallos.

## Requisitos

- **iOS 14.0** o superior.
- **Swift 5.5** o superior.
- **Xcode 13.0** o superior.

## Estructura del Proyecto

El proyecto está organizado de la siguiente manera:


## Tecnologías y Patrones

- **SwiftUI**: Framework utilizado para construir la interfaz de usuario declarativa.
- **Combine**: Framework utilizado para manejar el flujo de datos y la reactividad.
- **URLSession & Combine**: Para realizar solicitudes de red asíncronas y procesar las respuestas.
- **Protocolos y Generics**: Usados para abstraer y generalizar las solicitudes de red.
- **Manejo de errores personalizado**: Captura y gestiona los errores de red y decodificación, proporcionando feedback tanto al desarrollador como al usuario final.

## Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/MeliChallenge.git

cd MeliChallenge
open MeliChallenge.xcodeproj

