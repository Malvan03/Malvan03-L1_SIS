// Validación en el formulario de login
document.getElementById("loginForm").addEventListener("submit", function(e) {
    let usuario = document.getElementById("usuario").value;
    let contrasena = document.getElementById("contrasena").value;

    // Validar si los campos están vacíos
    if (usuario.trim() === "" || contrasena.trim() === "") {
        e.preventDefault(); // Evita el envío del formulario
        alert("Por favor, completa todos los campos.");
    }
});
