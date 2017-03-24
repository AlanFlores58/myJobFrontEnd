<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 9:11 AM
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
        String token = (String) sessionsa.getAttribute("token");
        String userName = (String) (String) sessionsa.getAttribute("username");
        String type = request.getParameter("type");
        String user = (String) sessionsa.getAttribute("username");
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
        String requestUserId = request.getParameter("requestUserId");
    %>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script>
        $.ajax({
            url: "http://localhost:8080/api_job/private/api/v1/getUserInfo/<%=requestUserId%>",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
            },
            success: function (data) {
                if (data.status === "200") {
                    console.log(data.data);
                    var username = $("#user");
                    var name= $("#name");
                    var lastname = $("#lastname");
                    var email = $("#email");
                    var cellphone = $("#cellphone");
                    var telephone = $("#telephone");

                    username.append("" + data.data.username + "");
                    name.append("" + data.data.name + "");
                    lastname.append("" + data.data.last_name + "");
                    email.append("" + data.data.email + "");
                    cellphone.append("" + data.data.cellphone + "")
                    telephone.append("" + data.data.telephone + "")
                    $.ajax({
                        url: "http://localhost:8080/api_job/private/api/v1/getCommentsByUserService/" + data.data.username,
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
                        },
                        success: function (data2) {
                            if (data2.status === "200") {
                                console.log(data2.data);
                                var result = $('#myTable');
                                result.html('');
                                result.append('<tr>');
                                result.append('<th>Id</th>');
                                result.append('<th>Comentario</th>');
                                result.append('<th>Usuario</th>');
                                result.append('</tr>');
                                data2.data.forEach(function (item, index) {
                                    result.append('<tr>');
                                    result.append('<td>' + item.id + '</td>');
                                    result.append('<td>' + item.comment + '</td>');
                                    result.append('<td>' + item.userDoer.username + '</td>');
                                    result.append('</tr>');
                                });

                            }
                            else {
                                alert(data2.status);
                            }
                        },
                        error: function (err) {
                            alert(err);
                        }
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
            <li><a href="listTickets.jsp">Mis cupones</a></li>
            <li><a class="active" href="listServicesType.jsp">Servicios</a></li>
            <li><a href="myContracts.jsp">Mis Contratos</a></li>
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


            <div class="getPremiunVersion">
                <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" ><span class="content"><%=buttonLogin%></span></button>
                <button type="button" class="btn-login" onclick="getPremium()"><span class="content">Version Premium</span></button>
            </div>
        </form>
    </div>

</div>
<div class="container">
    <div class="formContent" >
        <div class="headers">Nombre de Usuario:<span id="user"></span></div>
        <div class="headers">Nombre:<span id="name"></span></div>
        <div class="headers">Apellido:<span id="lastname"></span></div>
        <div class="headers">Correo Electronico:<span id="email"></span></div>
        <div class="headers">Celular:<span id="cellphone"></span></div>
        <div class="headers">Telefono:<span id="telephone"></span></div>
        Comentarios:
        <table id="myTable">
        </table>
    </div>
</div>

<footer>
    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
<script type="text/javascript" src="../js/auth.js"></script>
</body>
</html>
