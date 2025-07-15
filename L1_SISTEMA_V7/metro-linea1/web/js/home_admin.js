// Mostrar u ocultar el dropdown de notificaciones
function toggleNotificaciones() {
    var dropdown = document.getElementById("notiDropdown");
    if (dropdown.style.display === "none" || dropdown.style.display === "") {
        dropdown.style.display = "block";
        // Opcional: cerrar si haces clic fuera
        document.addEventListener('click', cerrarDropdownFuera, true);
    } else {
        dropdown.style.display = "none";
        document.removeEventListener('click', cerrarDropdownFuera, true);
    }
}

// Cierra el dropdown si haces clic fuera de él
function cerrarDropdownFuera(e) {
    var dropdown = document.getElementById("notiDropdown");
    var btn = document.getElementById("btnNoti");
    if (!dropdown.contains(e.target) && e.target !== btn) {
        dropdown.style.display = "none";
        document.removeEventListener('click', cerrarDropdownFuera, true);
    }
}

// Cierra el dropdown si se presiona ESC
document.addEventListener('keydown', function(e) {
    if (e.key === "Escape") {
        var dropdown = document.getElementById("notiDropdown");
        if (dropdown && dropdown.style.display === "block") {
            dropdown.style.display = "none";
            document.removeEventListener('click', cerrarDropdownFuera, true);
        }
    }
});
