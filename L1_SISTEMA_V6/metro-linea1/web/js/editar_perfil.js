// Previsualización foto
function mostrarPrevisualizacion(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('fotoPerfilVista').src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    }
}
// Medidor de nivel de contraseña
function nivelPassword() {
    var v = document.getElementById('nuevaPass').value;
    var nivel = "Nivel: ";
    if (v.length < 6) nivel += "Bajo";
    else if (/[A-Z]/.test(v) && /[a-z]/.test(v) && /[0-9]/.test(v) && /[\W]/.test(v) && v.length > 9) nivel += "Alto";
    else if (v.length > 7 && /[A-Z]/.test(v) && /[0-9]/.test(v)) nivel += "Medio";
    else nivel += "Bajo";
    document.getElementById('nivel').textContent = nivel;
}
