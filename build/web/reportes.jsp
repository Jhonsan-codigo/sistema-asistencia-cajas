<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes | Instituto Cajas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/instituto-theme.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
<nav id="sidebar" class="sidebar">
    <div class="sidebar-header">
        <div class="sidebar-logo">
            <img src="${pageContext.request.contextPath}/images/logo.jpeg" alt="IESTP">
        </div>
        <div class="sidebar-brand">
            <h5>Instituto Cajas</h5>
            <small>Sistema de Asistencia</small>
        </div>
    </div>
            <ul class="list-unstyled components">
                <li><a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/asistencia"><i class="bi bi-calendar-check"></i> Tomar Asistencia</a></li>
                <li><a href="${pageContext.request.contextPath}/alumnos"><i class="bi bi-people"></i> Alumnos</a></li>
                <li><a href="${pageContext.request.contextPath}/docentes"><i class="bi bi-person-workspace"></i> Docentes</a></li>
                <li><a href="${pageContext.request.contextPath}/cursos"><i class="bi bi-book"></i> Cursos</a></li>
                <li><a href="${pageContext.request.contextPath}/carreras"><i class="bi bi-mortarboard"></i> Carreras</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
            </ul>
        </nav>

        <!-- Content -->
        <div id="content" class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-outline-secondary">
                        <i class="bi bi-list"></i>
                    </button>
                    <span class="navbar-brand ms-3 fw-bold text-primary">
                        <i class="bi bi-graph-up me-2"></i>Reportes y Estadísticas
                    </span>
                    <div class="ms-auto d-flex align-items-center">
                        <span class="text-muted me-3"><i class="bi bi-person-circle me-1"></i> Administrador</span>
                    </div>
                </div>
            </nav>

            <div class="container-fluid p-4">
                <!-- Tabs -->
                <ul class="nav nav-tabs mb-4" id="reportesTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="general-tab" data-bs-toggle="tab" data-bs-target="#general" type="button" role="tab">
                            <i class="bi bi-pie-chart me-1"></i> Resumen General
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="asistencia-tab" data-bs-toggle="tab" data-bs-target="#asistencia" type="button" role="tab">
                            <i class="bi bi-calendar-check me-1"></i> Por Asistencia
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="alumno-tab" data-bs-toggle="tab" data-bs-target="#alumno" type="button" role="tab">
                            <i class="bi bi-person me-1"></i> Por Alumno
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="reportesTabContent">
                    <!-- Tab: Resumen General -->
                    <div class="tab-pane fade show active" id="general" role="tabpanel">
                        <div class="row g-4 mb-4">
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 80px; height: 80px; background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-people-fill fs-2" style="color: var(--primary);"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalAlumnos != null ? totalAlumnos : '0'}</h3>
                                        <p class="text-muted mb-0">Alumnos Registrados</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 80px; height: 80px; background: linear-gradient(135deg, #d1fae5 0%, #bbf7d0 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-mortarboard-fill fs-2" style="color: var(--success);"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalCarreras != null ? totalCarreras : '0'}</h3>
                                        <p class="text-muted mb-0">Carreras Activas</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 80px; height: 80px; background: linear-gradient(135deg, #cffafe 0%, #a5f3fc 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-book-fill fs-2" style="color: var(--info);"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalCursos != null ? totalCursos : '0'}</h3>
                                        <p class="text-muted mb-0">Cursos Disponibles</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="card shadow-sm border-0">
                                    <div class="card-header bg-white">
                                        <h5 class="mb-0 fw-bold"><i class="bi bi-pie-chart me-2 text-primary"></i>Distribución por Carrera</h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="chartCarreras" height="250"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card shadow-sm border-0">
                                    <div class="card-header bg-white">
                                        <h5 class="mb-0 fw-bold"><i class="bi bi-bar-chart me-2 text-success"></i>Asistencia del Mes</h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="chartAsistencia" height="250"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tab: Por Asistencia -->
                    <div class="tab-pane fade" id="asistencia" role="tabpanel">
                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-funnel me-2 text-primary"></i>Filtrar Reporte de Asistencia</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/reportes" method="get" class="row g-3">
                                    <input type="hidden" name="action" value="asistencia">
                                    <div class="col-md-3">
                                        <label class="form-label fw-bold">Fecha Inicio</label>
                                        <input type="date" name="fecha_inicio" class="form-control" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label fw-bold">Fecha Fin</label>
                                        <input type="date" name="fecha_fin" class="form-control" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label fw-bold">Carrera</label>
                                        <select name="carrera_id" class="form-select" required>
                                            <option value="">Seleccionar</option>
                                            <c:forEach var="c" items="${carreras}">
                                                <option value="${c.id}">${c.nombre}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label fw-bold">Ciclo</label>
                                        <select name="ciclo" class="form-select" required>
                                            <option value="">Seleccionar</option>
                                            <option value="1">I Ciclo</option>
                                            <option value="2">II Ciclo</option>
                                            <option value="3">III Ciclo</option>
                                            <option value="4">IV Ciclo</option>
                                            <option value="5">V Ciclo</option>
                                            <option value="6">VI Ciclo</option>
                                        </select>
                                    </div>
                                    <div class="col-md-1 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <c:if test="${not empty alumnos}">
                            <div class="card shadow-sm border-0">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-check me-2 text-primary"></i>Resultados</h5>
                                    <span class="badge bg-primary">${alumnos.size()} alumnos</span>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>#</th>
                                                    <th>Código</th>
                                                    <th>Apellidos y Nombres</th>
                                                    <th class="text-center">Asistencia</th>
                                                    <th class="text-center">Tardanza</th>
                                                    <th class="text-center">Ausencia</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="a" items="${alumnos}" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.index + 1}</td>
                                                        <td><span class="badge bg-light text-dark">${a.codigo}</span></td>
                                                        <td>${a.apellidos}, ${a.nombres}</td>
                                                        <td class="text-center"><span class="badge bg-success">--</span></td>
                                                        <td class="text-center"><span class="badge bg-warning text-dark">--</span></td>
                                                        <td class="text-center"><span class="badge bg-danger">--</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Tab: Por Alumno -->
                    <div class="tab-pane fade" id="alumno" role="tabpanel">
                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-person me-2 text-primary"></i>Buscar Historial de Alumno</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/reportes" method="get" class="row g-3">
                                    <input type="hidden" name="action" value="alumno">
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Seleccionar Alumno</label>
                                        <select name="alumno_id" class="form-select" required>
                                            <option value="">Seleccionar alumno</option>
                                            <!-- Aquí deberías cargar la lista de alumnos -->
                                        </select>
                                    </div>
                                    <div class="col-md-2 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-search me-1"></i>Generar
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <c:if test="${not empty asistencias}">
                            <div class="card shadow-sm border-0">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0 fw-bold"><i class="bi bi-clock-history me-2 text-primary"></i>Historial de Asistencia</h5>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Fecha</th>
                                                    <th>Curso</th>
                                                    <th class="text-center">Estado</th>
                                                    <th>Observación</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="as" items="${asistencias}">
                                                    <tr>
                                                        <td>${as.fecha}</td>
                                                        <td>${as.nombreCurso}</td>
                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${as.estado == 'P'}">
                                                                    <span class="badge bg-success">Presente</span>
                                                                </c:when>
                                                                <c:when test="${as.estado == 'T'}">
                                                                    <span class="badge bg-warning text-dark">Tardanza</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger">Ausente</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${as.observacion != null ? as.observacion : '-'}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/instituto-effects.js"></script>
    <script>
        // Gráfico de distribución por carrera (ejemplo)
        const ctxCarreras = document.getElementById('chartCarreras').getContext('2d');
        new Chart(ctxCarreras, {
            type: 'doughnut',
            data: {
                labels: ['Contabilidad', 'Administración', 'Computación', 'Electrónica', 'Mecánica'],
                datasets: [{
                    data: [25, 20, 30, 15, 10],
                    backgroundColor: ['#0ea5e9', '#10b981', '#06b6d4', '#f59e0b', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Gráfico de asistencia del mes (ejemplo)
        const ctxAsistencia = document.getElementById('chartAsistencia').getContext('2d');
        new Chart(ctxAsistencia, {
            type: 'bar',
            data: {
                labels: ['Sem 1', 'Sem 2', 'Sem 3', 'Sem 4'],
                datasets: [{
                    label: 'Presentes',
                    data: [85, 90, 88, 92],
                    backgroundColor: '#10b981',
                    borderRadius: 6
                }, {
                    label: 'Ausentes',
                    data: [10, 5, 8, 4],
                    backgroundColor: '#ef4444',
                    borderRadius: 6
                }, {
                    label: 'Tardanzas',
                    data: [5, 5, 4, 4],
                    backgroundColor: '#f59e0b',
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true, max: 100 }
                },
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    </script>
</body>
</html>