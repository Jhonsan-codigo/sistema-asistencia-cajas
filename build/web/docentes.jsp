<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Docentes - Instituto Cajas</title>
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
                <li class="active"><a href="${pageContext.request.contextPath}/docentes"><i class="bi bi-person-workspace"></i> Docentes</a></li>
                <li><a href="${pageContext.request.contextPath}/cursos"><i class="bi bi-book"></i> Cursos</a></li>
                <li><a href="${pageContext.request.contextPath}/carreras"><i class="bi bi-mortarboard"></i> Carreras</a></li>
                <li><a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
            </ul>
        </nav>

        <div id="content" class="content">
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-outline-primary"><i class="bi bi-list"></i></button>
                    <span class="navbar-brand ms-3 fw-bold text-primary">Gestión de Docentes</span>
                </div>
            </nav>

            <div class="container-fluid p-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white border-bottom">
                        <h5 class="mb-0 fw-bold text-dark">
                            <i class="bi ${docente != null ? 'bi-pencil-square' : 'bi-person-plus'} text-primary me-2"></i>
                            ${docente != null ? 'Editar Docente' : 'Nuevo Docente'}
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/docentes" class="row g-3">
                            <input type="hidden" name="id" value="${docente != null ? docente.id : ''}">
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">DNI</label>
                                <input type="text" name="dni" class="form-control" value="${docente != null ? docente.dni : ''}" required maxlength="8" placeholder="8 dígitos">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Nombres</label>
                                <input type="text" name="nombres" class="form-control" value="${docente != null ? docente.nombres : ''}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control" value="${docente != null ? docente.apellidos : ''}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Especialidad</label>
                                <input type="text" name="especialidad" class="form-control" value="${docente != null ? docente.especialidad : ''}" required placeholder="Ej: Matemáticas">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" name="email" class="form-control" value="${docente != null ? docente.email : ''}" placeholder="docente@instituto.edu">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Teléfono</label>
                                <input type="text" name="telefono" class="form-control" value="${docente != null ? docente.telefono : ''}" placeholder="999999999">
                            </div>
                            <div class="col-md-5 text-end d-flex align-items-end justify-content-end">
                                <a href="${pageContext.request.contextPath}/docentes" class="btn btn-outline-secondary me-2"><i class="bi bi-x-circle me-1"></i>Cancelar</a>
                                <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save me-2"></i>${docente != null ? 'Actualizar' : 'Guardar'}</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-list-ul text-primary me-2"></i>Lista de Docentes</h5>
                        <span class="badge bg-primary">${docentes.size()} registros</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>DNI</th>
                                        <th>Apellidos y Nombres</th>
                                        <th>Especialidad</th>
                                        <th>Contacto</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="d" items="${docentes}">
                                        <tr>
                                            <td class="ps-4"><span class="badge bg-secondary">${d.id}</span></td>
                                            <td>${d.dni}</td>
                                            <td class="fw-semibold">${d.apellidos}, ${d.nombres}</td>
                                            <td><span class="badge bg-success">${d.especialidad}</span></td>
                                            <td>
                                                <small><i class="bi bi-envelope me-1"></i>${d.email}</small><br>
                                                <small><i class="bi bi-telephone me-1"></i>${d.telefono}</small>
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/docentes?action=edit&id=${d.id}" class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil"></i></a>
                                                <a href="${pageContext.request.contextPath}/docentes?action=delete&id=${d.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Eliminar a ${d.nombres} ${d.apellidos}?')"><i class="bi bi-trash"></i></a>
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