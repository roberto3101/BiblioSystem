<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BiblioSystem - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            display: flex;
        }
        
        .login-image {
            background: linear-gradient(rgba(44, 62, 80, 0.7), rgba(44, 62, 80, 0.7)), 
                        url('https://source.unsplash.com/random/600x800/?library');
            background-size: cover;
            background-position: center;
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            text-align: center;
        }
        
        .login-form {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .login-logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--secondary-color);
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-floating {
            margin-bottom: 20px;
        }
        
        .btn-login {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
        }
        
        .btn-login:hover {
            background-color: #2980b9;
            border-color: #2980b9;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        
        .btn-register {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            width: 100%;
            margin-top: 15px;
        }
        
        .btn-register:hover {
            background-color: #34495e;
            border-color: #34495e;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.4);
        }
        
        .login-footer {
            text-align: center;
            margin-top: 30px;
            color: #777;
        }
        
        .login-quotes {
            font-style: italic;
            margin-bottom: 30px;
        }
        
        .alert {
            margin-bottom: 20px;
            border-radius: 10px;
        }
        
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-image {
                display: none;
            }
        }
        
        .animated-input {
            position: relative;
        }
        
        .animated-input input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
        
        .form-check {
            margin-bottom: 20px;
        }
        
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-image d-none d-md-flex">
                <div>
                    <h2 class="mb-4">Bienvenido a BiblioSystem</h2>
                    <p class="login-quotes">"Una biblioteca no es un lujo, sino una necesidad de la vida."<br>― Henry Ward Beecher</p>
                    <h4 class="mb-3">Sistema de Gestión Bibliotecaria</h4>
                    <p>Administra tu colección de libros de manera eficiente y moderna.</p>
                </div>
            </div>
            <div class="login-form">
                <div class="login-logo">
                    <i class="fas fa-book-open me-2"></i>BiblioSystem
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>
                
                <% if (session.getAttribute("mensajeRegistro") != null) { %>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    <%= session.getAttribute("mensajeRegistro") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% 
                    session.removeAttribute("mensajeRegistro");
                } %>
                
                <form action="LoginController" method="post">
                    <div class="form-floating animated-input">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Nombre de usuario" required>
                        <label for="username"><i class="fas fa-user me-2"></i>Nombre de usuario</label>
                    </div>
                    <div class="form-floating animated-input">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
                        <label for="password"><i class="fas fa-lock me-2"></i>Contraseña</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">
                            Recordarme
                        </label>
                    </div>
                    
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-login btn-lg">
                            <i class="fas fa-sign-in-alt me-2"></i>Iniciar Sesión
                        </button>
                        
                        <a href="registro.jsp" class="btn btn-register btn-lg">
                            <i class="fas fa-user-plus me-2"></i>Registrarse
                        </a>
                    </div>
                </form>
                
                <div class="login-footer">
                    <p>&copy; 2025 BiblioSystem. Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>