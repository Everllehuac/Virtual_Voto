<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> historial = (List<Map<String, Object>>) request.getAttribute("historial");
    if (historial == null) historial = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Historial de Votos - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar { background: #2c3e50; }
        .table-hover tbody tr:hover { background-color: rgba(0,0,0,.075); }
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
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/estadisticas">Estadísticas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/historial">Historial</a>
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
                    <h2>Historial de Votos</h2>
                    
                    <!-- Filtros -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <label class="form-label">Fecha desde:</label>
                            <input type="date" class="form-control" id="fechaDesde">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Fecha hasta:</label>
                            <input type="date" class="form-control" id="fechaHasta">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Cargo:</label>
                            <select class="form-select" id="filtroCargo">
                                <option value="">Todos los cargos</option>
                                <option value="PRESIDENTE">Presidente</option>
                                <option value="CONGRESISTA">Congresista</option>
                                <option value="ALCALDE">Alcalde</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">&nbsp;</label>
                            <button class="btn btn-primary w-100" onclick="filtrarHistorial()">Filtrar</button>
                        </div>
                    </div>

                    <!-- Estadísticas rápidas -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body text-center">
                                    <h5>Total Votos</h5>
                                    <h3>15,248</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body text-center">
                                    <h5>Votos Hoy</h5>
                                    <h3>1,247</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-info text-white">
                                <div class="card-body text-center">
                                    <h5>Votos Válidos</h5>
                                    <h3>14,125</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-white">
                                <div class="card-body text-center">
                                    <h5>Votos Nulos</h5>
                                    <h3>125</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tabla de historial -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Registro de Votos</h5>
                            <button class="btn btn-sm btn-outline-primary" onclick="exportarExcel()">
                                Exportar Excel
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID Voto</th>
                                            <th>Fecha/Hora</th>
                                            <th>Región</th>
                                            <th>Candidato</th>
                                            <th>Cargo</th>
                                            <th>Partido</th>
                                            <th>IP</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Map<String, Object> voto : historial) { %>
                                            <tr>
                                                <td><%= voto.get("id") %></td>
                                                <td><%= voto.get("fecha") %></td>
                                                <td><%= voto.get("provincia") %></td>
                                                <td><%= voto.get("candidato") %></td>
                                                <td>
                                                    <span class="badge 
                                                        <%= "PRESIDENTE".equals(voto.get("cargo")) ? "bg-primary" : 
                                                           "CONGRESISTA".equals(voto.get("cargo")) ? "bg-success" : "bg-warning" %>">
                                                        <%= voto.get("cargo") %>
                                                    </span>
                                                </td>
                                                <td><%= voto.get("partido") != null ? voto.get("partido") : "N/A" %></td>
                                                <td><small class="text-muted"><%= voto.get("ip") %></small></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-info" 
                                                            onclick="verDetalle('<%= voto.get("id") %>')">
                                                        Ver
                                                    </button>
                                                </td>
                                            </tr>
                                        <% } %>
                                        
                                        <!-- Datos de ejemplo -->
                                        <tr>
                                            <td>V001235</td>
                                            <td>20/08/2023 10:31:15</td>
                                            <td>Lima</td>
                                            <td>Keiko Fujimori</td>
                                            <td><span class="badge bg-primary">PRESIDENTE</span></td>
                                            <td>Fuerza Popular</td>
                                            <td><small class="text-muted">192.168.1.101</small></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info" onclick="verDetalle('V001235')">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>V001236</td>
                                            <td>20/08/2023 10:32:45</td>
                                            <td>Arequipa</td>
                                            <td>Juan Pérez</td>
                                            <td><span class="badge bg-success">CONGRESISTA</span></td>
                                            <td>Partido A</td>
                                            <td><small class="text-muted">192.168.1.102</small></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info" onclick="verDetalle('V001236')">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Paginación -->
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">Anterior</a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Siguiente</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para detalles -->
    <div class="modal fade" id="detalleModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del Voto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="detalleContenido">
                    <!-- Contenido dinámico -->
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filtrarHistorial() {
            const fechaDesde = document.getElementById('fechaDesde').value;
            const fechaHasta = document.getElementById('fechaHasta').value;
            const cargo = document.getElementById('filtroCargo').value;
            
            // Aquí iría la lógica de filtrado real
            console.log('Filtrando:', {fechaDesde, fechaHasta, cargo});
            alert('Funcionalidad de filtrado en desarrollo');
        }
        
        function verDetalle(idVoto) {
            // Simular datos del voto
            const detalle = `
                <div class="row">
                    <div class="col-md-6">
                        <h6>Información del Voto</h6>
                        <p><strong>ID:</strong> ${idVoto}</p>
                        <p><strong>Fecha:</strong> 20/08/2023 10:30:25</p>
                        <p><strong>IP:</strong> 192.168.1.100</p>
                    </div>
                    <div class="col-md-6">
                        <h6>Información del Votante</h6>
                        <p><strong>Región:</strong> Lima</p>
                        <p><strong>Distrito:</strong> Miraflores</p>
                        <p><strong>Centro de Votación:</strong> Colegio 1234</p>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <h6>Candidatos Seleccionados</h6>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <strong>Presidente:</strong> Pedro Castillo - Perú Libre
                            </li>
                            <li class="list-group-item">
                                <strong>Congresista:</strong> Juan Pérez - Partido A
                            </li>
                            <li class="list-group-item">
                                <strong>Alcalde:</strong> Miguel Torres - Partido X
                            </li>
                        </ul>
                    </div>
                </div>
            `;
            
            document.getElementById('detalleContenido').innerHTML = detalle;
            const modal = new bootstrap.Modal(document.getElementById('detalleModal'));
            modal.show();
        }
        
        function exportarExcel() {
            alert('Funcionalidad de exportación en desarrollo');
        }
    </script>
</body>
</html>