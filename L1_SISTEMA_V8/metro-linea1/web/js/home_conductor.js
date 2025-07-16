// Mostrar u ocultar el dropdown de notificaciones
function toggleNotificaciones() {
    var dropdown = document.getElementById("notiDropdown");
    if (dropdown.style.display === "none" || dropdown.style.display === "") {
        dropdown.style.display = "block";
        document.addEventListener('click', cerrarDropdownFuera, true);
    } else {
        dropdown.style.display = "none";
        document.removeEventListener('click', cerrarDropdownFuera, true);
    }
}
function cerrarDropdownFuera(e) {
    var dropdown = document.getElementById("notiDropdown");
    var btn = document.getElementById("btnNoti");
    if (!dropdown.contains(e.target) && e.target !== btn) {
        dropdown.style.display = "none";
        document.removeEventListener('click', cerrarDropdownFuera, true);
    }
}
