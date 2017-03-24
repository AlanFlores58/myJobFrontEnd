<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/9/17
  Time: 8:42 AM
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
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
    $.ajax({
        url: "http://localhost:8080/api_job/private/api/v1/getServicesByUser/<%=userName%>",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
        },
        success: function (data) {
            if (data.status === "200") {
                console.log(data.data);
                var result = $('#myTable');
                result.html('');
                result.append('<tr>');
                result.append('<th>Id</th>');
                result.append('<th>Nombre</th>');
                result.append('<th>Descripcion</th>');
                result.append('<th>Precio</th>');
                result.append('<th>Tipo</th>');
                result.append('</tr>');
                data.data.forEach(function (item, index) {
                    result.append('<tr>');
                    result.append('<td class="button imageTable" ><a href="updateService.jsp?serviceID=' + item.id + '">' + item.id + '</a></td>');
                    result.append('<td>' + item.name + '</td>');
                    result.append('<td>' + item.description + '</td>');
                    result.append('<td>' + item.price + '</td>');
                    result.append('<td>' + item.serviceType.name + '</td>');
                    result.append('</tr>');
                });
            }
            else {
                alert(data.status);
            }
        },
        error: function (err) {
            alert(err);
        }
    });
</script>
<div class="flex-container navbar navbar-default navbar-fixed-top" role="navigation">

    <nav>
        <div class="cover">
            <div class="flex-item-navbar" id="navHeader">
                <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
            </div>
        </div>
        <ul class="navigation">
            <li><a href="newService.jsp">Nuevo servicio</a></li>
            <li><a class="active" href="listService.jsp">Actualizar servicio</a></li>
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
    <div class="formSearch">
        ID: <input type="text" id="contract" name="contract">
        <input type="button" class="button" onclick="searchId()" value="Buscar">
    </div>
    <table id="myTable">
    </table>
</div>
<footer>
    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
<script type="text/javascript" src="../js/auth.js"></script>
<script type="text/javascript" src="../js/CheckElements.js"></script>
<script>
    function searchId() {
        if(!checkCampsNull($('#contract')))
            window.location.href = "updateService.jsp?serviceID=" + $('#contract').val();
    }
</script>
</body>
</html>
