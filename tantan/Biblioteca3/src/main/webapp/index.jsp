<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.Libro" %>
<%@ page import="app.modelos.CategoriaLibro" %>
<%
// Redirigir al controlador si los datos no están cargados
if (request.getAttribute("libros") == null) {
    response.sendRedirect("libro?accion=listar");
    return;
}

// Configuración de paginación
int registrosPorPagina = 5;
int paginaActual = 1;
if (request.getParameter("pagina") != null) {
    try {
        paginaActual = Integer.parseInt(request.getParameter("pagina"));
        if (paginaActual < 1) paginaActual = 1;
    } catch (NumberFormatException e) {
        paginaActual = 1;
    }
}

List<Libro> libros = (List<Libro>) request.getAttribute("libros");
int totalRegistros = libros.size();
int totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);
if (paginaActual > totalPaginas && totalPaginas > 0) paginaActual = totalPaginas;

// Calcular índices para la paginación
int indiceInicial = (paginaActual - 1) * registrosPorPagina;
int indiceFinal = Math.min(indiceInicial + registrosPorPagina, totalRegistros);

// Sublista para mostrar en la página actual
List<Libro> librosPaginados = totalRegistros > 0 ? 
    libros.subList(indiceInicial, indiceFinal) : 
    libros;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Libros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
  <style>
        :root {
            --primary: #2c3e50;
            --secondary: #34495e;
            --accent: #3498db;
            --accent-hover: #2980b9;
            --success: #27ae60;
            --success-hover: #219653;
            --warning: #f39c12;
            --warning-hover: #f1c40f;
            --danger: #e74c3c;
            --danger-hover: #c0392b;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --text: #333;
            --text-light: #7f8c8d;
            --border-radius: 8px;
            --transition: all 0.3s ease;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f5f7fa;
            color: var(--text);
            line-height: 1.6;
        }

        .container {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            border-bottom: 1px solid #ddd;
            padding-bottom: 1rem;
        }

        .page-header h1 {
            color: var(--primary);
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: var(--text-light);
            margin-bottom: 0;
        }

        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: var(--transition);
            margin-bottom: 2rem;
        }

        .card:hover {
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-bottom: none;
        }

        .card-header h4 {
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
        }

        .card-header h4 i {
            margin-right: 0.75rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: var(--border-radius);
            border: 1px solid #ddd;
            padding: 0.6rem 1rem;
            transition: var(--transition);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn {
            border-radius: var(--border-radius);
            padding: 0.5rem 1.2rem;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-primary {
            background-color: var(--accent);
            border-color: var(--accent);
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
        }

        .btn-success {
            background-color: var(--success);
            border-color: var(--success);
        }

        .btn-success:hover, .btn-success:focus {
            background-color: var(--success-hover);
            border-color: var(--success-hover);
        }

        .btn-warning {
            background-color: var(--warning);
            border-color: var(--warning);
            color: white;
        }

        .btn-warning:hover, .btn-warning:focus {
            background-color: var(--warning-hover);
            border-color: var(--warning-hover);
            color: white;
        }

        .btn-danger {
            background-color: var(--danger);
            border-color: var(--danger);
        }

        .btn-danger:hover, .btn-danger:focus {
            background-color: var(--danger-hover);
            border-color: var(--danger-hover);
        }

        .table {
            margin-bottom: 0;
        }

        .table-container {
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .table thead th {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            border-bottom: none;
            padding: 0.75rem 1rem;
        }

        .table tbody tr {
            transition: var(--transition);
        }

        .table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }

        .table tbody td {
            padding: 0.75rem 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #ecf0f1;
        }

        .action-btn {
            margin-right: 0.3rem;
            padding: 0.25rem 0.6rem;
            font-size: 0.875rem;
        }

        .action-btn i {
            margin-right: 0.3rem;
        }

        .modal-content {
            border: none;
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border-bottom: none;
            padding: 1.25rem 1.5rem;
        }

        .modal-title {
            font-weight: 600;
            font-size: 1.25rem;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-footer {
            border-top: 1px solid #ecf0f1;
            padding: 1.25rem 1.5rem;
        }

        /* Estilo para el filtro de búsqueda */
        .search-box {
            background-color: white;
            border-radius: var(--border-radius);
            padding: 1.25rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow);
        }

        .search-box .title {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .search-box .title i {
            margin-right: 0.5rem;
            color: var(--accent);
        }

        /* Animaciones */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade {
            animation: fadeIn 0.4s ease-out;
        }

        /* Loader para operaciones asíncronas */
        .loader {
            width: 1.5rem;
            height: 1.5rem;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-right: 0.5rem;
            display: none;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Badges para categorías */
        .badge-categoria {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--accent);
            font-weight: 600;
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-header h4 {
                font-size: 1.25rem;
            }
            
            .table thead {
                display: none;
            }
            
            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }
            
            .table tr {
                margin-bottom: 1rem;
                border-bottom: 2px solid #ecf0f1;
            }
            
            .table td {
                text-align: right;
                padding-left: 50%;
                position: relative;
                border-bottom: 1px solid #ecf0f1;
            }
            
            .table td::before {
                content: attr(data-label);
                position: absolute;
                left: 1rem;
                width: 45%;
                text-align: left;
                font-weight: 600;
            }
            
            .action-btn {
                margin-bottom: 0.3rem;
            }
        }
    </style>

</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary);">
        <div class="container">
            <a class="navbar-brand" href="inicio.jsp">
                <i class="fas fa-book me-2"></i>
                Sistema Biblioteca
            </a>
        </div>
    </nav>

    <div class="container mt-4 animate-fade">
        <div class="page-header">
            <h1><i class="fas fa-book-open me-2"></i>Gestión de Libros</h1>
            <p>Administre el catálogo de libros de la biblioteca</p>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="search-box">
                    <h5 class="title"><i class="fas fa-filter"></i>Filtrar Libros</h5>
                    <form action="libro" method="post" class="row g-3">
                        <input type="hidden" name="accion" value="buscar">
                        <div class="col-md-4">
                            <label for="idCategoria" class="form-label">Categoría</label>
                            <select name="idCategoria" id="idCategoria" class="form-select" required>
                              
                                <%
                                    List<CategoriaLibro> categorias = (List<CategoriaLibro>) request.getAttribute("categorias");
                                    Integer categoriaSeleccionada = (Integer) request.getAttribute("categoriaSeleccionada");
                                    
                                    if (categorias != null) {
                                        for (CategoriaLibro categoria : categorias) {
                                            String selected = "";
                                            if (categoriaSeleccionada != null && categoria.getIdCategoria() == categoriaSeleccionada) {
                                                selected = "selected";
                                            }
                                %>
                                    <option value="<%= categoria.getIdCategoria() %>" <%= selected %>><%= categoria.getDescripcion() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary mb-3">
                                <i class="fas fa-search me-1"></i> Buscar
                            </button>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <a href="libro?accion=listar" class="btn btn-secondary mb-3">
                                <i class="fas fa-sync-alt me-1"></i> Mostrar Todo
                            </a>
                        </div>
                    </form>
                </div>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4><i class="fas fa-list me-2"></i>Listado de Libros</h4>
                        <div>
                            <button type="button" class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#exportModal">
                                <i class="fas fa-file-export me-1"></i> Exportar
                            </button>
                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#libroModal" onclick="resetFormulario()">
                                <i class="fas fa-plus me-1"></i> Nuevo Libro
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Título</th>
                                        <th>Año</th>
                                        <th>Serie</th>
                                        <th>Tema</th>
                                        <th>Categoría</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (librosPaginados != null && !librosPaginados.isEmpty()) {
                                            for (Libro libro : librosPaginados) {
                                    %>
                                        <tr>
                                            <td data-label="ID"><%= libro.getIdLibro() %></td>
                                            <td data-label="Título"><%= libro.getTitulo() %></td>
                                            <td data-label="Año"><%= libro.getAnio() %></td>
                                            <td data-label="Serie"><%= libro.getSerie() %></td>
                                            <td data-label="Tema"><%= libro.getTema() %></td>
                                            <td data-label="Categoría"><span class="badge-categoria"><%= libro.getDescripcionCategoria() %></span></td>
                                            <td data-label="Acciones">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-info btn-sm action-btn" 
                                                            onclick="verDetallesLibro(<%= libro.getIdLibro() %>, '<%= libro.getTitulo() %>', 
                                                                                <%= libro.getAnio() %>, '<%= libro.getSerie() %>', 
                                                                                '<%= libro.getTema() %>', '<%= libro.getDescripcionCategoria() %>')">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-warning btn-sm action-btn" 
                                                            onclick="editarLibro(<%= libro.getIdLibro() %>, '<%= libro.getTitulo() %>', 
                                                                                <%= libro.getAnio() %>, '<%= libro.getSerie() %>', 
                                                                                '<%= libro.getTema() %>', <%= libro.getIdCategoria() %>)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <a href="libro?accion=eliminar&id=<%= libro.getIdLibro() %>" class="btn btn-danger btn-sm action-btn" 
                                                    onclick="return confirm('¿Está seguro de eliminar este libro?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                        <tr>
                                            <td colspan="7" class="text-center py-4">
                                                <div class="empty-state">
                                                    <i class="fas fa-search fa-3x mb-3 text-muted"></i>
                                                    <h5>No se encontraron libros</h5>
                                                    <p class="text-muted">Intente con diferentes criterios de búsqueda o agregue un nuevo libro.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Paginación -->
                        <% if (totalPaginas > 1) { %>
                        <nav aria-label="Navegación de páginas" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item <%= paginaActual == 1 ? "disabled" : "" %>">
                                    <a class="page-link" href="?accion=<%= request.getAttribute("accion") != null ? request.getAttribute("accion") : "listar" %><%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= paginaActual - 1 %>" aria-label="Anterior">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <% 
                                int inicio = Math.max(1, paginaActual - 2);
                                int fin = Math.min(inicio + 4, totalPaginas);
                                
                                for (int i = inicio; i <= fin; i++) { 
                                %>
                                <li class="page-item <%= paginaActual == i ? "active" : "" %>">
                                    <a class="page-link" href="?accion=<%= request.getAttribute("accion") != null ? request.getAttribute("accion") : "listar" %><%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= i %>"><%= i %></a>
                                </li>
                                <% } %>
                                
                                <li class="page-item <%= paginaActual == totalPaginas ? "disabled" : "" %>">
                                    <a class="page-link" href="?accion=<%= request.getAttribute("accion") != null ? request.getAttribute("accion") : "listar" %><%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= paginaActual + 1 %>" aria-label="Siguiente">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <div class="text-center mb-2">
                            <small class="text-muted">Mostrando <%= indiceInicial + 1 %> - <%= indiceFinal %> de <%= totalRegistros %> registros</small>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Libro -->
    <div class="modal fade" id="libroModal" tabindex="-1" aria-labelledby="libroModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="libroModalLabel">
                        <i class="fas fa-book me-2"></i>Nuevo Libro
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="alertError" class="alert alert-danger" style="display: none;">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <span id="alertErrorMessage"></span>
                    </div>
                    
                    <form id="libroForm" action="libro" method="post">
                        <input type="hidden" id="accion" name="accion" value="insertar">
                        <input type="hidden" id="idLibro" name="idLibro" value="">
                        
                        <div class="mb-3">
                            <label for="titulo" class="form-label">Título</label>
                            <input type="text" class="form-control" id="titulo" name="titulo" required>
                            <div class="invalid-feedback">
                                El título es obligatorio.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="anio" class="form-label">Año</label>
                            <input type="number" class="form-control" id="anio" name="anio" required>
                            <div class="invalid-feedback">
                                El año debe ser un número válido.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="serie" class="form-label">Serie</label>
                            <input type="text" class="form-control" id="serie" name="serie" required>
                            <div class="invalid-feedback">
                                La serie es obligatoria.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="tema" class="form-label">Tema</label>
                            <input type="text" class="form-control" id="tema" name="tema" required>
                            <div class="invalid-feedback">
                                El tema es obligatorio.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="modalIdCategoria" class="form-label">Categoría</label>
                            <select class="form-select" id="modalIdCategoria" name="idCategoria" required>
                                <option value="">-- Seleccione una categoría --</option>
                                <%
                                    if (categorias != null) {
                                        for (CategoriaLibro categoria : categorias) {
                                %>
                                    <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getDescripcion() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <div class="invalid-feedback">
                                Debe seleccionar una categoría.
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i> Cancelar
                    </button>
                    <button type="button" class="btn btn-primary" onclick="validarFormulario()" id="btnSubmit">
                        <div class="d-flex align-items-center">
                            <span class="loader" id="submitLoader"></span>
                            <i class="fas fa-save me-1"></i> Guardar
                        </div>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Detalles del Libro -->
    <div class="modal fade" id="detalleLibroModal" tabindex="-1" aria-labelledby="detalleLibroModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detalleLibroModalLabel">
                        <i class="fas fa-info-circle me-2"></i>Detalles del Libro
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">ID:</div>
                        <div class="col-md-8" id="detalleId"></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">Título:</div>
                        <div class="col-md-8" id="detalleTitulo"></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">Año:</div>
                        <div class="col-md-8" id="detalleAnio"></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">Serie:</div>
                        <div class="col-md-8" id="detalleSerie"></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">Tema:</div>
                        <div class="col-md-8" id="detalleTema"></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4 fw-bold">Categoría:</div>
                        <div class="col-md-8" id="detalleCategoria"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i> Cerrar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Exportar -->
    <div class="modal fade" id="exportModal" tabindex="-1" aria-labelledby="exportModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exportModalLabel">
                        <i class="fas fa-file-export me-2"></i>Exportar Datos
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Seleccione el formato de exportación:</p>
                    <div class="d-grid gap-2">
                        <a href="libro?accion=exportar&formato=excel" class="btn btn-success">
                            <i class="fas fa-file-excel me-2"></i>Exportar a Excel
                        </a>
                        <a href="libro?accion=exportar&formato=pdf" class="btn btn-danger">
                            <i class="fas fa-file-pdf me-2"></i>Exportar a PDF
                        </a>
                        <a href="libro?accion=exportar&formato=csv" class="btn btn-primary">
                            <i class="fas fa-file-csv me-2"></i>Exportar a CSV
                        </a>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i> Cancelar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función para editar un libro
        function editarLibro(id, titulo, anio, serie, tema, idCategoria) {
            document.getElementById('libroModalLabel').innerHTML = '<i class="fas fa-edit me-2"></i>Editar Libro';
            document.getElementById('accion').value = 'actualizar';
            document.getElementById('idLibro').value = id;
            document.getElementById('titulo').value = titulo;
            document.getElementById('anio').value = anio;
            document.getElementById('serie').value = serie;
            document.getElementById('tema').value = tema;
            document.getElementById('modalIdCategoria').value = idCategoria;
            
            // Ocultar mensaje de error si está visible
            document.getElementById('alertError').style.display = 'none';
            
            // Eliminar clases de validación
            limpiarValidaciones();
            
            // Mostrar el modal
            var libroModal = new bootstrap.Modal(document.getElementById('libroModal'));
            libroModal.show();
        }
        
        // Función para ver detalles de un libro
        function verDetallesLibro(id, titulo, anio, serie, tema, categoria) {
            document.getElementById('detalleId').textContent = id;
            document.getElementById('detalleTitulo').textContent = titulo;
            document.getElementById('detalleAnio').textContent = anio;
            document.getElementById('detalleSerie').textContent = serie;
            document.getElementById('detalleTema').textContent = tema;
            document.getElementById('detalleCategoria').textContent = categoria;
            
            // Mostrar el modal
            var detalleModal = new bootstrap.Modal(document.getElementById('detalleLibroModal'));
            detalleModal.show();
        }
        
        // Función para resetear el formulario para nuevo libro
        function resetFormulario() {
            document.getElementById('libroModalLabel').innerHTML = '<i class="fas fa-plus me-2"></i>Nuevo Libro';
            document.getElementById('accion').value = 'insertar';
            document.getElementById('libroForm').reset();
            document.getElementById('idLibro').value = '';
            
            // Ocultar mensaje de error si está visible
            document.getElementById('alertError').style.display = 'none';
            
            // Eliminar clases de validación
            limpiarValidaciones();
        }
        
        // Función para limpiar validaciones
        function limpiarValidaciones() {
            const campos = ['titulo', 'anio', 'serie', 'tema', 'modalIdCategoria'];
            campos.forEach(function(campo) {
                document.getElementById(campo).classList.remove('is-invalid');
                document.getElementById(campo).classList.remove('is-valid');
            });
        }
        
        // Función para validar el formulario
        function validarFormulario() {
            const form = document.getElementById('libroForm');
            const titulo = document.getElementById('titulo');
            const anio = document.getElementById('anio');
            const serie = document.getElementById('serie');
            const tema = document.getElementById('tema');
            const categoria = document.getElementById('modalIdCategoria');
            
            let esValido = true;
            let mensajeError = '';
            
            // Limpiar validaciones previas
            limpiarValidaciones();
            
            // Validar título
            if (titulo.value.trim() === '') {
                titulo.classList.add('is-invalid');
                esValido = false;
                mensajeError = 'El título es obligatorio.';
            } else {
                titulo.classList.add('is-valid');
            }
            
            // Validar año
            if (anio.value.trim() === '' || isNaN(anio.value) || anio.value <= 0) {
                anio.classList.add('is-invalid');
                esValido = false;
                mensajeError = mensajeError || 'El año debe ser un número válido.';
            } else {
                anio.classList.add('is-valid');
            }
            
            // Validar serie
            if (serie.value.trim() === '') {
                serie.classList.add('is-invalid');
                esValido = false;
                mensajeError = mensajeError || 'La serie es obligatoria.';
            } else {
                serie.classList.add('is-valid');
            }
            
            // Validar tema
            if (tema.value.trim() === '') {
                tema.classList.add('is-invalid');
                esValido = false;
                mensajeError = mensajeError || 'El tema es obligatorio.';
            } else {
                tema.classList.add('is-valid');
            }
            
            // Validar categoría
            if (categoria.value === '') {
                categoria.classList.add('is-invalid');
                esValido = false;
                mensajeError = mensajeError || 'Debe seleccionar una categoría.';
            } else {
                categoria.classList.add('is-valid');
            }
            
            if (esValido) {
                // Mostrar loader
                document.getElementById('submitLoader').style.display = 'inline-block';
                document.getElementById('btnSubmit').disabled = true;
                
                // Ocultar mensaje de error
                document.getElementById('alertError').style.display = 'none';
                
                // Submit form
                form.submit();
            } else {
                // Mostrar mensaje de error
                document.getElementById('alertErrorMessage').textContent = mensajeError;
                document.getElementById('alertError').style.display = 'block';
            }
        }
        
        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {
            // Tooltips (opcional)
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            });
            
            // Verificar si hay mensaje de éxito o error en la URL (opcional)
            const urlParams = new URLSearchParams(window.location.search);
            const mensaje = urlParams.get('mensaje');
            if (mensaje) {
                // Implementar lógica para mostrar mensaje
                const tipo = urlParams.get('tipo') || 'success';
                mostrarNotificacion(mensaje, tipo);
            }
            
            // Agregar escuchadores para validación en tiempo real (opcional)
            const campos = ['titulo', 'anio', 'serie', 'tema', 'modalIdCategoria'];
            campos.forEach(function(campo) {
                document.getElementById(campo).addEventListener('input', function() {
                    // Ocultar mensaje de error si está visible
                    document.getElementById('alertError').style.display = 'none';
                });
            });
        });
        
        // Función para mostrar notificaciones
        function mostrarNotificacion(mensaje, tipo) {
            // Crear notificación toast (puedes implementar esto si deseas)
            console.log(`Notificación: ${mensaje} (${tipo})`);
        }
    </script>
</body>
</html>