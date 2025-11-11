<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> usuarios = (List<Map<String, Object>>) request.getAttribute("usuarios");
    if (usuarios == null) usuarios = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Usuarios - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar { background: #2c3e50; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; }
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
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/historial">Historial</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/usuarios">Usuarios</a>
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
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2>Gestión de Usuarios</h2>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#nuevoUsuarioModal">
                            <i class="fas fa-plus"></i> Nuevo Usuario
                        </button>
                    </div>

                    <!-- Estadísticas de usuarios -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body text-center">
                                    <h5>Total Usuarios</h5>
                                    <h3>15,248</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body text-center">
                                    <h5>Usuarios Activos</h5>
                                    <h3>14,125</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-white">
                                <div class="card-body text-center">
                                    <h5>Usuarios Inactivos</h5>
                                    <h3>1,123</h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-info text-white">
                                <div class="card-body text-center">
                                    <h5>Votaron Hoy</h5>
                                    <h3>1,247</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros y búsqueda -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="Buscar usuario..." id="buscarUsuario">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" id="filtroEstado">
                                <option value="">Todos los estados</option>
                                <option value="activo">Activo</option>
                                <option value="inactivo">Inactivo</option>
                                <option value="pendiente">Pendiente</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" id="filtroRol">
                                <option value="">Todos los roles</option>
                                <option value="votante">Votante</option>
                                <option value="admin">Administrador</option>
                                <option value="supervisor">Supervisor</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-outline-primary w-100" onclick="filtrarUsuarios()">Filtrar</button>
                        </div>
                    </div>

                    <!-- Tabla de usuarios -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Lista de Usuarios</h5>
                            <div>
                                <button class="btn btn-sm btn-outline-success me-2" onclick="exportarUsuarios()">
                                    Exportar CSV
                                </button>
                                <button class="btn btn-sm btn-outline-info" onclick="actualizarUsuarios()">
                                    Actualizar
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Usuario</th>
                                            <th>Nombre Completo</th>
                                            <th>Email</th>
                                            <th>Rol</th>
                                            <th>Región</th>
                                            <th>Estado</th>
                                            <th>Último Acceso</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Datos de ejemplo -->
                                        <tr>
                                            <td>U001</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar bg-primary text-white d-flex align-items-center justify-content-center me-2">
                                                        JP
                                                    </div>
                                                    juan.perez
                                                </div>
                                            </td>
                                            <td>Juan Pérez García</td>
                                            <td>juan.perez@email.com</td>
                                            <td><span class="badge bg-success">Votante</span></td>
                                            <td>Lima</td>
                                            <td><span class="badge bg-success">Activo</span></td>
                                            <td>20/08/2023 10:30</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info me-1" onclick="editarUsuario('U001')">
                                                    Editar
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" onclick="eliminarUsuario('U001')">
                                                    Eliminar
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>U002</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar bg-success text-white d-flex align-items-center justify-content-center me-2">
                                                        AG
                                                    </div>
                                                    ana.gomez
                                                </div>
                                            </td>
                                            <td>Ana Gómez López</td>
                                            <td>ana.gomez@email.com</td>
                                            <td><span class="badge bg-primary">Administrador</span></td>
                                            <td>Arequipa</td>
                                            <td><span class="badge bg-success">Activo</span></td>
                                            <td>20/08/2023 09:15</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info me-1" onclick="editarUsuario('U002')">
                                                    Editar
                                                </button>
                                                <button class="btn btn-sm btn-outline-warning" onclick="desactivarUsuario('U002')">
                                                    Desactivar
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>U003</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar bg-warning text-white d-flex align-items-center justify-content-center me-2">
                                                        LR
                                                    </div>
                                                    luis.ramirez
                                                </div>
                                            </td>
                                            <td>Luis Ramírez Torres</td>
                                            <td>luis.ramirez@email.com</td>
                                            <td><span class="badge bg-info">Supervisor</span></td>
                                            <td>Cuzco</td>
                                            <td><span class="badge bg-warning">Inactivo</span></td>
                                            <td>15/08/2023 14:20</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-info me-1" onclick="editarUsuario('U003')">
                                                    Editar
                                                </button>
                                                <button class="btn btn-sm btn-outline-success" onclick="activarUsuario('U003')">
                                                    Activar
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

    <!-- Modal Nuevo Usuario -->
    <div class="modal fade" id="nuevoUsuarioModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Nuevo Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formNuevoUsuario">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Nombre</label>
                                    <input type="text" class="form-control" name="nombre" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" name="apellidos" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Usuario</label>
                                    <input type="text" class="form-control" name="usuario" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" name="password" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Confirmar Contraseña</label>
                                    <input type="password" class="form-control" name="confirmPassword" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Rol</label>
                                    <select class="form-select" name="rol" required>
                                        <option value="votante">Votante</option>
                                        <option value="admin">Administrador</option>
                                        <option value="supervisor">Supervisor</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Región</label>
                                    <select class="form-select" name="region" required>
                                        <option value="lima">Lima</option>
                                        <option value="arequipa">Arequipa</option>
                                        <option value="cuzco">Cuzco</option>
                                        <option value="trujillo">Trujillo</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="guardarUsuario()">Guardar Usuario</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filtrarUsuarios() {
            const busqueda = document.getElementById('buscarUsuario').value;
            const estado = document.getElementById('filtroEstado').value;
            const rol = document.getElementById('filtroRol').value;
            
            console.log('Filtrando usuarios:', {busqueda, estado, rol});
            alert('Funcionalidad de filtrado en desarrollo');
        }

        function editarUsuario(idUsuario) {
            alert(`Editando usuario: ${idUsuario}`);
        }

        function eliminarUsuario(idUsuario) {
            if (confirm('¿Está seguro de eliminar este usuario?')) {
                alert(`Usuario ${idUsuario} eliminado`);
            }
        }

        function activarUsuario(idUsuario) {
            alert(`Usuario ${idUsuario} activado`);
        }

        function desactivarUsuario(idUsuario) {
            alert(`Usuario ${idUsuario} desactivado`);
        }

        function guardarUsuario() {
            alert('Guardando nuevo usuario');
            // Cerrar modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('nuevoUsuarioModal'));
            modal.hide();
        }

        function exportarUsuarios() {
            alert('Exportando usuarios a CSV');
        }

        function actualizarUsuarios() {
            alert('Actualizando lista de usuarios');
        }
    </script>
</body>
</html>