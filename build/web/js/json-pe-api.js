/* ============================================
   JSON.PE API - INTEGRACIÓN DNI
   ============================================ */

function buscarPorDNI() {
    
    var dniInput = document.getElementById('dniBusqueda');
    var dni = dniInput ? dniInput.value.trim() : '';
    
    console.log('DNI:', dni, '| Longitud:', dni.length);
    
    if (!dni || dni === '') {
        alert('El campo DNI está vacío.');
        return;
    }
    
    if (dni.length !== 8) {
        alert('El DNI debe tener exactamente 8 dígitos.\nIngresaste: "' + dni + '" (' + dni.length + ' dígitos)');
        return;
    }
    
    if (!/^\d{8}$/.test(dni)) {
        alert('El DNI solo debe contener números.\nIngresaste: "' + dni + '"');
        return;
    }

    var loadingEl = document.getElementById('dniLoading');
    if (loadingEl) loadingEl.classList.remove('d-none');

    var nombresInput = document.getElementById('nombresResult');
    var apellidosInput = document.getElementById('apellidosResult');

    var pathParts = window.location.pathname.split('/');
    var contextPath = pathParts.length > 1 ? '/' + pathParts[1] : '';
    
    var url = contextPath + '/consulta-dni?numero=' + dni;
    console.log('URL:', url);
    
    fetch(url, {
        method: 'GET',
        headers: { 'Accept': 'application/json' }
    })
    .then(function(response) {
        console.log('HTTP Status:', response.status);
        return response.json();
    })
    .then(function(data) {
        console.log('Respuesta:', data);
        
        // Json.pe devuelve: { nombres, apellido_paterno, apellido_materno, nombre_completo }
        // O nuestro modo demo: { success, data: { ... } }
        
        var persona = data.data || data;
        
        if (data.success === false) {
            throw new Error(data.message || 'Error en la consulta');
        }
        
        if (!persona || (!persona.nombres && !persona.nombre)) {
            throw new Error('No se encontraron datos para el DNI: ' + dni);
        }
        
        // Json.pe usa: nombres, apellido_paterno, apellido_materno
        if (nombresInput) {
            nombresInput.value = persona.nombres || '';
            nombresInput.classList.add('is-valid');
        }
        
        if (apellidosInput) {
            var apPat = persona.apellido_paterno || '';
            var apMat = persona.apellido_materno || '';
            apellidosInput.value = (apPat + ' ' + apMat).trim();
            apellidosInput.classList.add('is-valid');
        }

        var msg = data.message || 'Datos encontrados';
        mostrarNotificacion('✅ ' + msg, 'success');
    })
    .catch(function(error) {
        console.error('Error:', error);
        mostrarNotificacion('❌ ' + error.message, 'danger');
        
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

function buscarDNIAlumno() {
    var dniInput = document.getElementById('dniInput');
    var dni = dniInput ? dniInput.value.trim() : '';
    
    if (!dni || dni.length !== 8 || !/^\d{8}$/.test(dni)) {
        alert('Por favor ingrese un DNI válido de 8 dígitos numéricos.');
        return;
    }
    
    var nombresInput = document.getElementById('nombresInput');
    var apellidosInput = document.getElementById('apellidosInput');
    
    var tempDni = document.createElement('input');
    tempDni.id = 'dniBusqueda';
    tempDni.type = 'hidden';
    tempDni.value = dni;
    document.body.appendChild(tempDni);
    
    var tempNombres = document.createElement('input');
    tempNombres.id = 'nombresResult';
    tempNombres.type = 'hidden';
    document.body.appendChild(tempNombres);
    
    var tempApellidos = document.createElement('input');
    tempApellidos.id = 'apellidosResult';
    tempApellidos.type = 'hidden';
    document.body.appendChild(tempApellidos);
    
    buscarPorDNI();
    
    setTimeout(function() {
        if (nombresInput) nombresInput.value = tempNombres.value;
        if (apellidosInput) apellidosInput.value = tempApellidos.value;
        
        tempDni.remove();
        tempNombres.remove();
        tempApellidos.remove();
    }, 2000);
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

window.buscarPorDNI = buscarPorDNI;
window.buscarDNIAlumno = buscarDNIAlumno;
window.mostrarNotificacion = mostrarNotificacion;