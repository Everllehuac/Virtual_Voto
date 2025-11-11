<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sistema de Votación</title>
    <style>
        /* Tus estilos del login aquí */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1a2a6c, #2a5298);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 450px;
            overflow: hidden;
        }
        
        .login-header {
            background: #2c3e50;
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .login-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 16px;
        }
        
        .btn {
            width: 100%;
            padding: 14px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        
        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            background: #f8d7da;
            border-radius: 5px;
            display: <%= request.getAttribute("error") != null ? "block" : "none" %>;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Panel de Administración</h1>
            <p>Sistema de Votación Electrónica</p>
        </div>
        
        <div class="login-body">
            <!-- Mostrar mensaje de error si viene del Servlet -->
            <div class="error-message">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </div>
            
            <!-- Enviar al LoginServlet -->
            <form action="LoginServlet" method="POST">
                <input type="hidden" name="tipo" value="admin">
                
                <div class="form-group">
                    <label for="username">Usuario</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Ingresa tu usuario" required value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Ingresa tu contraseña" required>
                </div>
                
                <button type="submit" class="btn">Iniciar Sesión</button>
            </form>
            
            <div style="text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #e1e8ed;">
                <a href="index.jsp" style="color: #3498db; text-decoration: none;">← Volver al inicio</a>
            </div>
        </div>
    </div>
</body>
</html>