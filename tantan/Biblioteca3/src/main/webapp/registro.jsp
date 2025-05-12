<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BiblioSystem - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3a6ea5;
            --accent-color: #ff6b6b;
            --light-bg: #f8f9fa;
            --dark-text: #333;
            --light-text: #f8f9fa;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card {
            border-radius: 15px;
            border: none;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), #4a8ec2);
            border-bottom: none;
            padding: 1.5rem;
        }
        
        .card-body {
            padding: 2rem;
            background-color: white;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(58, 110, 165, 0.25);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: #2c5a8a;
            border-color: #2c5a8a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(58, 110, 165, 0.3);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }
        
        .alert {
            border-radius: 8px;
            border: none;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #842029;
        }
        
        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        
        .system-logo {
            font-size: 2rem;
            color: var(--light-text);
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .system-name {
            display: inline-block;
            font-weight: 700;
            background: linear-gradient(to right, #fff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 10px;
        }
        
        .form-footer {
            text-align: center;
            margin-top: 2rem;
            color: var(--dark-text);
            font-size: 0.9rem;
        }
        
        /* Input group styling */
        .input-group-text {
            border-radius: 8px 0 0 8px;
            background-color: #e9ecef;
            border: 1px solid #ced4da;
            border-right: none;
        }
        
        .input-group .form-control {
            border-radius: 0 8px 8px 0;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header text-center">
                        <div class="system-logo">
                            <i class="fas fa-book-reader"></i>
                            <span class="system-name">BiblioSystem</span>
                        </div>
                        <h4 class="mb-0 text-white">Registro de Usuario</h4>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>
                        
                        <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <%= request.getAttribute("success") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>
                        
                        <form action="RegistroController" method="post">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="nombres" class="form-label">
                                        <i class="fas fa-user me-2 text-primary"></i>Nombres
                                    </label>
                                    <input type="text" class="form-control" id="nombres" name="nombres" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="apellidos" class="form-label">
                                        <i class="fas fa-user me-2 text-primary"></i>Apellidos
                                    </label>
                                    <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="dni" class="form-label">
                                        <i class="fas fa-id-card me-2 text-primary"></i>DNI
                                    </label>
                                    <input type="text" class="form-control" id="dni" name="dni" maxlength="8" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="fechaNacimiento" class="form-label">
                                        <i class="fas fa-calendar-alt me-2 text-primary"></i>Fecha de Nacimiento
                                    </label>
                                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="direccion" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2 text-primary"></i>Dirección
                                </label>
                                <input type="text" class="form-control" id="direccion" name="direccion" required>
                            </div>
                            
                            <div class="mb-4">
                                <label for="correo" class="form-label">
                                    <i class="fas fa-envelope me-2 text-primary"></i>Correo Electrónico
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">@</span>
                                    <input type="email" class="form-control" id="correo" name="correo" required>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="login" class="form-label">
                                        <i class="fas fa-user-tag me-2 text-primary"></i>Nombre de Usuario
                                    </label>
                                    <input type="text" class="form-control" id="login" name="login" maxlength="15" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2 text-primary"></i>Contraseña
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="rol" class="form-label">
                                    <i class="fas fa-user-shield me-2 text-primary"></i>Rol
                                </label>
                                <select class="form-select" id="rol" name="idRol" required>
                                    <option value="">Seleccione un rol</option>
                                    <option value="1">Administrador</option>
                                    <option value="2">Usuario</option>
                                </select>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-save me-2"></i>Registrar Usuario
                                </button>
                                <a href="login.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Volver al Login
                                </a>
                            </div>
                        </form>
                        
                        <div class="form-footer">
                            <p>Al registrarte, aceptas nuestros términos y condiciones.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validación básica del DNI (solo números)
        document.getElementById('dni').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        // Efecto visual al hacer hover en los inputs
        const inputs = document.querySelectorAll('.form-control, .form-select');
        inputs.forEach(input => {
            input.addEventListener('mouseover', function() {
                this.style.borderColor = '#4a8ec2';
            });
            input.addEventListener('mouseout', function() {
                if (!this.matches(':focus')) {
                    this.style.borderColor = '#ced4da';
                }
            });
        });
    </script>
</body>
</html>