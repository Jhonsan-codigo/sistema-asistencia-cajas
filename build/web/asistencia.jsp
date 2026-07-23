<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tomar Asistencia | Instituto Cajas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/instituto-theme.css">
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
                <li><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/asistencia"><i class="fas fa-calendar-check"></i> Tomar Asistencia</a></li>
                <li><a href="${pageContext.request.contextPath}/alumnos"><i class="fas fa-users"></i> Alumnos</a></li>
                <li><a href="${pageContext.request.contextPath}/docentes"><i class="fas fa-chalkboard-user"></i> Docentes</a></li>
                <li><a href="${pageContext.request.contextPath}/cursos"><i class="fas fa-book-open"></i> Cursos</a></li>
                <li><a href="${pageContext.request.contextPath}/carreras"><i class="fas fa-graduation-cap"></i> Carreras</a></li>
                <li><a href="${pageContext.request.contextPath}/reportes"><i class="fas fa-chart-bar"></i> Reportes</a></li>
            </ul>
        </nav>

        <!-- Content -->
        <div id="content" class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-outline-secondary">
                        <i class="fas fa-bars"></i>
                    </button>
                    <span class="navbar-brand ms-3 fw-bold text-primary">
                        <i class="fas fa-calendar-check me-2"></i>Tomar Asistencia
                    </span>
                    <div class="ms-auto d-flex align-items-center">
                        <span class="text-muted me-3"><i class="fas fa-user-circle me-1"></i> Administrador</span>
                    </div>
                </div>
            </nav>

            <div class="container-fluid p-4">
                <!-- Mensajes -->
                <c:if test="${not empty mensajeExito}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${mensajeExito}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty mensajeError}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${mensajeError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Seleccionar Curso y Fecha -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="fas fa-filter me-2 text-primary"></i>Seleccionar Curso y Fecha</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/asistencia" method="get" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Fecha</label>
                                <input type="date" name="fecha" class="form-control" value="${fechaSeleccionada != null ? fechaSeleccionada : hoy}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Carrera</label>
                                <select name="carrera_id" class="form-select" required>
                                    <option value="">Seleccionar carrera</option>
                                    <c:forEach var="c" items="${carreras}">
                                        <option value="${c.id}" ${carreraSeleccionada == c.id ? 'selected' : ''}>${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-bold">Ciclo</label>
                                <select name="ciclo" class="form-select" required>
                                    <option value="">Seleccionar</option>
                                    <option value="1" ${cicloSeleccionado == '1' ? 'selected' : ''}>I Ciclo</option>
                                    <option value="2" ${cicloSeleccionado == '2' ? 'selected' : ''}>II Ciclo</option>
                                    <option value="3" ${cicloSeleccionado == '3' ? 'selected' : ''}>III Ciclo</option>
                                    <option value="4" ${cicloSeleccionado == '4' ? 'selected' : ''}>IV Ciclo</option>
                                    <option value="5" ${cicloSeleccionado == '5' ? 'selected' : ''}>V Ciclo</option>
                                    <option value="6" ${cicloSeleccionado == '6' ? 'selected' : ''}>VI Ciclo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Curso</label>
                                <select name="curso_id" class="form-select" required>
                                    <option value="">Seleccionar curso</option>
                                    <c:forEach var="c" items="${cursos}">
                                        <option value="${c.id}" ${cursoSeleccionado == c.id ? 'selected' : ''}>${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-1 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Lista de Alumnos -->
                <div class="card shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>Lista de Alumnos</h5>
                        <span class="badge bg-primary">${alumnos != null ? alumnos.size() : 0} alumnos</span>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty alumnos}">
                                <form action="${pageContext.request.contextPath}/asistencia" method="post">
                                    <input type="hidden" name="action" value="guardar">
                                    <input type="hidden" name="fecha" value="${fechaSeleccionada != null ? fechaSeleccionada : hoy}">
                                    <input type="hidden" name="curso_id" value="${cursoSeleccionado}">
                                    <input type="hidden" name="docente_id" value="1">
                                    <input type="hidden" name="carrera_id" value="${carreraSeleccionada}">
                                    <input type="hidden" name="ciclo" value="${cicloSeleccionado}">
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th class="text-center" style="width: 60px;">#</th>
                                                    <th style="width: 120px;">DNI</th>
                                                    <th>Apellidos y Nombres</th>
                                                    <th class="text-center" style="width: 220px;">Estado</th>
                                                    <th style="width: 250px;">Observación</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="a" items="${alumnos}" varStatus="loop">
                                                    <tr>
                                                        <!-- ✅ CORRECCIÓN: input hidden DENTRO del <td> -->
                                                        <td class="text-center">
                                                            <input type="hidden" name="alumno_id" value="${a.id}">
                                                            ${loop.index + 1}
                                                        </td>
                                                        <td><strong>${a.dni}</strong></td>
                                                        <td>${a.apellidos}, ${a.nombres}</td>
                                                        <td class="text-center">
                                                            <div class="btn-group" role="group">
                                                                <input type="radio" class="btn-check" name="estado_${a.id}" id="presente_${a.id}" value="P" checked>
                                                                <label class="btn btn-outline-success btn-sm" for="presente_${a.id}">
                                                                    <i class="fas fa-check"></i> P
                                                                </label>
                                                                <input type="radio" class="btn-check" name="estado_${a.id}" id="tardanza_${a.id}" value="T">
                                                                <label class="btn btn-outline-warning btn-sm" for="tardanza_${a.id}">
                                                                    <i class="fas fa-clock"></i> T
                                                                </label>
                                                                <input type="radio" class="btn-check" name="estado_${a.id}" id="ausente_${a.id}" value="A">
                                                                <label class="btn btn-outline-danger btn-sm" for="ausente_${a.id}">
                                                                    <i class="fas fa-times"></i> A
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="observacion_${a.id}" class="form-control form-control-sm" placeholder="Opcional">
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="p-3 bg-light border-top d-flex justify-content-between align-items-center">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-2"></i>Guardar Asistencia
                                        </button>
                                        <a href="${pageContext.request.contextPath}/reportes?action=asistencia&periodo=hoy&carrera_id=${carreraSeleccionada}&ciclo=${cicloSeleccionado}" class="btn btn-primary">
                                            <i class="fas fa-chart-bar me-2"></i>Ver Reporte
                                        </a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                    <h5 class="text-muted">No se encontraron alumnos para el curso y fecha seleccionados</h5>
                                    <p class="text-muted">Selecciona una carrera, ciclo y curso para ver los alumnos.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/instituto-effects.js"></script>
</body>
</html>