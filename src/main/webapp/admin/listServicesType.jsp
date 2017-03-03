<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 7:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/mobile.css">
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
    System.out.println(user);
    System.out.println(role);
%>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script>
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
                    console.log(data.data);
                    var result = $('#myTable');
                    result.html('');
                    var i = 0
                    data.data.forEach(function (item, index) {
                        if(i % 3 === 0){
                            result.append('<tr>');
                        }

                        result.append('<td><a href=updateService.jsp?serviceTypeID=' + item.id + '><img src="' + item.image + '" alt="' + item.name + '" width="200" height="300"><br>' + item.name + '</a></td>');

                        if(i % 3 === 0){
                            result.append('</tr>');
                        }

                        i++;
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
</head>
<body>
<div class="flex-container navbar navbar-default navbar-fixed-top" role="navigation">

    <nav>
        <div class="cover">
            <div class="flex-item-navbar" id="navHeader">
                <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
            </div>
        </div>
        <ul class="navigation">
            <li><a href="newServiceType.jsp">Nuevo tipo de servicio</a></li>
            <li><a class="active" href="listServicesType.jsp">Editar tipo de servicio</a></li>
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
    <table id="myTable" class="imageTable"></table>
</div>

<footer>
    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
    function Login() {
        var authorizeButton = $('.btn-login');
        $.ajax({
            url : "http://localhost:8095/api_job/public/api/v1/login/" + $('#username').val() + "/" + $('#password').val() + "",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType   : "json",
            success    : function(data){
                if(data.status === "200"){
                    console.log(data.data.token);
                    alert("Usuario valido.");
                    $('#login-token').val(data.data.token);
                    $('#login-form').submit();
                }
                else{
                    alert("Usuario o contraseña no validos.");
                    authorizeButton.onclick = handleAuthClick;
                }
            },
            error: function(err){
                alert(err);
            },
        });
    }

    function Logout() {
        $.get("/front_job/logout", function(data) {
            window.location.href = "/front_job/index.jsp";
        });
    }
</script>
</body>
</html>