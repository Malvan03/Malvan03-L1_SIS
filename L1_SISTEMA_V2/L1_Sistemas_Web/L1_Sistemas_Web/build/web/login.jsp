<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Línea 1</title>

    <!-- Google Fonts: Exo 2 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Íconos de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Tu archivo CSS personalizado -->
    <link rel="stylesheet" href="assets/css/estilo.css">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Tu archivo JS -->
    <script src="assets/js/funciones.js"></script>

    <!-- Estilos personalizados añadidos para hacer el diseño más llamativo -->
    <style>
        body {
            font-family: 'Exo 2', sans-serif;
            background: linear-gradient(to right, #0e2a13, #1d5848); /* Fondo degradado */
        }

        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }

        .card-header {
            background-color: #3cb490; 
            padding: 1.5rem;
        }

        .card-header img {
            max-height: 80px;
        }

        .card-body {
            padding: 2rem;
        }

        .form-control:focus {
            border-color: #3cb490;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .btn-primary {
            background-color: #246b4b; 
            border: none;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #0d6efd;
        }

        .text-muted:hover {
            color: #0d6efd !important;
        }

        /* Animación sutil al cargar */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <!-- Contenedor principal -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <!-- Card con sombra y animación -->
                <div class="card shadow-lg">
                    <!-- Cabecera con logo -->
                    <div class="card-header text-center text-white">
                        <!-- Imagen de logo -->
                        <img src="assets/images/LOGOL1.png" alt="Línea 1 Logo" class="img-fluid">
                        <h4 class="mt-2">Bienvenido a Línea 1</h4> <!-- Nuevo título añadido -->
                    </div>
                    <div class="card-body">
                        <!-- Formulario de inicio de sesión -->
                        <form id="loginForm" action="LoginController" method="POST">
                            <div class="mb-3">
                                <label for="usuario" class="form-label"><i class="bi bi-person-circle"></i> Usuario</label> <!-- Icono añadido -->
                                <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Introduce tu usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="contrasena" class="form-label"><i class="bi bi-lock-fill"></i> Contraseña</label> <!-- Icono añadido -->
                                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Introduce tu contraseña" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="recordarme" name="recordarme">
                                <label class="form-check-label" for="recordarme">Recordarme</label>
                            </div>
                            <!-- Botón de enviar -->
                            <button type="submit" class="btn btn-primary w-100">Iniciar Sesión</button>
                        </form>
                    </div>
                </div>
                <!-- Enlaces adicionales -->
                <div class="mt-3 text-center">
                    <a href="#" class="text-muted"><i class="bi bi-question-circle"></i> ¿Olvidaste tu contraseña?</a><br>
                    <a href="#" class="text-muted"><i class="bi bi-person-plus"></i> ¿No tienes cuenta? Regístrate</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>