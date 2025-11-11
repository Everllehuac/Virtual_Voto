<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selecciona tus candidatos</title>
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
        
        .voting-container {
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
        
        .candidate-section {
            margin-bottom: 2.5rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .candidate-section:last-child {
            border-bottom: none;
        }
        
        .section-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .candidates-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .candidate-card {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
            background-color: white;
            position: relative;
            overflow: hidden;
        }
        
        .candidate-card:hover {
            background-color: var(--light-color);
            border-color: var(--accent-color);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .candidate-card.selected {
            background-color: var(--light-color);
            border-color: var(--primary-color);
            box-shadow: 0 5px 15px rgba(13, 71, 161, 0.2);
        }
        
        .candidate-card.selected::after {
            content: '';
            position: absolute;
            top: 10px;
            right: 10px;
            width: 20px;
            height: 20px;
            background-color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .candidate-card.selected::before {
            content: '\f00c';
            position: absolute;
            top: 10px;
            right: 10px;
            color: white;
            font-family: 'Bootstrap Icons';
            font-size: 14px;
            z-index: 1;
        }
        
        .candidate-photo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #e0e0e0;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-color);
        }
        
        .candidate-name {
            text-align: center;
            font-weight: 500;
            margin-bottom: 0;
        }
        
        .candidate-radio {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .btn-vote {
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
            margin: 2rem auto 0;
        }
        
        .btn-vote:hover {
            background-color: var(--secondary-color);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            background-color: #4caf50;
            color: white;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transform: translateX(150%);
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        
        .notification.show {
            transform: translateX(0);
        }
        
        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
        
        @media (max-width: 768px) {
            .voting-container {
                padding: 1.5rem;
            }
            
            .candidates-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }
        
        @media (max-width: 480px) {
            .candidates-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="d-flex align-items-center">
                <i class="bi bi-ballot-fill me-3" style="font-size: 2rem;"></i>
                <h1 class="h3 mb-0">Sistema de Votación Electrónica</h1>
            </div>
        </div>
    </header>

    <!-- Notification -->
    <div id="notification" class="notification">
        <i class="bi bi-check-circle-fill me-2"></i>
        <span id="notification-text">Opción seleccionada</span>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="voting-container">
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
                        <p class="mb-2"><strong>Edad:</strong> <%= request.getParameter("edad") %> años</p>
                        <p class="mb-2"><strong>Región:</strong> <span class="badge bg-primary"><%= request.getParameter("region") %></span></p>
                    </div>
                </div>
            </div>

            <form action="confirmacionVoto.jsp" method="GET">
                <!-- Datos del votante -->
                <input type="hidden" name="dni" value="<%= request.getParameter("dni") %>">
                <input type="hidden" name="nombre" value="<%= request.getParameter("nombre") %>">
                <input type="hidden" name="apellido" value="<%= request.getParameter("apellido") %>">
                <input type="hidden" name="fechaNacimiento" value="<%= request.getParameter("fechaNacimiento") %>">
                <input type="hidden" name="edad" value="<%= request.getParameter("edad") %>">
                <input type="hidden" name="region" value="<%= request.getParameter("region") %>">

                <!-- Candidatos Presidenciales -->
                <div class="candidate-section">
                    <h4 class="section-title">
                        <i class="bi bi-building"></i>
                        Candidatos a la Presidencia
                    </h4>
                    <div class="candidates-grid">
                        <%
                            String[] presidentes = {
                                "Pedro Castillo", "Keiko Fujimori", "Yonhy Lescano", "Rafael López Aliaga", 
                                "Verónika Mendoza", "Daniel Urresti", "George Forsyth", "Hernando de Soto", 
                                "César Acuña", "Julio Guzmán", "Alfredo Barnechea", "Rosa Bartra", 
                                "Jorge Montoya", "Rómulo Mucho", "José Vega"
                            };
                            for(String p: presidentes){
                        %>
                        <div class="candidate-card">
                            <div class="candidate-photo">
                                <i class="bi bi-person-fill"></i>
                            </div>
                            <p class="candidate-name"><%=p%></p>
                            <input class="candidate-radio" type="radio" name="presidente" value="<%=p%>" required>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Candidatos a Congreso -->
                <div class="candidate-section">
                    <h4 class="section-title">
                        <i class="bi bi-people-fill"></i>
                        Candidatos a Congresistas
                    </h4>
                    <div class="candidates-grid">
                        <%
                            String[] congresistas = {"Juan Pérez", "Ana Gómez", "Luis Ramírez", "María Flores", "Carlos Rojas"};
                            for(String c: congresistas){
                        %>
                        <div class="candidate-card">
                            <div class="candidate-photo">
                                <i class="bi bi-person-fill"></i>
                            </div>
                            <p class="candidate-name"><%=c%></p>
                            <input class="candidate-radio" type="radio" name="congresista" value="<%=c%>" required>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Candidatos a Alcaldes -->
                <div class="candidate-section">
                    <h4 class="section-title">
                        <i class="bi bi-bank"></i>
                        Candidatos a Alcaldes
                    </h4>
                    <div class="candidates-grid">
                        <%
                            String[] alcaldes = {"Miguel Torres", "Lucía Sánchez", "Raúl Díaz", "Carla Paredes", "Eduardo Molina"};
                            for(String a: alcaldes){
                        %>
                        <div class="candidate-card">
                            <div class="candidate-photo">
                                <i class="bi bi-person-fill"></i>
                            </div>
                            <p class="candidate-name"><%=a%></p>
                            <input class="candidate-radio" type="radio" name="alcalde" value="<%=a%>" required>
                        </div>
                        <% } %>
                    </div>
                </div>

                <button type="submit" class="btn btn-vote">
                    <i class="bi bi-check-circle-fill"></i>
                    Votar
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle candidate selection
            const candidateCards = document.querySelectorAll('.candidate-card');
            
            candidateCards.forEach(card => {
                card.addEventListener('click', function() {
                    const radioInput = this.querySelector('input[type="radio"]');
                    const name = radioInput.name;
                    
                    // Remove selected class from all cards with the same name
                    document.querySelectorAll(`input[name="${name}"]`).forEach(input => {
                        input.closest('.candidate-card').classList.remove('selected');
                    });
                    
                    // Add selected class to this card
                    this.classList.add('selected');
                    radioInput.checked = true;
                    
                    // Show notification
                    showNotification(`Has seleccionado: ${radioInput.value}`);
                });
            });
            
            // Notification function
            function showNotification(message) {
                const notification = document.getElementById('notification');
                const notificationText = document.getElementById('notification-text');
                
                notificationText.textContent = message;
                notification.classList.add('show');
                
                setTimeout(() => {
                    notification.classList.remove('show');
                }, 3000);
            }
        });
    </script>
</body>
</html>