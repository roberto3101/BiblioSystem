<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión - Inicio</title>
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
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        
        .navbar {
            background-color: var(--secondary-color);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.6rem;
            color: white !important;
        }
        
        .hero-section {
            background: linear-gradient(rgba(44, 62, 80, 0.8), rgba(44, 62, 80, 0.8)), 
                        url('https://source.unsplash.com/random/1200x800/?library');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 7rem 0;
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        
        .hero-subtitle {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            font-weight: 300;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
        }
        
        .feature-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        
        .card-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 30px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        
        .btn-outline-light {
            border-radius: 30px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        
        .btn-outline-light:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.2);
        }
        
        footer {
            background-color: var(--secondary-color);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
        
        .feature-title {
            font-weight: 600;
            color: var(--secondary-color);
            margin-top: 0.5rem;
        }
        
        .card-body {
            text-align: center;
            padding: 2rem;
        }
        
        .animated-btn {
            position: relative;
            overflow: hidden;
        }
        
        .animated-btn:after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }
        
        .animated-btn:hover:after {
            left: 100%;
        }
        
        .user-dropdown .dropdown-toggle::after {
            display: none;
        }
        
        .user-dropdown .dropdown-toggle {
            display: flex;
            align-items: center;
            color: #fff;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: var(--secondary-color);
            font-weight: bold;
            margin-right: 10px;
        }
        
        .admin-badge {
            background-color: var(--accent-color);
            color: white;
            font-size: 0.7rem;
            padding: 3px 8px;
            border-radius: 10px;
            margin-left: 8px;
        }
        
        .role-indicator {
            font-size: 0.8rem;
            opacity: 0.8;
            margin-top: 3px;
        }
        
        /* Menú admin solo visible para administradores */
        .admin-menu {
            display: none;
        }
        
        .admin-visible .admin-menu {
            display: block;
        }
    </style>
</head>
<body class="<%= session.getAttribute("esAdmin") != null && (boolean)session.getAttribute("esAdmin") ? "admin-visible" : "" %>">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-book-open me-2"></i>BiblioSystem
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="libro?accion=listar">Gestión de Libros</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Categorías</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Informes</a>
                    </li>
                    <!-- Menú visible solo para administradores -->
                    <li class="nav-item admin-menu">
                        <a class="nav-link" href="#" style="color: #e74c3c;">
                            <i class="fas fa-users-cog me-1"></i>Gestión de Usuarios
                        </a>
                    </li>
                </ul>
                
                <% if(session.getAttribute("usuario") != null) { %>
                <div class="nav-item dropdown user-dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar">
                            <%= ((String)session.getAttribute("nombreUsuario")).substring(0, 1).toUpperCase() %>
                        </div>
                        <div>
                            <%= session.getAttribute("nombreUsuario") %>
                            <% if(session.getAttribute("esAdmin") != null && (boolean)session.getAttribute("esAdmin")) { %>
                                <span class="admin-badge">Admin</span>
                            <% } %>
                            <div class="role-indicator"><%= session.getAttribute("rolUsuario") %></div>
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Mi Perfil</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Configuración</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                    </ul>
                </div>
                <% } else { %>
                <a href="login" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-in-alt me-1"></i> Iniciar Sesión
                </a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
<!-- Hero Section -->
               <section class="hero-section">
                      <div class="container">
                      <h1 class="hero-title">Sistema de Gestión Bibliotecaria</h1>
                      <p class="hero-subtitle">Administra tu colección de libros de manera eficiente y moderna</p>
                      <a href="libro?accion=listar" class="btn btn-primary btn-lg animated-btn">
                      <i class="fas fa-book me-2"></i>CRUD LIBRO
                      </a>
                     
<a href="AlumnoServlet?accion=listar" class="btn btn-success btn-lg animated-btn">
                      <i class="fas fa-user-graduate me-2"></i>CRUD ALUMNO
                      </a>
                      </div>
                </section>

    <!-- Features Section -->
    <section class="container mb-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <i class="fas fa-book-open card-icon"></i>
                        <h3 class="feature-title">Gestión de Libros</h3>
                        <p class="text-muted">Administra tu inventario de libros con facilidad. Añade, edita y elimina registros en un solo lugar.</p>
                        <a href="libro?accion=listar" class="btn btn-primary mt-3">Ir a Libros</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <i class="fas fa-tag card-icon"></i>
                        <h3 class="feature-title">Categorías</h3>
                        <p class="text-muted">Organiza tu biblioteca por categorías para una mejor clasificación y búsqueda de material.</p>
                        <a href="#" class="btn btn-primary mt-3">Ver Categorías</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <i class="fas fa-chart-line card-icon"></i>
                        <h3 class="feature-title">Informes y Estadísticas</h3>
                        <p class="text-muted">Analiza tu colección con gráficos detallados y reportes personalizados.</p>
                        <a href="#" class="btn btn-primary mt-3">Ver Informes</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Sección de administración (solo visible para administradores) -->
        <% if(session.getAttribute("esAdmin") != null && (boolean)session.getAttribute("esAdmin")) { %>
        <div class="row mt-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0"><i class="fas fa-shield-alt me-2"></i>Panel de Administración</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-4">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-danger p-3 text-white me-3">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                    <div>
                                        <h5>Gestión de Usuarios</h5>
                                        <p class="text-muted mb-0">Administra las cuentas de usuario</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-danger p-3 text-white me-3">
                                        <i class="fas fa-cogs fa-2x"></i>
                                    </div>
                                    <div>
                                        <h5>Configuración</h5>
                                        <p class="text-muted mb-0">Opciones avanzadas del sistema</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-danger p-3 text-white me-3">
                                        <i class="fas fa-database fa-2x"></i>
                                    </div>
                                    <div>
                                        <h5>Backup</h5>
                                        <p class="text-muted mb-0">Respaldo y restauración</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-book-open me-2"></i>BiblioSystem</h5>
                    <p>Sistema de gestión bibliotecaria avanzado, diseñado para administrar colecciones de libros de manera eficiente.</p>
                </div>
                <div class="col-md-3">
                    <h5>Enlaces rápidos</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Inicio</a></li>
                        <li><a href="libro?accion=listar" class="text-white">Libros</a></li>
                        <li><a href="#" class="text-white">Categorías</a></li>
                        <li><a href="#" class="text-white">Informes</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Contacto</h5>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-envelope me-2"></i>info@bibliosystem.com</li>
                        <li><i class="fas fa-phone me-2"></i>(123) 456-7890</li>
                        <li><i class="fas fa-map-marker-alt me-2"></i>Lima, Perú</li>
                    </ul>
                </div>
            </div>
            <hr class="mt-4 mb-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 BiblioSystem. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>