// Función para visualizar requisitos del conductor
function verRequerimientos(idConductor) {
    alert('Visualizando requisitos del conductor ID: ' + idConductor);
    // Aquí se implementaría la llamada AJAX para obtener los requisitos
}

// Manejo de la edición de la tabla
document.addEventListener('DOMContentLoaded', function() {
    const btnEditar = document.getElementById('btnEditar');
    const btnGuardar = document.getElementById('btnGuardar');
    const tabla = document.querySelector('table');
    let editMode = false;
    
    if (!btnEditar || !btnGuardar) {
        console.error("No se encontraron los botones de edición en la página");
        return;
    }
    
    // Botón para habilitar la edición
    btnEditar.addEventListener('click', function() {
        editMode = true;
        btnEditar.style.display = 'none';
        btnGuardar.style.display = 'inline-block';
        
        // Habilitar celdas editables
        const filas = tabla.querySelectorAll('tbody tr');
        filas.forEach(fila => {
            fila.classList.add('editable-row');
            
            // Campos editables: Modalidad, Base, Habilitado, Estado del Personal, Observaciones
            const celdas = [2, 4, 5, 8]; // Índices de las columnas editables
            celdas.forEach(index => {
                if (fila.cells.length > index) { // Verificar que la celda exista
                    const celda = fila.cells[index];
                    const contenido = celda.textContent.trim();
                    
                    if (index === 2) { // Modalidad
                        celda.innerHTML = `
                            <select class="form-select form-select-sm">
                                <option value="FULL-TIME" ${contenido === 'FULL-TIME' ? 'selected' : ''}>FULL-TIME</option>
                                <option value="PART-TIME" ${contenido === 'PART-TIME' ? 'selected' : ''}>PART-TIME</option>
                            </select>`;
                    } else if (index === 4) { // Base
                        celda.innerHTML = `
                            <select class="form-select form-select-sm">
                                <option value="VES" ${contenido === 'VES' ? 'selected' : ''}>VES</option>
                                <option value="BAY" ${contenido === 'BAY' ? 'selected' : ''}>BAY</option>
                            </select>`;
                    } else if (index === 5) { // Habilitado
                        celda.innerHTML = `
                            <select class="form-select form-select-sm">
                                <option value="true" ${contenido === 'Sí' ? 'selected' : ''}>Sí</option>
                                <option value="false" ${contenido === 'No' ? 'selected' : ''}>No</option>
                            </select>`;
                    } else if (index === 8) { // Estado del Personal
                        celda.innerHTML = `
                            <select class="form-select form-select-sm">
                                <option value="ACTIVO" ${contenido === 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                                <option value="DESCANSO MEDICO" ${contenido === 'DESCANSO MEDICO' ? 'selected' : ''}>DESCANSO MEDICO</option>
                                <option value="FUERA DE LINEA" ${contenido === 'FUERA DE LINEA' ? 'selected' : ''}>FUERA DE LINEA</option>
                                <option value="SUSPENDIDO" ${contenido === 'SUSPENDIDO' ? 'selected' : ''}>SUSPENDIDO</option>
                            </select>`;
                    }
                }
            });
        });
    });
    
    // Botón para guardar cambios
    btnGuardar.addEventListener('click', function() {
        // Mostrar diálogo de confirmación
        if (confirm("¿Confirma que desea guardar la información?")) {
            // Preparar datos para enviar al servidor
            const conductores = [];
            const filas = tabla.querySelectorAll('tbody tr.editable-row');
            
            filas.forEach(fila => {
                // Solo si la fila tiene un ID válido
                const idConductor = fila.querySelector('a[onclick*="verRequerimientos"]')?.
                    getAttribute('onclick')?.
                    match(/\d+/)?.[0];
                
                if (idConductor) {
                    const modalidad = fila.cells[2].querySelector('select')?.value;
                    const base = fila.cells[4].querySelector('select')?.value;
                    const habilitado = fila.cells[5].querySelector('select')?.value === 'true';
                    const estadoPersonal = fila.cells[8].querySelector('select')?.value;
                    
                    conductores.push({
                        idConductor: idConductor,
                        modalidad: modalidad,
                        base: base,
                        habilitado: habilitado,
                        estadoPersonal: estadoPersonal
                    });
                }
            });
            
            // Enviar datos mediante AJAX
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'ActualizarConductoresServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        alert("INFORMACION GUARDADA");
                        location.reload(); // Recargar para ver los cambios
                    } else {
                        alert("INFORMACION NO GUARDADA: " + xhr.statusText);
                    }
                    
                    // Deshabilitamos el modo edición
                    editMode = false;
                    btnGuardar.style.display = 'none';
                    btnEditar.style.display = 'inline-block';
                }
            };
            
            // Enviar los datos como JSON
            xhr.send(JSON.stringify(conductores));
        }
    });
    
    // Diagnóstico de problemas de sesión
    console.log("Script de gestión de conductores cargado");
    console.log("Session ID desde JavaScript:", document.cookie.match(/JSESSIONID=([^;]+)/)?.[1] || "No disponible");
});