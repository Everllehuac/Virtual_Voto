<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Votación - Inicio</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            max-width: 500px;
            width: 100%;
            text-align: center;
        }
        
        .logo {
            margin-bottom: 30px;
        }
        
        .logo h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .logo p {
            font-size: 1.1rem;
            opacity: 0.8;
        }
        
        .access-options {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 40px;
        }
        
        .access-card {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 25px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .access-card:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px);
        }
        
        .access-card h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        
        .access-card p {
            opacity: 0.8;
            margin-bottom: 15px;
        }
        
        .btn {
            display: inline-block;
            background-color: white;
            color: #1e3c72;
            padding: 10px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            border: 2px solid white;
        }
        
        .btn:hover {
            background-color: transparent;
            color: white;
        }
        
        .footer {
            margin-top: 40px;
            opacity: 0.7;
            font-size: 0.9rem;
        }
        
        @media (max-width: 600px) {
            .logo h1 {
                font-size: 2rem;
            }
            
            .access-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <h1>Sistema de Votación</h1>
            <p>Selecciona tu tipo de acceso</p>
        </div>
        
        <div class="access-options">
            <div class="access-card">
                <h3>Usuario</h3>
                <p>Accede para realizar tu voto en las elecciones</p>
                <a href="index.jsp" class="btn">Acceder como Usuario</a>
            </div>
            
            <div class="access-card">
                <h3>Administrador</h3>
                <p>Accede para gestionar el sistema y ver resultados</p>
                <a href="loginAdmin.jsp" class="btn">Acceder como Administrador</a>
            </div>
        </div>
        
        <div class="footer">
            Sistema Seguro de Votación Electrónica
        </div>
    </div>
</body>
</html>