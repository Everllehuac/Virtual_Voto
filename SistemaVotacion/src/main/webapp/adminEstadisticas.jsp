<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    Map<String, Object> estadisticas = (Map<String, Object>) request.getAttribute("estadisticas");
    if (estadisticas == null) estadisticas = new HashMap<>();
    
    List<Map<String, Object>> candidatosPresidente = (List<Map<String, Object>>) estadisticas.get("candidatosPresidente");
    List<Map<String, Object>> candidatosCongresista = (List<Map<String, Object>>) estadisticas.get("candidatosCongresista");
    List<Map<String, Object>> candidatosAlcalde = (List<Map<String, Object>>) estadisticas.get("candidatosAlcalde");
    
    if (candidatosPresidente == null) candidatosPresidente = new ArrayList<>();
    if (candidatosCongresista == null) candidatosCongresista = new ArrayList<>();
    if (candidatosAlcalde == null) candidatosAlcalde = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Estadísticas - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar { background: #2c3e50; }
        .stats-card { background: #f8f9fa; border-radius: 10px; padding: 15px; margin-bottom: 15px; }
        .progress-bar-custom { background: linear-gradient(90deg, #0d6efd, #6f42c1); }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar text-white vh-100">
                <div class="p-3">
                    <h4>Panel Admin</h4>
                    <p class="text-muted">Bienvenido, <%= session.getAttribute("adminUsername") %></p>
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/estadisticas">Estadísticas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/historial">Historial</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/usuarios">Usuarios</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/carga-datos">Cargar Datos</a>
                        </li>
                        <li class="nav-item">
                            <form action="${pageContext.request.contextPath}/admin/dashboard" method="post" class="d-inline">
                                <input type="hidden" name="action" value="logout">
                                <button type="submit" class="nav-link text-white btn btn-link p-0">Cerrar Sesión</button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="p-4">
                    <h2>Estadísticas Detalladas</h2>
                    
                    <!-- Filtros -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <label class="form-label">Tipo de Elección:</label>
                            <select class="form-select" id="tipoEleccion" onchange="cambiarTipoEleccion()">
                                <option value="presidente">Presidente</option>
                                <option value="congresista">Congresistas</option>
                                <option value="alcalde">Alcaldes</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Región:</label>
                            <select class="form-select" id="filtroRegion">
                                <option value="">Todas las regiones</option>
                                <option value="lima">Lima</option>
                                <option value="arequipa">Arequipa</option>
                                <option value="cuzco">Cuzco</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">&nbsp;</label>
                            <div class="d-grid gap-2 d-md-flex">
                                <button class="btn btn-primary me-2" onclick="aplicarFiltros()">Aplicar Filtros</button>
                                <button class="btn btn-outline-success" onclick="generarReporte()">Generar Reporte</button>
                            </div>
                        </div>
                    </div>

                    <!-- Estadísticas generales -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="stats-card text-center">
                                <h6>Total Electores</h6>
                                <h3 class="text-primary"><%= estadisticas.getOrDefault("electores", 0) %></h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card text-center">
                                <h6>Participación</h6>
                                <h3 class="text-success">81.2%</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card text-center">
                                <h6>Votos Válidos</h6>
                                <h3 class="text-info">94.3%</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card text-center">
                                <h6>Votos Nulos/Blancos</h6>
                                <h3 class="text-warning">5.7%</h3>
                            </div>
                        </div>
                    </div>

                    <!-- Gráficos principales -->
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 id="tituloGrafico">Resultados - Elección Presidencial</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="graficoPrincipal" height="250"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Distribución por Género</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="graficoGenero" height="250"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Resultados detallados por candidato -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Resultados Detallados por Candidato</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Posición</th>
                                                    <th>Candidato</th>
                                                    <th>Partido</th>
                                                    <th>Votos</th>
                                                    <th>Porcentaje</th>
                                                    <th>Progress</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tablaResultados">
                                                <% for (int i = 0; i < candidatosPresidente.size(); i++) { 
                                                    Map<String, Object> cand = candidatosPresidente.get(i);
                                                %>
                                                    <tr>
                                                        <td><%= i + 1 %></td>
                                                        <td><strong><%= cand.get("nombre") %></strong></td>
                                                        <td><%= cand.get("partido") %></td>
                                                        <td>1,850,000</td>
                                                        <td><strong><%= cand.get("porcentaje") %>%</strong></td>
                                                        <td>
                                                            <div class="progress" style="height: 10px;">
                                                                <div class="progress-bar progress-bar-custom" 
                                                                     style="width: <%= cand.get("porcentaje") %>%">
                                                                </div>
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
                    </div>

                    <!-- Gráficos adicionales -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Participación por Región</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="graficoRegion" height="200"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Participación por Edad</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="graficoEdad" height="200"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Datos para los gráficos
        const datosPresidente = {
            labels: [<%= generarLabels(candidatosPresidente) %>],
            data: [<%= generarDatos(candidatosPresidente) %>]
        };

        const datosCongresista = {
            labels: ['Juan Pérez', 'Ana Gómez', 'Luis Ramírez', 'María Flores', 'Carlos Rojas'],
            data: [28.5, 24.3, 19.7, 15.2, 12.3]
        };

        const datosAlcalde = {
            labels: ['Miguel Torres', 'Lucía Sánchez', 'Raúl Díaz', 'Carla Paredes', 'Eduardo Molina'],
            data: [32.1, 25.4, 18.9, 12.7, 10.9]
        };

        let graficoPrincipal;

        function inicializarGraficos() {
            // Gráfico principal
            const ctx = document.getElementById('graficoPrincipal').getContext('2d');
            graficoPrincipal = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: datosPresidente.labels,
                    datasets: [{
                        label: 'Porcentaje de Votos',
                        data: datosPresidente.data,
                        backgroundColor: [
                            '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
                            '#FF9F40', '#8c9eff', '#4db6ac', '#ffb74d', '#a1887f',
                            '#90a4ae', '#7986cb', '#4dd0e1', '#81c784', '#fff176'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 25,
                            title: {
                                display: true,
                                text: 'Porcentaje (%)'
                            }
                        }
                    }
                }
            });

            // Gráfico de género
            const ctxGenero = document.getElementById('graficoGenero').getContext('2d');
            new Chart(ctxGenero, {
                type: 'doughnut',
                data: {
                    labels: ['Masculino', 'Femenino', 'No binario'],
                    datasets: [{
                        data: [48, 50, 2],
                        backgroundColor: ['#36A2EB', '#FF6384', '#FFCE56']
                    }]
                }
            });

            // Gráfico por región
            const ctxRegion = document.getElementById('graficoRegion').getContext('2d');
            new Chart(ctxRegion, {
                type: 'pie',
                data: {
                    labels: ['Lima', 'Arequipa', 'Cuzco', 'La Libertad', 'Piura', 'Otros'],
                    datasets: [{
                        data: [35, 15, 12, 10, 8, 20],
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40']
                    }]
                }
            });

            // Gráfico por edad
            const ctxEdad = document.getElementById('graficoEdad').getContext('2d');
            new Chart(ctxEdad, {
                type: 'line',
                data: {
                    labels: ['18-25', '26-35', '36-45', '46-55', '56-65', '65+'],
                    datasets: [{
                        label: 'Participación (%)',
                        data: [65, 78, 82, 75, 68, 55],
                        borderColor: '#36A2EB',
                        backgroundColor: 'rgba(54, 162, 235, 0.1)',
                        fill: true
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    }
                }
            });
        }

        function cambiarTipoEleccion() {
            const tipo = document.getElementById('tipoEleccion').value;
            let datos, titulo;

            switch(tipo) {
                case 'presidente':
                    datos = datosPresidente;
                    titulo = 'Resultados - Elección Presidencial';
                    break;
                case 'congresista':
                    datos = datosCongresista;
                    titulo = 'Resultados - Elección de Congresistas';
                    break;
                case 'alcalde':
                    datos = datosAlcalde;
                    titulo = 'Resultados - Elección de Alcaldes';
                    break;
            }

            // Actualizar gráfico principal
            graficoPrincipal.data.labels = datos.labels;
            graficoPrincipal.data.datasets[0].data = datos.data;
            graficoPrincipal.update();

            // Actualizar título
            document.getElementById('tituloGrafico').textContent = titulo;

            // Aquí también actualizarías la tabla de resultados
            console.log('Cambiando a:', tipo);
        }

        function aplicarFiltros() {
            const tipo = document.getElementById('tipoEleccion').value;
            const region = document.getElementById('filtroRegion').value;
            alert(`Aplicando filtros: Tipo=${tipo}, Región=${region}`);
        }

        function generarReporte() {
            const tipo = document.getElementById('tipoEleccion').value;
            alert(`Generando reporte para: ${tipo}`);
        }

        // Inicializar gráficos cuando la página cargue
        document.addEventListener('DOMContentLoaded', inicializarGraficos);
    </script>
</body>
</html>

<%!
    // Métodos helper para generar datos
    private String generarLabels(List<Map<String, Object>> candidatos) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < candidatos.size(); i++) {
            sb.append("'").append(candidatos.get(i).get("nombre")).append("'");
            if (i < candidatos.size() - 1) {
                sb.append(", ");
            }
        }
        return sb.toString();
    }

    private String generarDatos(List<Map<String, Object>> candidatos) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < candidatos.size(); i++) {
            sb.append(candidatos.get(i).get("porcentaje"));
            if (i < candidatos.size() - 1) {
                sb.append(", ");
            }
        }
        return sb.toString();
    }
%>