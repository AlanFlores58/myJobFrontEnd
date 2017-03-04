<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="css/mobile.css">
</head>
<body>
<%
    HttpSession sessionsa = request.getSession(false);
    String user = (String) sessionsa.getAttribute("username");
    String token = (String) sessionsa.getAttribute("token");
    String role = (String) sessionsa.getAttribute("role");
    String buttonLogin = "Login";
    String userMessage = "User Name";
    String state = "text";
    String state2 = "";
    String state3 = "password";
    if(token != null) {
        buttonLogin = "Logout";
        userMessage = "Bienvenido: " + user;
        state = "hidden";
        state2 = "hidden";
        state3 = "hidden";
    }
    System.out.println(user);
    System.out.println(role);
%>

<div class="flex-container navbar navbar-default navbar-fixed-top" role="navigation">

    <nav>
        <div class="cover">
            <div class="flex-item-navbar" id="navHeader">
                <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
            </div>
        </div>
        <ul class="navigation">
            <li><a class="active" href="Register.jsp">Regístrate</a></li>
            <li><a href="Contact.jsp">Contáctanos</a></li>
        </ul>
    </nav>

</div>
<div class="container">
    <form id="sigup-form" class="formContent" action="/front_job/saveImageUser" method="post" enctype="multipart/form-data">

        <h1>Registro</h1>

        <div class="headers"><img name="profileImg" src="" height="200" alt="Image preview..."></div>
        <div class="headers"><input type="file" name="file" onchange="previewFile()"/></div>

        <fieldset>
            <legend><span class="number"></span>Información Básica</legend>
            <div class="headers">
                <label for="name">Nombre:</label>
                <input type="text" id="name" name="name">
            </div>


            <div class="headers">
                <label for="lastname">Apellido:</label>
                <input type="text" id="lastname" name="lastname">
            </div>

            <div class="headers">
                <label for="mail">Email:</label>
                <input type="email" id="mail" name="mail">
            </div>

            <div class="headers">
                <label for="cellphone">Celular:</label>
                <input type="tel" id="cellphone" name="cellphone">
            </div>

            <div class="headers">
                <label for="telephone">Telefono:</label>
                <input type="tel" id="telephone" name="telephone">
            </div>

            <div class="headers">
                <label for="name">Nombre de Usuario:</label>
                <input type="text" id="username2" name="username">
            </div>

            <div class="headers">
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password">
            </div>

            <div class="headers">
                <label>Sexo:</label>
                <input type="radio" id="male" value="male" name="sex" checked="checked"><label for="male" class="light">Hombre</label>
                <input type="radio" id="female" value="female" name="sex"><label for="female" class="light">Mujer</label>
            </div>

            <div class="headers">
                <label>Tipo:</label>
                <input type="radio" id="buy" value="comprar" name="type" checked="checked"><label for="buy" class="light">Comprar</label>
                <input type="radio" id="sell" value="vender" name="type"><label for="sell" class="light">Vender</label>
            </div>

        </fieldset>
        <button type="button" class="btn-login" onclick="signup()" >Sign Up</button>
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
    function previewFile(){
        var preview = document.querySelector('img[name=profileImg]'); //selects the query named img
        var file    = document.querySelector('input[type=file]').files[0]; //sames as here
        var reader  = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
        }

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
        } else {
            preview.src = "";
        }
    }

    previewFile();

    function signup() {
        var authorizeButton = $('.btn-login');
        $('#sigup-form').submit();
    }
</script>

</body>
</html>