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
                        <button class="nav-link ${param.action == null || param.action == 'general' ? 'active' : ''}" id="general-tab" data-bs-toggle="tab" data-bs-target="#general" type="button" role="tab">
                            <i class="bi bi-pie-chart me-1"></i> Resumen General
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link ${param.action == 'asistencia' ? 'active' : ''}" id="asistencia-tab" data-bs-toggle="tab" data-bs-target="#asistencia" type="button" role="tab">
                            <i class="bi bi-calendar-check me-1"></i> Por Asistencia
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link ${param.action == 'alumno' ? 'active' : ''}" id="alumno-tab" data-bs-toggle="tab" data-bs-target="#alumno" type="button" role="tab">
                            <i class="bi bi-person me-1"></i> Por Alumno
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="reportesTabContent">
                    <!-- ========================================== -->
                    <!-- TAB: RESUMEN GENERAL -->
                    <!-- ========================================== -->
                    <div class="tab-pane fade ${param.action == null || param.action == 'general' ? 'show active' : ''}" id="general" role="tabpanel">
                        <div class="row g-4 mb-4">
                            <div class="col-md-3">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 70px; height: 70px; background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-people-fill fs-2 text-primary"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalAlumnos != null ? totalAlumnos : '0'}</h3>
                                        <p class="text-muted mb-0">Alumnos</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 70px; height: 70px; background: linear-gradient(135deg, #d1fae5 0%, #bbf7d0 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-mortarboard-fill fs-2 text-success"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalCarreras != null ? totalCarreras : '0'}</h3>
                                        <p class="text-muted mb-0">Carreras</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 70px; height: 70px; background: linear-gradient(135deg, #cffafe 0%, #a5f3fc 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-book-fill fs-2 text-info"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalCursos != null ? totalCursos : '0'}</h3>
                                        <p class="text-muted mb-0">Cursos</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center p-4">
                                        <div class="mb-3" style="width: 70px; height: 70px; background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="bi bi-person-workspace fs-2 text-warning"></i>
                                        </div>
                                        <h3 class="fw-bold mb-1">${totalDocentes != null ? totalDocentes : '0'}</h3>
                                        <p class="text-muted mb-0">Docentes</p>
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

                    <!-- ========================================== -->
                    <!-- TAB: POR ASISTENCIA (DISEÑO SIMPLIFICADO) -->
                    <!-- ========================================== -->
                    <div class="tab-pane fade ${param.action == 'asistencia' ? 'show active' : ''}" id="asistencia" role="tabpanel">

                        <!-- Filtros simplificados en una sola fila -->
                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-funnel me-2 text-primary"></i>Filtrar Reporte</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/reportes" method="get" class="row g-3 align-items-end">
                                    <input type="hidden" name="action" value="asistencia">

                                    <div class="col-md-3">
                                        <label class="form-label fw-bold small text-muted">PERÍODO</label>
                                        <select name="periodo" class="form-select" onchange="this.form.submit()">
                                            <option value="hoy" ${periodo == 'hoy' ? 'selected' : ''}>Hoy</option>
                                            <option value="semana" ${periodo == 'semana' ? 'selected' : ''}>Esta semana</option>
                                            <option value="mes" ${periodo == 'mes' ? 'selected' : ''}>Este mes</option>
                                            <option value="todo" ${periodo == 'todo' || periodo == null ? 'selected' : ''}>Todo el tiempo</option>
                                            <option value="personalizado" ${periodo == 'personalizado' ? 'selected' : ''}>Personalizado...</option>
                                        </select>
                                    </div>

                                    <!-- Fechas personalizadas (solo si se selecciona) -->
                                    <c:if test="${periodo == 'personalizado'}">
                                        <div class="col-md-2">
                                            <label class="form-label fw-bold small text-muted">DESDE</label>
                                            <input type="date" name="fecha_inicio" class="form-control" value="${fechaInicio}">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label fw-bold small text-muted">HASTA</label>
                                            <input type="date" name="fecha_fin" class="form-control" value="${fechaFin}">
                                        </div>
                                    </c:if>

                                    <div class="col-md-3">
                                        <label class="form-label fw-bold small text-muted">CARRERA</label>
                                        <select name="carrera_id" class="form-select">
                                            <option value="">Todas</option>
                                            <c:forEach var="c" items="${carreras}">
                                                <option value="${c.id}" ${carreraId == c.id ? 'selected' : ''}>${c.nombre}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label fw-bold small text-muted">CICLO</label>
                                        <select name="ciclo" class="form-select">
                                            <option value="">Todos</option>
                                            <option value="1" ${cicloSeleccionado == '1' ? 'selected' : ''}>I</option>
                                            <option value="2" ${cicloSeleccionado == '2' ? 'selected' : ''}>II</option>
                                            <option value="3" ${cicloSeleccionado == '3' ? 'selected' : ''}>III</option>
                                            <option value="4" ${cicloSeleccionado == '4' ? 'selected' : ''}>IV</option>
                                            <option value="5" ${cicloSeleccionado == '5' ? 'selected' : ''}>V</option>
                                            <option value="6" ${cicloSeleccionado == '6' ? 'selected' : ''}>VI</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="bi bi-search me-1"></i> Buscar
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Resultados -->
                        <c:if test="${not empty alumnosReporte}">
                            <!-- Resumen rápido -->
                            <div class="row g-3 mb-4">
                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-success bg-success bg-opacity-10">
                                        <div class="card-body py-3">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="fw-bold text-success mb-0">${totalPresentes != null ? totalPresentes : 0}</h3>
                                                    <small class="text-muted">Presentes</small>
                                                </div>
                                                <i class="bi bi-check-circle-fill fs-1 text-success opacity-50"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-warning bg-warning bg-opacity-10">
                                        <div class="card-body py-3">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="fw-bold text-warning mb-0">${totalTardanzas != null ? totalTardanzas : 0}</h3>
                                                    <small class="text-muted">Tardanzas</small>
                                                </div>
                                                <i class="bi bi-clock-fill fs-1 text-warning opacity-50"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-danger bg-danger bg-opacity-10">
                                        <div class="card-body py-3">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="fw-bold text-danger mb-0">${totalAusentes != null ? totalAusentes : 0}</h3>
                                                    <small class="text-muted">Ausentes</small>
                                                </div>
                                                <i class="bi bi-x-circle-fill fs-1 text-danger opacity-50"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-primary bg-primary bg-opacity-10">
                                        <div class="card-body py-3">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="fw-bold text-primary mb-0">${alumnosReporte.size()}</h3>
                                                    <small class="text-muted">Alumnos</small>
                                                </div>
                                                <i class="bi bi-people-fill fs-1 text-primary opacity-50"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tabla compacta -->
                            <div class="card shadow-sm border-0">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-check me-2 text-primary"></i>Reporte de Asistencia</h5>
                                    <div>
                                        <span class="badge bg-primary me-2">${alumnosReporte.size()} alumnos</span>
                                        <button class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                                            <i class="bi bi-printer me-1"></i>Imprimir
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0 align-middle">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th class="text-center" style="width: 50px;">#</th>
                                                    <th style="width: 100px;">DNI</th>
                                                    <th>Apellidos y Nombres</th>
                                                    <th class="text-center" style="width: 60px;"><span class="text-success">P</span></th>
                                                    <th class="text-center" style="width: 60px;"><span class="text-warning">T</span></th>
                                                    <th class="text-center" style="width: 60px;"><span class="text-danger">A</span></th>
                                                    <th class="text-center" style="width: 70px;">Total</th>
                                                    <th style="width: 200px;">% Asistencia</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="a" items="${alumnosReporte}" varStatus="loop">
                                                    <c:set var="conteo" value="${conteoAsistencias[a.id]}" />
                                                    <tr>
                                                        <td class="text-center text-muted">${loop.index + 1}</td>
                                                        <td><code class="small">${a.dni}</code></td>
                                                        <td class="fw-semibold">${a.apellidos}, ${a.nombres}</td>
                                                        <td class="text-center"><span class="badge bg-success bg-opacity-25 text-success">${conteo.P != null ? conteo.P : 0}</span></td>
                                                        <td class="text-center"><span class="badge bg-warning bg-opacity-25 text-warning">${conteo.T != null ? conteo.T : 0}</span></td>
                                                        <td class="text-center"><span class="badge bg-danger bg-opacity-25 text-danger">${conteo.A != null ? conteo.A : 0}</span></td>
                                                        <td class="text-center fw-bold">${conteo.total != null ? conteo.total : 0}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${conteo.total > 0}">
                                                                    <c:set var="porcentaje" value="${(conteo.P + conteo.T) * 100 / conteo.total}" />
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="progress flex-grow-1 me-2" style="height: 10px;">
                                                                            <div class="progress-bar ${porcentaje >= 80 ? 'bg-success' : porcentaje >= 60 ? 'bg-warning' : 'bg-danger'}" 
                                                                                 role="progressbar" 
                                                                                 style="width: ${porcentaje}%"></div>
                                                                        </div>
                                                                        <small class="fw-bold ${porcentaje >= 80 ? 'text-success' : porcentaje >= 60 ? 'text-warning' : 'text-danger'}" style="width: 45px;">${porcentaje}%</small>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted small">Sin registros</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${param.action == 'asistencia' && empty alumnosReporte}">
                            <div class="alert alert-info d-flex align-items-center">
                                <i class="bi bi-info-circle-fill me-3 fs-4"></i>
                                <div>
                                    <strong>No se encontraron registros</strong><br>
                                    <span class="small">Selecciona otro período o verifica que existan alumnos en la carrera y ciclo seleccionados.</span>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- ========================================== -->
                    <!-- TAB: POR ALUMNO -->
                    <!-- ========================================== -->
                    <div class="tab-pane fade ${param.action == 'alumno' ? 'show active' : ''}" id="alumno" role="tabpanel">
                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-person me-2 text-primary"></i>Buscar Historial de Alumno</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/reportes" method="get" class="row g-3 align-items-end">
                                    <input type="hidden" name="action" value="alumno">
                                    <div class="col-md-5">
                                        <label class="form-label fw-bold small text-muted">ALUMNO</label>
                                        <select name="alumno_id" class="form-select" required>
                                            <option value="">Seleccionar alumno...</option>
                                            <c:forEach var="a" items="${listaAlumnos}">
                                                <option value="${a.id}" ${alumnoId == a.id ? 'selected' : ''}>${a.apellidos}, ${a.nombres} — ${a.dni}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="bi bi-search me-1"></i> Ver
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <c:if test="${not empty alumnoSeleccionado}">
                            <div class="card shadow-sm border-0 mb-4" style="background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-6">
                                            <h4 class="fw-bold mb-1">${alumnoSeleccionado.apellidos}, ${alumnoSeleccionado.nombres}</h4>
                                            <p class="text-muted mb-0">
                                                <i class="bi bi-credit-card me-1"></i>${alumnoSeleccionado.dni}
                                                <span class="mx-2">|</span>
                                                <i class="bi bi-mortarboard me-1"></i>${alumnoSeleccionado.nombreCarrera}
                                                <span class="mx-2">|</span>
                                                <i class="bi bi-layers me-1"></i>${alumnoSeleccionado.ciclo}° Ciclo
                                            </p>
                                        </div>
                                        <div class="col-md-6 text-md-end">
                                            <span class="badge bg-success fs-6 me-2">P: ${resumenAlumno.P != null ? resumenAlumno.P : 0}</span>
                                            <span class="badge bg-warning text-dark fs-6 me-2">T: ${resumenAlumno.T != null ? resumenAlumno.T : 0}</span>
                                            <span class="badge bg-danger fs-6 me-2">A: ${resumenAlumno.A != null ? resumenAlumno.A : 0}</span>
                                            <span class="badge bg-primary fs-6">Total: ${resumenAlumno.total != null ? resumenAlumno.total : 0}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty asistencias}">
                            <div class="card shadow-sm border-0">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0 fw-bold"><i class="bi bi-clock-history me-2 text-primary"></i>Historial de Asistencia</h5>
                                    <span class="badge bg-primary">${asistencias.size()} registros</span>
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
                                                        <td class="fw-semibold">${as.fecha}</td>
                                                        <td>${as.nombreCurso}</td>
                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${as.estado == 'P'}">
                                                                    <span class="badge bg-success"><i class="bi bi-check me-1"></i>Presente</span>
                                                                </c:when>
                                                                <c:when test="${as.estado == 'T'}">
                                                                    <span class="badge bg-warning text-dark"><i class="bi bi-clock me-1"></i>Tardanza</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger"><i class="bi bi-x me-1"></i>Ausente</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-muted">${as.observacion != null ? as.observacion : '-'}</td>
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
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });

        const ctxAsistencia = document.getElementById('chartAsistencia').getContext('2d');
        new Chart(ctxAsistencia, {
            type: 'bar',
            data: {
                labels: ['Sem 1', 'Sem 2', 'Sem 3', 'Sem 4'],
                datasets: [
                    { label: 'Presentes', data: [85, 90, 88, 92], backgroundColor: '#10b981', borderRadius: 6 },
                    { label: 'Ausentes', data: [10, 5, 8, 4], backgroundColor: '#ef4444', borderRadius: 6 },
                    { label: 'Tardanzas', data: [5, 5, 4, 4], backgroundColor: '#f59e0b', borderRadius: 6 }
                ]
            },
            options: { responsive: true, scales: { y: { beginAtZero: true, max: 100 } }, plugins: { legend: { position: 'bottom' } } }
        });
    </script>
</body>
</html>