<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/7/17
  Time: 2:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/mobile.css">
</head>
<body>

<%
    HttpSession sessionsa = request.getSession(false);
    String user = (String) sessionsa.getAttribute("username");
    String userName = (String) sessionsa.getAttribute("username");
    String token = (String) sessionsa.getAttribute("token");
    String role = (String) sessionsa.getAttribute("role");
    String buttonLogin = "Login";
    String userMessage = "User Name";
    String state = "text";
    String state2 = "";
    String state3 = "password";
    String image = (String) sessionsa.getAttribute("image");
    if (token != null) {
        buttonLogin = "Logout";
        userMessage = "Bienvenido: " + user;
        state = "hidden";
        state2 = "hidden";
        state3 = "hidden";
    }
%>

<div class="flex-container navbar navbar-default navbar-fixed-top" role="navigation">

    <nav>
        <div class="cover">
            <div class="flex-item-navbar" id="navHeader">
                <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
            </div>
        </div>
        <ul class="navigation">
            <li><a class="active" href="newService.jsp">Nuevo servicio</a></li>
            <li><a href="listService.jsp">Actualizar servicio</a></li>
            <li><a href="confrimService.jsp">Confirmar contrato</a></li>
            <li><a href="finishService.jsp">Terminar contrato</a></li>
            <li><a href="Contact.jsp">Contáctanos</a></li>
        </ul>
    </nav>


    <div class="login flex-item3">

        <form name="login" action="/front_job/login" id="login-form" method="post" accept-charset="utf-8">
            <input id="login-token" name="token" type="hidden" >
            <label for="username"><%=userMessage%></label>
            <input type="<%=state%>" id="username" placeholder="username" required></li>

            <img name="profileImg" class="profileImg" src="<%=image%>" alt="User image...">


            <label for="password" <%=state2%>>Password</label>
            <input type="<%=state3%>" id="password" placeholder="password" required>


            <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" ><span class="content"><%=buttonLogin%></span></button>
        </form>
    </div>

</div>

<div class="container">
    <form name="save" class="formContent" action="/front_job/retail/index.jsp" id="save-form" method="post">
        <div class="headers">
            <label for="name">Nombre:</label>
            <input type="text" id="name" name="name">
        </div>

        <div class="headers">
            <label for="description">Descripcion:</label>
            <input type="text" id="description" name="description">
        </div>

        <div class="headers">
            <label for="price">Precio:</label>
            <input type="text" id="price" name="price">
        </div>

        <div class="headers">
            <label for="type">Tipo de servicio:</label>

            <div name="result" id="result"></div>
        </div>

        <button type="button" class="btn-save btn-login" onclick="Save()"><span class="content">Guardar</span></button>
    </form>
</div>

<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

<script>
    showServicesType();
    function showServicesType() {

        $.ajax({
            url: "http://localhost:8095/api_job/private/api/v1/getAllServices",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
            },
            success: function (data) {
                if (data.status === "200") {
                    var result = $('#result');
                    result.html('');
                    data.data.forEach(function (item, index) {
                        if (index === 0)
                            result.append('<label>' + item.name + '</label><input type="radio" name="type" checked value="' + item.id + '" /> ');
                        else
                            result.append('<label>' + item.name + '</label><input type="radio" name="type" value="' + item.id + '" /> ');
                    });
                    console.log(data.data);
                }
                else {
                    alert("Usuario o contraseña no validos.");
                    authorizeButton.onclick = handleAuthClick;
                }
            },
            error: function (err) {
                alert(err);
            },
        });
    }

    function Save() {
        var authorizeButton = $('.btn-save');

        $.ajax({
            url: "http://localhost:8095/api_job/private/api/v1/saveNewService/" + $('#description').val() + "/" + $('#name').val() + "/" + $('#price').val() + "/" + $('input:radio[name=type]:checked').val() + "/<%=userName%>",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
            },
            success: function (data) {
                if (data.status === "200") {
                    alert("Nuevo servicio almacenado: " + data.data.name);
                    $('#save-form').submit();
                }
                else {
                    alert("Usuario o contraseña no validos.");
                }
            },
            error: function (err) {
                alert(err);
            },
        });
    }

    function Login() {
        var authorizeButton = $('.btn-login');
        $.ajax({
            url: "http://localhost:8095/api_job/public/api/v1/login/" + $('#username').val() + "/" + $('#password').val() + "",
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
                    authorizeButton.onclick = handleAuthClick;
                }
            },
            error: function (err) {
                alert(err);
            },
        });
    }

    function Logout() {
        $.get("/front_job/logout", function (data) {
            window.location.href = "/front_job/index.jsp";
        });
    }
</script>
</body>
</html>
