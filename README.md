# **Aplicación de Inventario**

## **Descripción**
Esta aplicación móvil permite gestionar un inventario de productos mediante operaciones CRUD (Crear, Leer, Actualizar y Eliminar). Está diseñada utilizando Flutter para la interfaz y SQLite como base de datos local, garantizando un rendimiento eficiente y disponibilidad sin conexión.

---

## **Tecnologías Utilizadas**
- **Flutter**: Framework de desarrollo para aplicaciones móviles multiplataforma.
- **Dart**: Lenguaje de programación utilizado en Flutter.
- **SQLite**: Base de datos ligera para almacenamiento local.
- **sqflite**: Paquete de Flutter para integrar SQLite.
- **path**: Paquete de Flutter para gestionar rutas del sistema de archivos.

---

## **Funciones Implementadas**
1. **Agregar Productos**: Permite agregar un producto especificando su nombre y cantidad.
2. **Visualizar Productos**: Muestra una lista de productos almacenados en el inventario.
3. **Actualizar Productos**: Permite modificar la cantidad de un producto existente.
4. **Eliminar Productos**: Elimina un producto seleccionado del inventario.

---

## **Pasos para Ejecutar el Proyecto**

### **1. Configuración Inicial**
1. Asegúrate de tener Flutter instalado en tu computadora. Puedes descargarlo desde [flutter.dev](https://flutter.dev).
2. Clona este repositorio en tu máquina local:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
Estructura del Proyecto
main.dart: Archivo principal que inicializa la aplicación.
database/database_helper.dart: Archivo que contiene las funciones para interactuar con SQLite.
models/producto.dart: Modelo que define la estructura de los productos.
screens/product_list_screen.dart: Pantalla principal de la aplicación donde se gestiona el inventario.
Notas
Asegúrate de tener habilitada la depuración USB si usas un dispositivo físico.
Puedes personalizar el diseño de la interfaz gráfica y agregar funcionalidades según tus necesidades.
