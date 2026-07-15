<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Verificar sesión
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String nombreUsuario = (String) session.getAttribute("nombreCompleto");
    if (nombreUsuario == null) nombreUsuario = (String) session.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Instituto Cajas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary: #0c4a6e;
            --primary-light: #075985;
            --accent: #eab308;
            --danger: #dc2626;
            --success: #10b981;
            --sidebar-width: 260px;
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: #f1f5f9;
            overflow-x: hidden;
        }
        
        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: linear-gradient(180deg, #0f172a 0%, #0c4a6e 100%);
            color: white;
            z-index: 1000;
            transition: all 0.3s;
            box-shadow: 4px 0 20px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 24px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .sidebar-logo {
            width: 45px;
            height: 45px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .sidebar-logo img {
            width: 35px;
            height: 35px;
            object-fit: contain;
        }
        
        .sidebar-brand h5 {
            font-size: 16px;
            font-weight: 700;
            margin: 0;
            color: white;
        }
        
        .sidebar-brand small {
            font-size: 11px;
            color: rgba(255,255,255,0.6);
            letter-spacing: 0.5px;
        }
        
        .sidebar-menu {
            padding: 16px 0;
            list-style: none;
        }
        
        .sidebar-menu li {
            margin: 4px 12px;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s;
            font-size: 14px;
            font-weight: 500;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(4px);
        }
        
        .sidebar-menu a.active {
            background: linear-gradient(135deg, rgba(59,130,246,0.3) 0%, rgba(59,130,246,0.1) 100%);
            border-left: 3px solid #3b82f6;
        }
        
        .sidebar-menu i {
            font-size: 18px;
            width: 24px;
            text-align: center;
        }
        
        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            transition: all 0.3s;
        }
        
        /* Top Navbar */
        .top-navbar {
            background: white;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .navbar-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .menu-toggle {
            background: none;
            border: none;
            font-size: 24px;
            color: #64748b;
            cursor: pointer;
            display: none;
        }
        
        .page-title {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 16px;
            background: #f8fafc;
            border-radius: 50px;
            border: 1px solid #e2e8f0;
        }
        
        .user-avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #0c4a6e, #3b82f6);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 14px;
        }
        
        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: #334155;
        }
        
        .user-role {
            font-size: 11px;
            color: #94a3b8;
        }
        
        .btn-logout {
            background: linear-gradient(135deg, #dc2626, #ef4444);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s;
        }
        
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220,38,38,0.3);
        }
        
        /* Content Area */
        .content-area {
            padding: 24px;
        }
        
        /* Stats Cards */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transition: all 0.3s;
            border-left: 4px solid;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
        }
        
        .stat-card:nth-child(1) { border-color: #3b82f6; }
        .stat-card:nth-child(2) { border-color: #10b981; }
        .stat-card:nth-child(3) { border-color: #06b6d4; }
        .stat-card:nth-child(4) { border-color: #f59e0b; }
        
        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        
        .stat-card:nth-child(1) .stat-icon { background: #eff6ff; color: #3b82f6; }
        .stat-card:nth-child(2) .stat-icon { background: #ecfdf5; color: #10b981; }
        .stat-card:nth-child(3) .stat-icon { background: #ecfeff; color: #06b6d4; }
        .stat-card:nth-child(4) .stat-icon { background: #fffbeb; color: #f59e0b; }
        
        .stat-info h3 {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            margin: 0;
        }
        
        .stat-info p {
            font-size: 13px;
            color: #64748b;
            margin: 4px 0 0 0;
            font-weight: 500;
        }
        
        /* Quick Access */
        .section-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        
        .section-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .section-header h4 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
        }
        
        .section-header i {
            font-size: 20px;
            color: #f59e0b;
        }
        
        .quick-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        
        .quick-card {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 14px;
            padding: 24px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .quick-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
            border-color: #e2e8f0;
        }
        
        .quick-card:nth-child(1):hover { background: linear-gradient(135deg, #fef3c7, #fde68a); }
        .quick-card:nth-child(2):hover { background: linear-gradient(135deg, #dbeafe, #bfdbfe); }
        .quick-card:nth-child(3):hover { background: linear-gradient(135deg, #e0f2fe, #bae6fd); }
        .quick-card:nth-child(4):hover { background: linear-gradient(135deg, #d1fae5, #a7f3d0); }
        
        .quick-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 16px;
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .quick-card:nth-child(1) .quick-icon { color: #f59e0b; }
        .quick-card:nth-child(2) .quick-icon { color: #3b82f6; }
        .quick-card:nth-child(3) .quick-icon { color: #06b6d4; }
        .quick-card:nth-child(4) .quick-icon { color: #10b981; }
        
        .quick-card h6 {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px 0;
        }
        
        .quick-card p {
            font-size: 12px;
            color: #64748b;
            margin: 0;
        }
        
        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #0c4a6e 0%, #075985 50%, #0369a1 100%);
            border-radius: 16px;
            padding: 24px;
            color: white;
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }
        
        .welcome-banner h5 {
            font-size: 18px;
            font-weight: 700;
            margin: 0 0 8px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .welcome-banner p {
            font-size: 14px;
            color: rgba(255,255,255,0.8);
            margin: 0;
        }
        
        .welcome-banner strong {
            color: #eab308;
        }
        
        /* Carreras List */
        .carreras-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .carreras-list li {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #f8fafc;
            transition: all 0.3s;
        }
        
        .carreras-list li:hover {
            background: #e0f2fe;
            transform: translateX(4px);
        }
        
        .carreras-list li::before {
            content: '';
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #3b82f6;
        }
        
        /* Responsive */
        @media (max-width: 1200px) {
            .stats-row, .quick-grid { grid-template-columns: repeat(2, 1fr); }
        }
        
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0; }
            .menu-toggle { display: block; }
            .stats-row, .quick-grid { grid-template-columns: 1fr; }
            .user-info { display: none; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <img src="${pageContext.request.contextPath}/images/logo.jpeg" alt="IESTP">
            </div>
            <div class="sidebar-brand">
                <h5>Instituto Cajas</h5>
                <small>Sistema de Asistencia</small>
            </div>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/asistencia"><i class="bi bi-calendar-check"></i> Tomar Asistencia</a></li>
            <li><a href="${pageContext.request.contextPath}/alumnos"><i class="bi bi-people"></i> Alumnos</a></li>
            <li><a href="${pageContext.request.contextPath}/docentes"><i class="bi bi-person-workspace"></i> Docentes</a></li>
            <li><a href="${pageContext.request.contextPath}/cursos"><i class="bi bi-book"></i> Cursos</a></li>
            <li><a href="${pageContext.request.contextPath}/carreras"><i class="bi bi-mortarboard"></i> Carreras</a></li>
            <li><a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div class="navbar-left">
                <button class="menu-toggle" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
                <div class="page-title">
                    <i class="bi bi-speedometer2 text-primary"></i>
                    Panel de Control
                </div>
            </div>
            <div class="navbar-right">
                <div class="user-info">
                    <div class="user-avatar">
                        <%= nombreUsuario.substring(0, 1).toUpperCase() %>
                    </div>
                    <div>
                        <div class="user-name"><%= nombreUsuario %></div>
                        <div class="user-role">Administrador</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                </a>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Stats Cards -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div class="stat-info">
                        <h3>1400</h3>
                        <p>Total Alumnos</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-mortarboard-fill"></i></div>
                    <div class="stat-info">
                        <h3>${totalCarreras}</h3>
                        <p>Carreras</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-book-fill"></i></div>
                    <div class="stat-info">
                        <h3> 293</h3>
                        <p>Cursos</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-person-workspace"></i></div>
                    <div class="stat-info">
                        <h3>80</h3>
                        <p>Docentes</p>
                    </div>
                </div>
            </div>

            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h5><i class="bi bi-info-circle"></i> Bienvenido al Sistema de Asistencia</h5>
                <p>Este sistema permite gestionar la asistencia de los alumnos del <strong>Instituto Cajas</strong>.</p>
            </div>

            <!-- Quick Access -->
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-lightning-charge"></i>
                    <h4>Accesos Rápidos</h4>
                </div>
                <div class="quick-grid">
                    <a href="${pageContext.request.contextPath}/asistencia" class="quick-card">
                        <div class="quick-icon"><i class="bi bi-calendar-check"></i></div>
                        <h6>Tomar Asistencia</h6>
                        <p>Registrar asistencia diaria</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/alumnos" class="quick-card">
                        <div class="quick-icon"><i class="bi bi-people"></i></div>
                        <h6>Gestión Alumnos</h6>
                        <p>Administrar estudiantes</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/docentes" class="quick-card">
                        <div class="quick-icon"><i class="bi bi-person-workspace"></i></div>
                        <h6>Gestión Docentes</h6>
                        <p>Administrar profesores</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/reportes" class="quick-card">
                        <div class="quick-icon"><i class="bi bi-graph-up"></i></div>
                        <h6>Reportes</h6>
                        <p>Ver estadísticas</p>
                    </a>
                </div>
            </div>

            <!-- Carreras -->
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-mortarboard text-primary"></i>
                    <h4>Carreras disponibles</h4>
                </div>
                <ul class="carreras-list">
                    <c:forEach var="c" items="${carreras}">
                        <li>${c.nombre}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
        }
    </script>
</body>
</html>