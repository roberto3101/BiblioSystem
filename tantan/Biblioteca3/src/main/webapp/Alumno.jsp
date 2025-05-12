<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, app.modelos.Alumno, app.modelos.Pais" %>
<%
    List<Alumno> lista = (List<Alumno>) request.getAttribute("alumnos");
    List<Pais> paises = (List<Pais>) request.getAttribute("paises");
    Alumno alumnoEditar = (Alumno) request.getAttribute("alumnoEditar");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Alumnos</title>
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

        .page-header h2 {
            color: var(--primary);
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }

        .page-header h2 i {
            margin-right: 0.75rem;
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

        .card-header h3 {
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
        }

        .card-header h3 i {
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

        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #2c3c4e;
            border-color: #2c3c4e;
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

        .badge {
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.75rem;
        }

        .badge-success {
            background-color: rgba(39, 174, 96, 0.1);
            color: var(--success);
        }

        .badge-danger {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        .action-btn {
            margin-right: 0.3rem;
            padding: 0.25rem 0.6rem;
            font-size: 0.875rem;
        }

        .action-btn i {
            margin-right: 0.3rem;
        }

        /* Animaciones */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade {
            animation: fadeIn 0.4s ease-out;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-header h3 {
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
                <i class="fas fa-user-graduate me-2"></i>
                Sistema Académico
            </a>
        </div>
    </nav>

    <div class="container mt-4 animate-fade">
        <div class="page-header">
            <h2><i class="fas fa-users me-2"></i>Gestión de Alumnos</h2>
            <p>Administre la información de los alumnos registrados en el sistema</p>
        </div>

        <!-- Formulario de Registro / Edición -->
        <div class="card mb-5">
            <div class="card-header">
                <h3>
                    <i class="fas <%= (alumnoEditar != null) ? "fa-edit" : "fa-user-plus" %> me-2"></i>
                    <%= (alumnoEditar != null) ? "Editar Alumno" : "Registrar Nuevo Alumno" %>
                </h3>
            </div>
            <div class="card-body">
                <form action="AlumnoServlet" method="post">
                    <input type="hidden" name="accion" value="<%= (alumnoEditar != null) ? "actualizar" : "registrar" %>">
                    <input type="hidden" name="idAlumno" value="<%= (alumnoEditar != null) ? alumnoEditar.getIdAlumno() : "" %>">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Nombres:</label>
                            <input type="text" name="nombres" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getNombres() : "" %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Apellidos:</label>
                            <input type="text" name="apellidos" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getApellidos() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Teléfono:</label>
                            <input type="text" name="telefono" class="form-control" value="<%= (alumnoEditar != null) ? alumnoEditar.getTelefono() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">DNI:</label>
                            <input type="text" name="dni" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getDni() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Correo:</label>
                            <input type="email" name="correo" class="form-control" value="<%= (alumnoEditar != null) ? alumnoEditar.getCorreo() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Fecha Nacimiento:</label>
                            <input type="date" name="fechaNacimiento" class="form-control" value="<%= (alumnoEditar != null && alumnoEditar.getFechaNacimiento() != null) ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(alumnoEditar.getFechaNacimiento()) : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Estado:</label>
                            <select name="estado" class="form-select">
                                <option value="1" <%= (alumnoEditar != null && alumnoEditar.getEstado() == 1) ? "selected" : "" %>>Activo</option>
                                <option value="0" <%= (alumnoEditar != null && alumnoEditar.getEstado() == 0) ? "selected" : "" %>>Inactivo</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">País:</label>
                            <select name="idPais" class="form-select" required>
                                <option value="">-- Seleccionar --</option>
                                <% for (Pais p : paises) { %>
                                    <option value="<%= p.getIdPais() %>" <%= (alumnoEditar != null && p.getIdPais() == alumnoEditar.getIdPais()) ? "selected" : "" %>><%= p.getNombre() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas <%= (alumnoEditar != null) ? "fa-sync-alt" : "fa-save" %> me-2"></i>
                            <%= (alumnoEditar != null) ? "Actualizar" : "Registrar" %>
                        </button>
                        <a href="AlumnoServlet" class="btn btn-secondary">
                            <i class="fas fa-broom me-2"></i>Limpiar
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Listado de Alumnos -->
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list me-2"></i>Listado de Alumnos</h3>
            </div>
            <div class="card-body p-0">
            <div id="alertaErrores" class="alert alert-danger d-none" role="alert">
               <ul id="listaErrores" class="mb-0"></ul>
               </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Teléfono</th>
                                <th>DNI</th>
                                <th>Correo</th>
                                <th>F. Nacimiento</th>
                                <th>País</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (lista != null && !lista.isEmpty()) {
                                for (Alumno a : lista) { %>
                                    <tr>
                                        <td data-label="ID"><%= a.getIdAlumno() %></td>
                                        <td data-label="Nombres"><%= a.getNombres() %></td>
                                        <td data-label="Apellidos"><%= a.getApellidos() %></td>
                                        <td data-label="Teléfono"><%= a.getTelefono() %></td>
                                        <td data-label="DNI"><%= a.getDni() %></td>
                                        <td data-label="Correo"><%= a.getCorreo() %></td>
                                        <td data-label="F. Nacimiento"><%= a.getFechaNacimiento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(a.getFechaNacimiento()) : "" %></td>
                                        <td data-label="País"><%= a.getNombrePais() %></td>
                                        <td data-label="Estado">
                                            <span class="badge <%= (a.getEstado() == 1) ? "badge-success" : "badge-danger" %>">
                                                <%= (a.getEstado() == 1) ? "Activo" : "Inactivo" %>
                                            </span>
                                        </td>
                                        <td data-label="Acciones">
                                            <div class="btn-group">
                                                <a href="AlumnoServlet?accion=editar&id=<%= a.getIdAlumno() %>" class="btn btn-warning btn-sm action-btn">
                                                    <i class="fas fa-edit"></i> Editar
                                                </a>
                                                <a href="AlumnoServlet?accion=eliminar&id=<%= a.getIdAlumno() %>" class="btn btn-danger btn-sm action-btn" onclick="return confirm('¿Está seguro que desea eliminar este alumno?')">
                                                    <i class="fas fa-trash"></i> Eliminar
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                            <%  }
                            } else { %>
                                <tr>
                                    <td colspan="10" class="text-center py-4">
                                        <div class="empty-state">
                                            <i class="fas fa-users fa-3x mb-3 text-muted"></i>
                                            <h5>No se encontraron alumnos registrados</h5>
                                            <p class="text-muted">Utilice el formulario superior para registrar un nuevo alumno.</p>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.querySelector('form').addEventListener('submit', function (e) {
        const errores = [];
        const nombres = document.querySelector('input[name="nombres"]').value.trim();
        const apellidos = document.querySelector('input[name="apellidos"]').value.trim();
        const telefono = document.querySelector('input[name="telefono"]').value.trim();
        const dni = document.querySelector('input[name="dni"]').value.trim();
        const correo = document.querySelector('input[name="correo"]').value.trim();
        const fechaNacimiento = document.querySelector('input[name="fechaNacimiento"]').value;
        const estado = document.querySelector('select[name="estado"]').value;
        const pais = document.querySelector('select[name="idPais"]').value;

        // Validaciones básicas
        if (nombres.length < 2 || !nombres.replace(/\s/g, '').length) errores.push("El nombre debe tener al menos 2 caracteres y no ser solo espacios.");
        if (apellidos.length < 2 || !apellidos.replace(/\s/g, '').length) errores.push("El apellido debe tener al menos 2 caracteres y no ser solo espacios.");
        if (!/^\d{8}$/.test(dni)) errores.push("El DNI debe tener 8 dígitos numéricos.");
        
        // Validación del teléfono
        if (telefono && !/^\d{9}$/.test(telefono)) errores.push("El teléfono debe tener 9 dígitos numéricos.");

        // Validación del correo (ahora obligatorio)
        if (!correo) {
            errores.push("El correo es obligatorio.");
        } else if (!/^[^@]+@[^@]+\.[a-zA-Z]{2,}$/.test(correo)) {
            errores.push("El correo no tiene un formato válido.");
        }

        // Validación de la fecha de nacimiento
        if (!fechaNacimiento) {
            errores.push("Debe ingresar una fecha de nacimiento.");
        } else {
            const fechaNac = new Date(fechaNacimiento);
            const hoy = new Date();
            if (fechaNac >= hoy) errores.push("La fecha de nacimiento debe ser anterior a hoy.");
        }

        // Validación del estado
        if (!["0", "1"].includes(estado)) errores.push("Debe seleccionar un estado válido (Activo o Inactivo).");

        // Validación del país
        if (!pais) errores.push("Debe seleccionar un país.");

        // Mostrar errores si existen
        const alerta = document.getElementById('alertaErrores');
        const lista = document.getElementById('listaErrores');
        lista.innerHTML = "";
        if (errores.length > 0) {
            e.preventDefault(); // Cancelar envío
            errores.forEach(error => {
                const li = document.createElement('li');
                li.textContent = error;
                lista.appendChild(li);
            });
            alerta.classList.remove('d-none');
            alerta.scrollIntoView({ behavior: "smooth" });
        } else {
            alerta.classList.add('d-none'); // Ocultar si no hay errores
        }
    });
</script>
</body>
</html>
