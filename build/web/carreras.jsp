<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Carreras - Instituto Cajas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/instituto-theme.css" rel="stylesheet">
</head>
<body>
    <div class="wrapper">
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
                <li class="active"><a href="${pageContext.request.contextPath}/carreras"><i class="bi bi-mortarboard"></i> Carreras</a></li>
                <li><a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
            </ul>
        </nav>

        <div id="content" class="content">
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-outline-primary"><i class="bi bi-list"></i></button>
                    <span class="navbar-brand ms-3 fw-bold text-primary">Gestión de Carreras</span>
                </div>
            </nav>

            <div class="container-fluid p-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white border-bottom">
                        <h5 class="mb-0 fw-bold text-dark">
                            <i class="bi ${carrera != null ? 'bi-pencil-square' : 'bi-mortarboard-fill'} text-primary me-2"></i>
                            ${carrera != null ? 'Editar Carrera' : 'Nueva Carrera'}
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/carreras" class="row g-3">
                            <input type="hidden" name="id" value="${carrera != null ? carrera.id : ''}">
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Código</label>
                                <input type="text" name="codigo" class="form-control" value="${carrera != null ? carrera.codigo : ''}" required placeholder="Ej: CONT">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Nombre</label>
                                <input type="text" name="nombre" class="form-control" value="${carrera != null ? carrera.nombre : ''}" required placeholder="Ej: Contabilidad">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Descripción</label>
                                <input type="text" name="descripcion" class="form-control" value="${carrera != null ? carrera.descripcion : ''}" placeholder="Breve descripción">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Duración (sem.)</label>
                                <input type="number" name="duracion_semestres" class="form-control" value="${carrera != null ? carrera.duracionSemestres : '6'}" required min="1" max="12">
                            </div>
                            <div class="col-12 text-end">
                                <a href="${pageContext.request.contextPath}/carreras" class="btn btn-outline-secondary me-2"><i class="bi bi-x-circle me-1"></i>Cancelar</a>
                                <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save me-2"></i>${carrera != null ? 'Actualizar' : 'Guardar'}</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-list-ul text-primary me-2"></i>Lista de Carreras</h5>
                        <span class="badge bg-primary">${carreras.size()} registros</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>Código</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Duración</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${carreras}">
                                        <tr>
                                            <td class="ps-4"><span class="badge bg-secondary">${c.id}</span></td>
                                            <td class="fw-semibold text-primary">${c.codigo}</td>
                                            <td class="fw-semibold">${c.nombre}</td>
                                            <td>${c.descripcion}</td>
                                            <td><span class="badge bg-info">${c.duracionSemestres} semestres</span></td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/carreras?action=edit&id=${c.id}" class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil"></i></a>
                                                <a href="${pageContext.request.contextPath}/carreras?action=delete&id=${c.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Eliminar ${c.nombre}?')"><i class="bi bi-trash"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/instituto-effects.js"></script>
</body>
</html>