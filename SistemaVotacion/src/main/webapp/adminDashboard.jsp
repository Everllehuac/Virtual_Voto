<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    Map<String, Object> estadisticas = (Map<String, Object>) request.getAttribute("estadisticas");
    if (estadisticas == null) estadisticas = new HashMap<>();
    
    List<Map<String, Object>> candidatosPresidente = (List<Map<String, Object>>) estadisticas.get("candidatosPresidente");
    if (candidatosPresidente == null) candidatosPresidente = new ArrayList<>();
    
    // Obtener el tipo de vista actual
    String vistaActual = request.getParameter("vista");
    if (vistaActual == null) vistaActual = "dashboard";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stats-card { 
            background: #f8f9fa; 
            border-radius: 10px; 
            padding: 15px; 
            margin-bottom: 15px;
            border-left: 4px solid #0d6efd;
        }
        .candidato-bar { 
            height: 20px; 
            background: linear-gradient(90deg, #0d6efd, #6f42c1); 
            border-radius: 10px; 
            margin: 5px 0; 
        }
        .sidebar { 
            background: #2c3e50; 
            min-height: 100vh;
        }
        .nav-link {
            color: #ecf0f1 !important;
            margin: 5px 0;
            border-radius: 5px;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #34495e !important;
            color: #3498db !important;
        }
        .content-section {
            display: none;
        }
        .content-section.active {
            display: block;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.1);
        }
        .upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .upload-area:hover {
            border-color: #0d6efd;
            background: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar text-white">
                <div class="p-3">
                    <h4><i class="bi bi-speedometer2 me-2"></i>Panel Admin</h4>
                    <p class="text-muted mb-3">
                        <i class="bi bi-person-circle me-1"></i>
                        <%= session.getAttribute("adminUsername") %>
                    </p>
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item">
                            <a class="nav-link <%= vistaActual.equals("dashboard") ? "active" : "" %>" 
                               href="#" onclick="mostrarSeccion('dashboard')">
                                <i class="bi bi-house-door me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= vistaActual.equals("estadisticas") ? "active" : "" %>" 
                               href="#" onclick="mostrarSeccion('estadisticas')">
                                <i class="bi bi-bar-chart me-2"></i>Estadísticas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= vistaActual.equals("historial") ? "active" : "" %>" 
                               href="#" onclick="mostrarSeccion('historial')">
                                <i class="bi bi-clock-history me-2"></i>Historial
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= vistaActual.equals("usuarios") ? "active" : "" %>" 
                               href="#" onclick="mostrarSeccion('usuarios')">
                                <i class="bi bi-people me-2"></i>Usuarios
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= vistaActual.equals("carga-datos") ? "active" : "" %>" 
                               href="#" onclick="mostrarSeccion('carga-datos')">
                                <i class="bi bi-upload me-2"></i>Cargar Datos
                            </a>
                        </li>
                        <li class="nav-item mt-4">
                            <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                                <button type="submit" class="nav-link btn btn-link text-danger p-0 w-100 text-start">
                                    <i class="bi bi-box-arrow-right me-2"></i>Cerrar Sesión
                                </button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 p-4">
                
                <!-- Sección: Dashboard -->
                <div id="dashboard" class="content-section <%= vistaActual.equals("dashboard") ? "active" : "" %>">
                    <!-- Header -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h2><i class="bi bi-speedometer2 me-2"></i>Dashboard Principal</h2>
                            <p class="text-muted">Resumen general del sistema de votación</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <select class="form-select w-50 d-inline-block">
                                <option>Seleccione una región</option>
                                <option>Lima</option>
                                <option>Arequipa</option>
                                <option>Cusco</option>
                                <option>Piura</option>
                            </select>
                            <button class="btn btn-outline-primary">Filtrar</button>
                        </div>
                    </div>

                    <!-- Estadísticas principales -->
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <h6><i class="bi bi-people me-2"></i>Sufragantes</h6>
                                <h3 class="text-primary"><%= estadisticas.getOrDefault("sufragantes", 15420) %></h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <h6><i class="bi bi-person-x me-2"></i>Ausentismo</h6>
                                <h3 class="text-warning"><%= estadisticas.getOrDefault("ausentismo", 2340) %></h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <h6><i class="bi bi-person-check me-2"></i>Electores</h6>
                                <h3 class="text-success"><%= estadisticas.getOrDefault("electores", 18500) %></h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <h6><i class="bi bi-percent me-2"></i>Participación</h6>
                                <h3 class="text-info">83.4%</h3>
                            </div>
                        </div>
                    </div>

                    <!-- Gráfico de resultados -->
                    <div class="row mt-4">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5><i class="bi bi-bar-chart me-2"></i>Elecciones Generales - Presidente/a</h5>
                                    <small class="text-muted">Fecha Corte: <%= new java.util.Date() %></small>
                                </div>
                                <div class="card-body">
                                    <canvas id="resultadosChart" height="200"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h6><i class="bi bi-trophy me-2"></i>Resultados por Candidato</h6>
                                </div>
                                <div class="card-body">
                                    <% for (Map<String, Object> candidato : candidatosPresidente) { %>
                                        <div class="mb-2">
                                            <small><%= candidato.get("nombre") %></small>
                                            <div class="d-flex align-items-center">
                                                <div class="candidato-bar" style="width: <%= candidato.get("porcentaje") %>%"></div>
                                                <span class="ms-2"><%= candidato.get("porcentaje") %>%</span>
                                            </div>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Estadísticas de votos -->
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <div class="stats-card text-center">
                                <h6><i class="bi bi-check-circle me-2"></i>Votos Válidos</h6>
                                <h3 class="text-success"><%= estadisticas.getOrDefault("votosValidos", 89) %>%</h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card text-center">
                                <h6><i class="bi bi-circle me-2"></i>Votos Blancos</h6>
                                <h3 class="text-warning"><%= estadisticas.getOrDefault("votosBlancos", 6) %>%</h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card text-center">
                                <h6><i class="bi bi-x-circle me-2"></i>Votos Nulos</h6>
                                <h3 class="text-danger"><%= estadisticas.getOrDefault("votosNulos", 5) %>%</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sección: Estadísticas -->
                <div id="estadisticas" class="content-section <%= vistaActual.equals("estadisticas") ? "active" : "" %>">
                    <h2><i class="bi bi-bar-chart me-2"></i>Estadísticas Detalladas</h2>
                    <p class="text-muted">Análisis completo de los resultados electorales</p>
                    
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Distribución por Región</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="regionChart" height="250"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Tendencia Temporal</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="tendenciaChart" height="250"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sección: Historial -->
                <div id="historial" class="content-section <%= vistaActual.equals("historial") ? "active" : "" %>">
                    <h2><i class="bi bi-clock-history me-2"></i>Historial de Votos</h2>
                    <p class="text-muted">Registro completo de todas las votaciones realizadas</p>
                    
                    <div class="card mt-4">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Buscar por DNI o nombre...">
                                </div>
                                <div class="col-md-6 text-end">
                                    <button class="btn btn-outline-primary">
                                        <i class="bi bi-download me-2"></i>Exportar
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID Voto</th>
                                            <th>DNI</th>
                                            <th>Nombre</th>
                                            <th>Fecha/Hora</th>
                                            <th>Región</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>V001</td>
                                            <td>71234567</td>
                                            <td>Juan Pérez</td>
                                            <td>2025-01-15 10:30</td>
                                            <td>Lima</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>V002</td>
                                            <td>72345678</td>
                                            <td>María García</td>
                                            <td>2025-01-15 11:15</td>
                                            <td>Arequipa</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sección: Usuarios -->
                <div id="usuarios" class="content-section <%= vistaActual.equals("usuarios") ? "active" : "" %>">
                    <h2><i class="bi bi-people me-2"></i>Gestión de Usuarios</h2>
                    <p class="text-muted">Administrar usuarios y permisos del sistema</p>
                    
                    <div class="card mt-4">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="mb-0">Lista de Usuarios Registrados</h5>
                                </div>
                                <div class="col-md-6 text-end">
                                    <button class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Nuevo Usuario
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Usuario</th>
                                            <th>Email</th>
                                            <th>Rol</th>
                                            <th>Estado</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>admin</td>
                                            <td>admin@sistema.com</td>
                                            <td><span class="badge bg-primary">Administrador</span></td>
                                            <td><span class="badge bg-success">Activo</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-warning me-1">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sección: Carga de Datos -->
                <div id="carga-datos" class="content-section <%= vistaActual.equals("carga-datos") ? "active" : "" %>">
                    <h2><i class="bi bi-upload me-2"></i>Carga de Datos</h2>
                    <p class="text-muted">Importar datos de electores, candidatos y resultados</p>
                    
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Cargar Padrón Electoral</h5>
                                </div>
                                <div class="card-body">
                                    <div class="upload-area" onclick="document.getElementById('filePadron').click()">
                                        <i class="bi bi-cloud-upload" style="font-size: 3rem;"></i>
                                        <p class="mt-3">Haz clic o arrastra archivo CSV</p>
                                        <small class="text-muted">Formato: DNI, Nombre, Apellido, Región</small>
                                    </div>
                                    <input type="file" id="filePadron" accept=".csv" style="display: none;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Cargar Candidatos</h5>
                                </div>
                                <div class="card-body">
                                    <div class="upload-area" onclick="document.getElementById('fileCandidatos').click()">
                                        <i class="bi bi-person-plus" style="font-size: 3rem;"></i>
                                        <p class="mt-3">Haz clic o arrastra archivo CSV</p>
                                        <small class="text-muted">Formato: Cargo, Nombre, Partido</small>
                                    </div>
                                    <input type="file" id="fileCandidatos" accept=".csv" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        // Función para mostrar secciones
        function mostrarSeccion(seccion) {
            // Ocultar todas las secciones
            document.querySelectorAll('.content-section').forEach(section => {
                section.classList.remove('active');
            });
            
            // Mostrar la sección seleccionada
            document.getElementById(seccion).classList.add('active');
            
            // Actualizar navegación activa
            document.querySelectorAll('.nav-link').forEach(link => {
                link.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Actualizar URL sin recargar
            history.pushState(null, null, '?vista=' + seccion);
        }

        // Configuración del gráfico principal
        const ctx = document.getElementById('resultadosChart').getContext('2d');
        const resultadosChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [
                    <% for (int i = 0; i < candidatosPresidente.size(); i++) { %>
                        '<%= candidatosPresidente.get(i).get("nombre") %>'<%= i < candidatosPresidente.size() - 1 ? "," : "" %>
                    <% } %>
                ],
                datasets: [{
                    label: 'Porcentaje de Votos',
                    data: [
                        <% for (int i = 0; i < candidatosPresidente.size(); i++) { %>
                            <%= candidatosPresidente.get(i).get("porcentaje") %><%= i < candidatosPresidente.size() - 1 ? "," : "" %>
                        <% } %>
                    ],
                    backgroundColor: [
                        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
                        '#FF9F40', '#FF6384', '#C9CBCF', '#4BC0C0', '#9966FF'
                    ]
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 25,
                        title: { display: true, text: 'Porcentaje (%)' }
                    }
                }
            }
        });

        // Gráficos adicionales para la sección de estadísticas
        document.addEventListener('DOMContentLoaded', function() {
            // Solo inicializar gráficos si la sección está activa
            if (document.getElementById('estadisticas').classList.contains('active')) {
                inicializarGraficosEstadisticas();
            }
        });

        function inicializarGraficosEstadisticas() {
            // Gráfico de regiones
            const regionCtx = document.getElementById('regionChart').getContext('2d');
            new Chart(regionCtx, {
                type: 'pie',
                data: {
                    labels: ['Lima', 'Arequipa', 'Cusco', 'Piura', 'La Libertad'],
                    datasets: [{
                        data: [35, 20, 15, 12, 18],
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
                    }]
                }
            });

            // Gráfico de tendencia
            const tendenciaCtx = document.getElementById('tendenciaChart').getContext('2d');
            new Chart(tendenciaCtx, {
                type: 'line',
                data: {
                    labels: ['08:00', '10:00', '12:00', '14:00', '16:00'],
                    datasets: [{
                        label: 'Votos por hora',
                        data: [1200, 4500, 7200, 8500, 9200],
                        borderColor: '#36A2EB',
                        tension: 0.4
                    }]
                }
            });
        }
    </script>
</body>
</html>