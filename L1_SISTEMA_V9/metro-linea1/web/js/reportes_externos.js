document.addEventListener('DOMContentLoaded', function() {
    let tipoReporte = document.getElementById('tipoReporte');
    function toggleFiltros() {
        let tipo = tipoReporte.value;
        document.getElementById('filtroFecha').style.display =
        document.getElementById('filtroFechaHasta').style.display =
            (tipo === 'turnos' || tipo === 'cambios' || tipo === 'especiales' || tipo === 'auditoria') ? 'block' : 'none';
        document.getElementById('filtroConductor').style.display =
            (tipo === 'turnos' || tipo === 'cambios') ? 'block' : 'none';
    }
    tipoReporte.addEventListener('change', toggleFiltros);
    toggleFiltros();
});