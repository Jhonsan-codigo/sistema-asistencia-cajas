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
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-${tipoMensaje} alert-dismissible fade show" role="alert">
                        <i class="fas fa-info-circle me-2"></i>${mensaje}
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
                                <input type="date" name="fecha" class="form-control" value="${fechaActual}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Carrera</label>
                                <select name="carrera_id" class="form-select" id="carreraSelect">
                                    <option value="">Todas las carreras</option>
                                    <c:forEach var="c" items="${carreras}">
                                        <option value="${c.id}" ${param.carrera_id == c.id ? 'selected' : ''}>${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-bold">Ciclo</label>
                                <select name="ciclo" class="form-select">
                                    <option value="">Seleccionar</option>
                                    <option value="1" ${param.ciclo == '1' ? 'selected' : ''}>I Ciclo</option>
                                    <option value="2" ${param.ciclo == '2' ? 'selected' : ''}>II Ciclo</option>
                                    <option value="3" ${param.ciclo == '3' ? 'selected' : ''}>III Ciclo</option>
                                    <option value="4" ${param.ciclo == '4' ? 'selected' : ''}>IV Ciclo</option>
                                    <option value="5" ${param.ciclo == '5' ? 'selected' : ''}>V Ciclo</option>
                                    <option value="6" ${param.ciclo == '6' ? 'selected' : ''}>VI Ciclo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Curso</label>
                                <select name="curso_id" class="form-select">
                                    <option value="">Seleccionar curso</option>
                                    <c:forEach var="c" items="${cursos}">
                                        <option value="${c.id}" ${param.curso_id == c.id ? 'selected' : ''}>${c.nombre}</option>
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

                <!-- Consulta RENIEC -->
                <!-- Consulta RENIEC - Moderna -->
<div class="card shadow-sm mb-4" style="border-radius: var(--radius); border: 1px solid #f1f5f9;">
    <div class="card-header bg-white" style="border-bottom: 1px solid #f8fafc;">
        <h5 class="mb-0" style="color: var(--dark); font-weight: 600;">
            <i class="bi bi-search me-2" style="color: var(--primary);"></i>Consulta de Datos del Alumno
        </h5>
    </div>
    <div class="card-body" style="padding: 24px;">
        <div class="row g-3 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-bold">DNI del Alumno</label>
                <div class="input-group">
                    <input type="text" id="dniBusqueda" class="form-control" placeholder="Ingrese DNI" maxlength="8" style="border-radius: var(--radius-sm) 0 0 var(--radius-sm);">
                    <button type="button" class="btn btn-primary" onclick="buscarPorDNI()" style="border-radius: 0 var(--radius-sm) var(--radius-sm) 0;">
                        <i class="bi bi-search me-1"></i>Buscar
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-bold">Nombres</label>
                <input type="text" id="nombresResult" class="form-control" placeholder="Se autocompletará" readonly style="background: #f8fafc;">
            </div>
            <div class="col-md-4">
                <label class="form-label fw-bold">Apellidos</label>
                <input type="text" id="apellidosResult" class="form-control" placeholder="Se autocompletará" readonly style="background: #f8fafc;">
            </div>
        </div>
        <div id="dniLoading" class="d-none mt-3 text-center">
            <div class="spinner-border text-primary" role="status" style="width: 1.5rem; height: 1.5rem;">
                <span class="visually-hidden">Consultando...</span>
            </div>
            <span class="ms-2 text-muted" style="font-size: 0.85rem;">Consultando en RENIEC...</span>
        </div>
        <div class="alert alert-light mt-3 mb-0" style="background: #f8fafc; border: 1px solid #f1f5f9; border-radius: var(--radius-sm);">
            <i class="bi bi-info-circle text-primary me-2"></i>
            <span style="color: #475569; font-size: 0.85rem;">
                <strong style="color: var(--dark);">Sistema integrado con RENIEC:</strong> Ingrese el DNI del alumno y presione "Buscar" para obtener los datos oficiales del Registro Nacional de Identificación y Estado Civil.
            </span>
        </div>
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
                                    <input type="hidden" name="fecha" value="${fechaActual}">
                                    <input type="hidden" name="curso_id" value="${param.curso_id}">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th class="text-center">#</th>
                                                    <th>DNI</th>
                                                    <th>Apellidos y Nombres</th>
                                                    <th class="text-center">Estado</th>
                                                    <th>Observación</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="a" items="${alumnos}" varStatus="loop">
                                                    <tr>
                                                        <td class="text-center">${loop.index + 1}</td>
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
                                    <div class="p-3 bg-light border-top">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-2"></i>Guardar Asistencia
                                        </button>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                    <h5 class="text-muted">No se encontraron alumnos para el curso y fecha seleccionados</h5>
                                    <p class="text-muted">Verifica que haya alumnos registrados en esta carrera y ciclo.</p>
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
    <script>
    // ============================================
    // CONSULTA RENIEC - INTEGRACIÓN INSTITUCIONAL
    // ============================================

    function buscarPorDNI() {
        var dniInput = document.getElementById('dniBusqueda');
        var dni = dniInput ? dniInput.value.trim() : '';
        
        // Validación
        if (!dni || dni === '') {
            alert('Por favor ingrese el número de DNI del alumno.');
            return;
        }
        
        if (dni.length !== 8) {
            alert('El DNI debe contener exactamente 8 dígitos numéricos.\nIngresado: ' + dni.length + ' dígitos');
            return;
        }
        
        if (!/^\d{8}$/.test(dni)) {
            alert('El DNI solo debe contener números. Verifique el número ingresado.');
            return;
        }

        // Mostrar loading
        var loadingEl = document.getElementById('dniLoading');
        if (loadingEl) loadingEl.classList.remove('d-none');

        var nombresInput = document.getElementById('nombresResult');
        var apellidosInput = document.getElementById('apellidosResult');

        // Construir URL
        var pathParts = window.location.pathname.split('/');
        var contextPath = pathParts.length > 1 ? '/' + pathParts[1] : '';
        var url = contextPath + '/consulta-dni?numero=' + encodeURIComponent(dni);
        
        // Llamar al Servlet de consulta
        fetch(url, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('Error del servidor: ' + response.status);
            }
            return response.json();
        })
        .then(function(data) {
            var persona = data.data || data;
            
            if (data.success === false) {
                throw new Error(data.message || 'No se pudo completar la consulta');
            }
            
            if (!persona || (!persona.nombres && !persona.nombre)) {
                throw new Error('El DNI ' + dni + ' no se encuentra registrado en RENIEC.');
            }
            
            // Llenar campos con datos oficiales
            if (nombresInput) {
                nombresInput.value = persona.nombres || persona.nombre || '';
                nombresInput.classList.add('is-valid');
            }
            
            if (apellidosInput) {
                var apPat = persona.apellido_paterno || persona.apPrimer || '';
                var apMat = persona.apellido_materno || persona.apSegundo || '';
                apellidosInput.value = (apPat + ' ' + apMat).trim();
                apellidosInput.classList.add('is-valid');
            }

            mostrarNotificacion('Consulta RENIEC exitosa. Datos oficiales recuperados.', 'success');
        })
        .catch(function(error) {
            mostrarNotificacion(error.message, 'danger');
            
            if (nombresInput) {
                nombresInput.value = '';
                nombresInput.classList.remove('is-valid');
            }
            if (apellidosInput) {
                apellidosInput.value = '';
                apellidosInput.classList.remove('is-valid');
            }
        })
        .finally(function() {
            if (loadingEl) loadingEl.classList.add('d-none');
        });
    }

    function mostrarNotificacion(mensaje, tipo) {
        var toastContainer = document.getElementById('toast-container');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toast-container';
            toastContainer.className = 'position-fixed top-0 end-0 p-3';
            toastContainer.style.zIndex = '9999';
            document.body.appendChild(toastContainer);
        }

        var toastDiv = document.createElement('div');
        toastDiv.className = 'toast align-items-center text-white bg-' + (tipo || 'info') + ' border-0 show';
        toastDiv.setAttribute('role', 'alert');
        toastDiv.innerHTML = 
            '<div class="d-flex">' +
                '<div class="toast-body">' + mensaje + '</div>' +
                '<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>' +
            '</div>';
        
        toastContainer.appendChild(toastDiv);
        
        setTimeout(function() {
            toastDiv.remove();
        }, 5000);
    }
    </script>
</body>
</html>