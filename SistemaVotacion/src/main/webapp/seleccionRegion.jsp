<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selecciona tu Región</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #0d47a1;
            --secondary-color: #1976d2;
            --accent-color: #2196f3;
            --light-color: #e3f2fd;
            --dark-color: #0d47a1;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .header {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .region-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            margin-bottom: 2rem;
        }
        
        .voter-info {
            background-color: var(--light-color);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 5px solid var(--primary-color);
        }
        
        .form-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(33, 150, 243, 0.25);
        }
        
        .btn-continue {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 40px;
            font-size: 1.1rem;
            border-radius: 50px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 1.5rem;
        }
        
        .btn-continue:hover {
            background-color: var(--secondary-color);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }
        
        .region-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }
        
        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
        
        .region-option {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .region-option i {
            color: var(--primary-color);
        }
        
        @media (max-width: 768px) {
            .region-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="d-flex align-items-center">
                <i class="bi bi-geo-alt-fill me-3" style="font-size: 2rem;"></i>
                <h1 class="h3 mb-0">Sistema de Votación Electrónica</h1>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container">
        <div class="region-container">
            <div class="text-center mb-4">
                <i class="bi bi-geo-alt region-icon"></i>
            </div>
            
            <div class="voter-info">
                <h2 class="mb-3">
                    <i class="bi bi-person-circle me-2"></i>
                    ¡Hola, <%= request.getParameter("nombre") != null ? request.getParameter("nombre") : "Votante" %>!
                </h2>
                <div class="row">
                    <div class="col-md-6">
                        <p class="mb-2"><strong>DNI:</strong> <%= request.getParameter("dni") %></p>
                        <p class="mb-2"><strong>Nombre completo:</strong> <%= request.getParameter("nombre") %> <%= request.getParameter("apellido") %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="mb-2"><strong>Fecha de nacimiento:</strong> <%= request.getParameter("fechaNacimiento") %></p>
                        <p class="mb-2"><strong>Edad:</strong> <%= request.getParameter("edad") %> años</p>
                    </div>
                </div>
            </div>

            <h3 class="mb-4">
                <i class="bi bi-map me-2"></i>
                Selecciona la región donde te toca votar:
            </h3>

            <form action="seleccionCandidato.jsp" method="GET">
                <!-- Pasamos también los datos del votante -->
                <input type="hidden" name="dni" value="<%= request.getParameter("dni") %>">
                <input type="hidden" name="nombre" value="<%= request.getParameter("nombre") %>">
                <input type="hidden" name="apellido" value="<%= request.getParameter("apellido") %>">
                <input type="hidden" name="fechaNacimiento" value="<%= request.getParameter("fechaNacimiento") %>">
                <input type="hidden" name="edad" value="<%= request.getParameter("edad") %>">

                <div class="mb-3">
                    <select class="form-select" name="region" required>
                        <option value="">-- Selecciona tu región --</option>
                        <option value="Lima" class="region-option"><i class="bi bi-building"></i> Lima</option>
                        <option value="Arequipa" class="region-option"><i class="bi bi-building"></i> Arequipa</option>
                        <option value="Cusco" class="region-option"><i class="bi bi-building"></i> Cusco</option>
                        <option value="Trujillo" class="region-option"><i class="bi bi-building"></i> Trujillo</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Piura</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Huancayo</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Ayacucho</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Pucallpa</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Ucayali</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Ica</option>
                        <option value="Piura" class="region-option"><i class="bi bi-building"></i> Lambayeque</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-continue">
                    <i class="bi bi-arrow-right-circle-fill"></i>
                    Continuar
                </button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Sistema de Votación Electrónica</h5>
                    <p>Un sistema seguro y transparente para ejercer tu derecho al voto.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2025 Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>