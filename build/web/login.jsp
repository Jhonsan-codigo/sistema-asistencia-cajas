<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String error = (String) request.getAttribute("error");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Asistencia | IESTP Cajas</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #0f172a 0%, #1e3a5f 50%, #0c4a6e 100%);
            position: relative;
            overflow: hidden;
        }
        
        .bg-particles {
            position: absolute;
            inset: 0;
            overflow: hidden;
            pointer-events: none;
        }
        
        .particle {
            position: absolute;
            border-radius: 50%;
            opacity: 0.08;
            animation: float 8s ease-in-out infinite;
        }
        
        .particle:nth-child(1) {
            width: 300px; height: 300px;
            background: rgba(59, 130, 246, 0.8);
            top: -100px; left: -100px;
            animation-duration: 10s;
        }
        
        .particle:nth-child(2) {
            width: 200px; height: 200px;
            background: rgba(220, 38, 38, 0.6);
            bottom: -50px; right: -50px;
            animation-duration: 12s;
            animation-direction: reverse;
        }
        
        .particle:nth-child(3) {
            width: 150px; height: 150px;
            background: rgba(234, 179, 8, 0.6);
            top: 40%; left: 60%;
            animation-duration: 15s;
            animation-delay: 2s;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -30px) scale(1.1); }
            66% { transform: translate(-20px, 20px) scale(0.9); }
        }
        
        .login-card {
            display: flex;
            width: 900px;
            max-width: 95vw;
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 10;
            animation: slideIn 0.8s ease-out;
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .left-side {
            flex: 1;
            background: linear-gradient(180deg, #0c4a6e 0%, #075985 50%, #0369a1 100%);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .left-side::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ccircle cx='50' cy='50' r='40' fill='none' stroke='rgba(255,255,255,0.05)' stroke-width='0.5'/%3E%3C/svg%3E");
            background-size: 200px;
            opacity: 0.3;
        }
        
        .logo-container {
            position: relative;
            margin-bottom: 24px;
        }
        
        .gear-ring {
            width: 140px;
            height: 140px;
            border: 3px dashed rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            position: absolute;
            top: -10px;
            left: -10px;
            animation: spin 20s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        .logo-circle {
            width: 120px;
            height: 120px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            position: relative;
            z-index: 2;
            overflow: hidden;
        }
        
        .logo-circle img {
            width: 100px;
            height: 100px;
            object-fit: contain;
        }
        
        .institute-name {
            color: white;
            font-size: 26px;
            font-weight: 700;
            margin: 0 0 8px 0;
            letter-spacing: 0.5px;
            position: relative;
            z-index: 2;
        }
        
        .institute-fullname {
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            font-weight: 600;
            margin: 0 0 4px 0;
            position: relative;
            z-index: 2;
        }
        
        .divider {
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, #dc2626, #eab308);
            border-radius: 2px;
            margin: 16px 0;
            position: relative;
            z-index: 2;
        }
        
        .institute-motto {
            color: rgba(255, 255, 255, 0.7);
            font-size: 13px;
            margin: 0;
            line-height: 1.6;
            position: relative;
            z-index: 2;
        }
        
        .campus-badge {
            margin-top: 30px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 10px 24px;
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            z-index: 2;
        }
        
        .campus-badge span {
            color: #eab308;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        
        .right-side {
            flex: 1;
            padding: 50px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #fafbfc;
        }
        
        .form-header {
            margin-bottom: 32px;
        }
        
        .form-header h1 {
            color: #0f172a;
            font-size: 28px;
            font-weight: 800;
            margin: 0 0 8px 0;
        }
        
        .form-header p {
            color: #64748b;
            font-size: 15px;
            margin: 0;
        }
        
        .error-message {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 14px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .form-group {
            position: relative;
            margin-bottom: 20px;
        }
        
        .input-wrapper {
            display: flex;
            align-items: center;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            background: white;
            transition: all 0.3s ease;
        }
        
        .input-wrapper:focus-within {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }
        
        .input-icon {
            padding: 0 12px 0 16px;
            color: #94a3b8;
            display: flex;
            align-items: center;
        }
        
        .input-field {
            flex: 1;
            border: none;
            outline: none;
            padding: 14px 16px 14px 0;
            font-size: 15px;
            color: #0f172a;
            background: transparent;
            width: 100%;
        }
        
        .input-field::placeholder {
            color: #94a3b8;
        }
        
        .toggle-password {
            background: none;
            border: none;
            padding: 0 16px 0 0;
            cursor: pointer;
            color: #94a3b8;
            display: flex;
            align-items: center;
        }
        
        .toggle-password:hover {
            color: #64748b;
        }
        
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            margin-bottom: 24px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: #475569;
        }
        
        .remember-me input {
            width: 16px;
            height: 16px;
            accent-color: #3b82f6;
            cursor: pointer;
        }
        
        .forgot-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }
        
        .forgot-link:hover {
            color: #2563eb;
            text-decoration: underline;
        }
        
        .btn-login {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            letter-spacing: 0.5px;
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }
        
        .form-footer {
            margin-top: 32px;
            text-align: center;
        }
        
        .form-footer p {
            color: #94a3b8;
            font-size: 12px;
            margin: 0;
        }
        
        .form-footer .system-name {
            color: #cbd5e1;
            font-size: 11px;
            margin-top: 4px;
        }
        
        .demo-credentials {
            background: #f0f9ff;
            border: 1px solid #bae6fd;
            border-radius: 8px;
            padding: 12px;
            margin-top: 16px;
            text-align: center;
        }
        
        .demo-credentials p {
            color: #0369a1;
            font-size: 12px;
            margin: 0;
        }
        
        .demo-credentials strong {
            color: #0c4a6e;
        }
        
        @media (max-width: 768px) {
            .login-card {
                flex-direction: column;
                width: 100%;
                max-width: 100%;
                border-radius: 0;
                min-height: 100vh;
            }
            
            .left-side {
                padding: 30px 20px;
                min-height: 280px;
            }
            
            .right-side {
                padding: 30px 24px;
            }
            
            .gear-ring {
                width: 100px;
                height: 100px;
                top: -5px;
                left: -5px;
            }
            
            .logo-circle {
                width: 90px;
                height: 90px;
            }
            
            .logo-circle img {
                width: 70px;
                height: 70px;
            }
            
            .institute-name {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="login-card">
        <div class="left-side">
            <div class="logo-container">
                <div class="gear-ring"></div>
                <div class="logo-circle">
                    <img src="<%= contextPath %>/images/logo.jpeg" alt="IESTP Logo">
                </div>
            </div>
            
            <h2 class="institute-name">IESTP</h2>
            <p class="institute-fullname">"ANDRÉS AVELINO CÁCERES DORREGARAY"</p>
            <div class="divider"></div>
            <p class="institute-motto">Formando técnicos líderes<br>para el desarrollo del país</p>
            
            <div class="campus-badge">
                <span>✦ CAJAS ✦</span>
            </div>
        </div>
        
        <div class="right-side">
            <div class="form-header">
                <h1>Bienvenido</h1>
                <p>Ingresa tus credenciales para acceder al sistema</p>
            </div>
            
            <div id="errorContainer">
                <% if (error != null) { %>
                <div class="error-message" id="errorMsg">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"/>
                        <line x1="12" y1="8" x2="12" y2="12"/>
                        <line x1="12" y1="16" x2="12.01" y2="16"/>
                    </svg>
                    <%= error %>
                </div>
                <% } %>
            </div>
            
            <form action="<%= contextPath %>/LoginServlet" method="POST" id="loginForm">
                
                <div class="form-group">
                    <div class="input-wrapper">
                        <div class="input-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                        </div>
                        <input type="text" name="usuario" id="usuario" class="input-field" placeholder="Usuario" required 
                               value="<%= request.getParameter("usuario") != null ? request.getParameter("usuario") : "" %>">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="input-wrapper">
                        <div class="input-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                        </div>
                        <input type="password" name="password" id="password" class="input-field" placeholder="Contraseña" required>
                        <button type="button" class="toggle-password" onclick="togglePassword()">
                            <svg id="eyeIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                </div>
                
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember" id="remember">
                        <span>Recordarme</span>
                    </label>
                    <a href="#" class="forgot-link">¿Olvidaste tu contraseña?</a>
                </div>
                
                <button type="submit" class="btn-login">
                    Iniciar Sesión
                </button>
                
            </form>
            
            <div class="demo-credentials">
                <p><strong>Usuario:</strong> admin | <strong>Contraseña:</strong> admin123</p>
            </div>
            
            <div class="form-footer">
                <p>Sistema de Asistencia y Control Académico</p>
                <p class="system-name">© 2026 IESTP Cajas - Todos los derechos reservados</p>
            </div>
        </div>
    </div>

    <script>
        // Ocultar error después de 5 segundos
        window.addEventListener('load', function() {
            const errorMsg = document.getElementById('errorMsg');
            if (errorMsg) {
                setTimeout(function() {
                    errorMsg.style.transition = 'opacity 0.5s ease';
                    errorMsg.style.opacity = '0';
                    setTimeout(function() {
                        errorMsg.remove();
                    }, 500);
                }, 5000);
            }
            
            // Restaurar usuario recordado
            const rememberedUser = localStorage.getItem('rememberedUser');
            if (rememberedUser) {
                document.getElementById('usuario').value = rememberedUser;
                document.getElementById('remember').checked = true;
            }
        });
        
        // Guardar usuario en localStorage
        document.getElementById('loginForm').addEventListener('submit', function() {
            const remember = document.getElementById('remember').checked;
            const usuario = document.getElementById('usuario').value;
            if (remember) {
                localStorage.setItem('rememberedUser', usuario);
            } else {
                localStorage.removeItem('rememberedUser');
            }
        });
        
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.innerHTML = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';
            } else {
                passwordInput.type = 'password';
                eyeIcon.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
            }
        }
    </script>
</body>
</html>