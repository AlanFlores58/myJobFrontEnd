<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/13/17
  Time: 3:47 PM
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
    String token = (String) sessionsa.getAttribute("token");
    String role = (String) sessionsa.getAttribute("role");
    String buttonLogin = "Login";
    String userMessage = "User Name";
    String state = "text";
    String state2 = "";
    String image = (String) sessionsa.getAttribute("image");
    String state3 = "password";
    if(token != null) {
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
            <li><a class="active" href="newServiceType.jsp">Nuevo tipo de servicio</a></li>
            <li><a href="listServicesType.jsp">Editar tipo de servicio</a></li>
            <li><a href="myContracts.jsp">Contratos</a></li>
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
<div class="formContent">
<form name="save" action="/front_job/saveImage" id="save-form" method="post" enctype="multipart/form-data">
    <div class="headers"><img src="" name="serviceImage" alt="Image preview..."></div>
    <div class="headers"><input type="file" name="file" onchange="previewFile()"/></div>
    <div class="headers">
        <label for="name">* Nombre:</label>
        <input type="text" id="name" name="name">
    </div>

    <div class="headers">
        <label for="description">* Descripcion:</label>
        <input type="text" id="description" name="description">
    </div>

</form>
<button class="btn-login" onclick="Save()">Save</button>
</div>
</div>
<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
</body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="../js/auth.js"></script>
<script type="text/javascript" src="../js/CheckElements.js"></script>
<script>

    function previewFile(){
        var preview = document.querySelector('img[name=serviceImage]'); //selects the query named img
        var file    = document.querySelector('input[name=file]').files[0]; //sames as here
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

    function Save(){
        if(!checkCampsNull($('#name'),$('#description')))
            $('#save-form').submit();
    }

    previewFile();  //calls the function named previewFile()

</script>
</html>
