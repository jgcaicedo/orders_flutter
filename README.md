# Ordenes App

> Solución completa para la gestión de órdenes de laboratorio.
> Incluye backend en .NET Core y frontend móvil en Flutter.

---

## Estructura del Repositorio

- `ordenes_app/` → Frontend Flutter
- `orderApi/`    → Backend .NET Core

---

# Backend (.NET Core)

## Requisitos
- .NET 7 o superior
- SQL Server

## Ejecución
1. Ve a la carpeta `orderApi`:
   cd orderApi
2. Restaura paquetes y ejecuta migraciones (si aplica):
   dotnet restore
   dotnet build
   dotnet run
3. La API estará disponible en `https://localhost:7000/api` (ajusta el puerto si es necesario).

## Endpoints principales
- `POST /api/login` — Login simulado (usuario: demo, contraseña: 1234)
- `GET /api/orders` — Listar órdenes
- `POST /api/orders` — Crear orden

## Notas técnicas
- Logging de ruta y método en consola
- Validaciones y manejo de errores (400/404)
- Separación Controller/Service
- Modelo relacional sugerido:
  - Paciente (PacienteId PK, Nombre)
  - Orden (OrdenId PK, PacienteId FK, FechaAtencion)
  - Examen (ExamenId PK, Nombre, Codigo)
  - OrdenExamen (OrdenId FK, ExamenId FK)

---

# Frontend (Flutter)

## Requisitos
- Flutter 3.10+
- Dart 3+

## Ejecución
1. Ve a la carpeta `ordenes_app`:
   cd ordenes_app
   
2. Instala dependencias:
   flutter pub get
3. Corre la app:
   flutter run

## Funcionalidades
- Login simulado (usuario: demo, contraseña: 1234)
- Listado de órdenes (consume API)
- Formulario para crear orden (validaciones, feedback de errores)
- Manejo de estado con Provider
- Buenas prácticas: separación de lógica, modularidad, validaciones

## Estructura relevante
- `lib/pages/` — Pantallas principales (login, listado, crear orden)
- `lib/providers/` — Providers para autenticación y órdenes
- `lib/services/` — Lógica de consumo de API
- `lib/models/` — Modelos de datos
- `lib/widgets/` — Componentes reutilizables

## Comentario de buenas prácticas
- **Separación de lógica y UI:** Providers y servicios desacoplados de la vista.
- **Validaciones robustas:** En formularios y feedback de errores de la API.
- **Manejo de estado predecible:** Uso de Provider y ChangeNotifier.



