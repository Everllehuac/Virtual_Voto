<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sistema de Votación</title>
    <style>
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
        
        .login-header h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }
        
        .login-header p {
            opacity: 0.8;
            font-size: 0.9rem;
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
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
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
            transition: background 0.3s;
        }
        
        .btn:hover {
            background: #2980b9;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e1e8ed;
        }
        
        .login-footer a {
            color: #3498db;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .login-footer a:hover {
            text-decoration: underline;
        }
        
        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .password-container {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #7f8c8d;
            cursor: pointer;
            width: auto;
            padding: 0;
        }
        
        @media (max-width: 480px) {
            .login-container {
                max-width: 100%;
            }
            
            .login-header, .login-body {
                padding: 20px;
            }
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
            <div id="error-message" class="alert alert-error">
                Usuario o contraseña incorrectos
            </div>
            
            <form id="admin-login-form">
                <div class="form-group">
                    <label for="username">Usuario</label>
                    <input type="text" id="username" class="form-control" placeholder="Ingresa tu usuario" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <div class="password-container">
                        <input type="password" id="password" class="form-control" placeholder="Ingresa tu contraseña" required>
                        <button type="button" class="toggle-password" id="toggle-password">??</button>
                    </div>
                </div>
                
                <button type="submit" class="btn">Iniciar Sesión</button>
            </form>
            
            <div class="login-footer">
                <a href="landingPage.jsp">? Volver al inicio</a>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('admin-login-form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.getElementById('error-message');
            
            // Credenciales de ejemplo (en producción esto se validaría en el servidor)
            if (username === 'admin' && password === 'admin123') {
                // Redirigir al panel de administración
                window.location.href = 'adminDashboard.jsp';
            } else {
                errorMessage.style.display = 'block';
                // Ocultar el mensaje después de 3 segundos
                setTimeout(() => {
                    errorMessage.style.display = 'none';
                }, 3000);
            }
        });
        
        // Funcionalidad para mostrar/ocultar contraseña
        document.getElementById('toggle-password').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.textContent = type === 'password' ? '??' : '?';
        });
        
        // Limpiar mensaje de error al empezar a escribir
        document.getElementById('username').addEventListener('input', function() {
            document.getElementById('error-message').style.display = 'none';
        });
        
        document.getElementById('password').addEventListener('input', function() {
            document.getElementById('error-message').style.display = 'none';
        });
    </script>
</body>
</html>