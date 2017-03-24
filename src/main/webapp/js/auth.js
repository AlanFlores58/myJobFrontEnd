/**
 * Created by alan.flores on 1/31/17.
 */

function Login() {
    $.ajax({
        url: "http://localhost:8080/api_job/public/api/v1/login/" + $('#username').val() + "/" + $('#password').val() + "",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            if (data.status === "200") {
                console.log(data.data.token);
                alert("Usuario valido.");
                $('#login-token').val(data.data.token);
                $('#login-form').submit();
            }
            else {
                alert("Usuario o contraseña no validos.");
            }
        },
        error: function (err) {
            console.log(err)
            alert(err.statusText);
        }
    });
}



function Logout() {
    $.get("/front_job/logout", function (data) {
        window.location.href = "/front_job/index.jsp";
    });
}

function getPremium() {
    if (confirm('El costo de la version premium es de $400 MXN ¿Decea continuar?')) {
        var tarjeta = prompt("Numero de tarjeta", "");

        if (tarjeta != null && tarjeta.trim() != "") {
            var numeroSecreto = prompt("Numero de secreto", "");
            if (numeroSecreto != null && numeroSecreto.trim() != "") {
                $.post("/front_job/getPremium", function (data) {
                    window.location.href = "/front_job/premium/index.jsp";
                });
            }
        }
    }
}