<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Alumnos - Instituto Cajas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/instituto-theme.css" rel="stylesheet">
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
                <li class="active"><a href="${pageContext.request.contextPath}/alumnos"><i class="bi bi-people"></i> Alumnos</a></li>
                <li><a href="${pageContext.request.contextPath}/docentes"><i class="bi bi-person-workspace"></i> Docentes</a></li>
                <li><a href="${pageContext.request.contextPath}/cursos"><i class="bi bi-book"></i> Cursos</a></li>
                <li><a href="${pageContext.request.contextPath}/carreras"><i class="bi bi-mortarboard"></i> Carreras</a></li>
                <li><a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
            </ul>
        </nav>

        <div id="content" class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-outline-secondary">
                        <i class="bi bi-list"></i>
                    </button>
                    <span class="navbar-brand ms-3 fw-bold text-primary">
                        <i class="bi bi-people me-2"></i>Gestión de Alumnos
                    </span>
                    <div class="ms-auto d-flex align-items-center gap-3">
                        <span class="text-muted"><i class="bi bi-person-circle me-1"></i> Administrador</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                            <i class="bi bi-box-arrow-right me-1"></i>Cerrar Sesión
                        </a>
                    </div>
                </div>
            </nav>

            <div class="container-fluid p-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white border-bottom">
                        <h5 class="mb-0 fw-bold text-dark">
                            <i class="bi ${alumno != null ? 'bi-pencil-square' : 'bi-person-plus'} text-primary me-2"></i>
                            ${alumno != null ? 'Editar Alumno' : 'Nuevo Alumno'}
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/alumnos" class="row g-3">
                            <input type="hidden" name="id" value="${alumno != null ? alumno.id : ''}">
                            
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Código</label>
                                <input type="text" name="codigo" class="form-control" value="${alumno != null ? alumno.codigo : ''}" required placeholder="Ej: ALU001">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">DNI <small class="text-muted">(Buscar con Decolecta)</small></label>
                                <div class="input-group">
                                    <input type="text" name="dni" id="dniInput" class="form-control" value="${alumno != null ? alumno.dni : ''}" required maxlength="8" placeholder="8 dígitos">
                                    <button type="button" class="btn btn-info" onclick="buscarDNIAlumno()">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Nombres</label>
                                <input type="text" name="nombres" id="nombresInput" class="form-control" value="${alumno != null ? alumno.nombres : ''}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Apellidos</label>
                                <input type="text" name="apellidos" id="apellidosInput" class="form-control" value="${alumno != null ? alumno.apellidos : ''}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" name="email" class="form-control" value="${alumno != null ? alumno.email : ''}" placeholder="alumno@email.com">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Teléfono</label>
                                <input type="text" name="telefono" class="form-control" value="${alumno != null ? alumno.telefono : ''}" placeholder="999999999">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Carrera</label>
                                <select name="carrera_id" class="form-select" required>
                                    <option value="">Seleccionar</option>
                                    <c:forEach var="c" items="${carreras}">
                                        <option value="${c.id}" ${alumno != null && alumno.carreraId == c.id ? 'selected' : ''}>${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Ciclo</label>
                                <select name="ciclo" class="form-select" required>
                                    <option value="">Seleccionar</option>
                                    <option value="1" ${alumno != null && alumno.ciclo == 1 ? 'selected' : ''}>I Ciclo</option>
                                    <option value="2" ${alumno != null && alumno.ciclo == 2 ? 'selected' : ''}>II Ciclo</option>
                                    <option value="3" ${alumno != null && alumno.ciclo == 3 ? 'selected' : ''}>III Ciclo</option>
                                    <option value="4" ${alumno != null && alumno.ciclo == 4 ? 'selected' : ''}>IV Ciclo</option>
                                    <option value="5" ${alumno != null && alumno.ciclo == 5 ? 'selected' : ''}>V Ciclo</option>
                                    <option value="6" ${alumno != null && alumno.ciclo == 6 ? 'selected' : ''}>VI Ciclo</option>
                                </select>
                            </div>
                            <div class="col-12 text-end">
                                <a href="${pageContext.request.contextPath}/alumnos" class="btn btn-outline-secondary me-2"><i class="bi bi-x-circle me-1"></i>Cancelar</a>
                                <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save me-2"></i>${alumno != null ? 'Actualizar' : 'Guardar'}</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-list-ul text-primary me-2"></i>Lista de Alumnos</h5>
                        <span class="badge bg-primary">${alumnos.size()} registros</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>Código</th>
                                        <th>DNI</th>
                                        <th>Apellidos y Nombres</th>
                                        <th>Carrera</th>
                                        <th>Ciclo</th>
                                        <th>Contacto</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="a" items="${alumnos}">
                                        <tr>
                                            <td class="ps-4"><span class="badge bg-secondary">${a.id}</span></td>
                                            <td class="fw-semibold text-primary">${a.codigo}</td>
                                            <td>${a.dni}</td>
                                            <td class="fw-semibold">${a.apellidos}, ${a.nombres}</td>
                                            <td><span class="badge bg-info">${a.nombreCarrera}</span></td>
                                            <td><span class="badge bg-warning text-dark">${a.ciclo}° Ciclo</span></td>
                                            <td>
                                                <small><i class="bi bi-envelope me-1"></i>${a.email}</small><br>
                                                <small><i class="bi bi-telephone me-1"></i>${a.telefono}</small>
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/alumnos?action=edit&id=${a.id}" class="btn btn-sm btn-outline-primary me-1" title="Editar"><i class="bi bi-pencil"></i></a>
                                                <a href="${pageContext.request.contextPath}/alumnos?action=delete&id=${a.id}" class="btn btn-sm btn-outline-danger" title="Eliminar" onclick="return confirm('¿Eliminar a ${a.nombres} ${a.apellidos}?')"><i class="bi bi-trash"></i></a>
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
    <script src="${pageContext.request.contextPath}/js/decolecta-api.js"></script>
    <script>
        function buscarDNIAlumno() {
            const dni = document.getElementById('dniInput').value;
            if (dni.length === 8) {
                buscarPorDNI(dni, 'nombresInput', 'apellidosInput');
            } else {
                alert('Ingrese un DNI válido de 8 dígitos');
            }
        }
    </script>
</body>
</html>