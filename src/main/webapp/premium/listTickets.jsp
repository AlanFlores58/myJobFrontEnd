<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 9:46 AM
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
        String userName = (String) sessionsa.getAttribute("username");
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
        Date date = new Date(Long.parseLong(String.format("%.0f", (Double)sessionsa.getAttribute("premiumDate"))));
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        String stringDate = calendar.get(Calendar.YEAR) + " - " + (calendar.get(Calendar.MONTH) + 1) + " - "+ calendar.get(Calendar.DAY_OF_MONTH);
        System.out.println(user);
        System.out.println(role);
    %>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script>
        $.ajax({
            url: "http://localhost:8095/api_job/private/api/v1/getTicketsByUser/<%=userName%>",
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
                    result.append('<th>Descuento</th>');
                    result.append('<th>Estado</th>');
                    result.append('<th>Fecha</th>');
                    result.append('</tr>');

                    data.data.forEach(function (item, index) {
                        class_ = "cancel";
                        if(item.state === true)
                            class_ = "accept";
                        result.append('<tr>');
                        result.append('<td class="' + class_ + '">' + item.id + '</td>');
                        result.append('<td class="' + class_ + '">' + item.discount + '</td>');
                        result.append('<td class="' + class_ + '">' + item.state + '</td>');

                        var date = new Date(item.date);
                        var dateString = item.date == null ? "" : date.getFullYear() + "-" + ((date.getMonth()+ 1) > 9 ? "" : "0" + (date.getMonth()+ 1)) + "-" + date.getDate();
                        result.append('<td class="' + class_ + '">' + dateString + '</td>');
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
            <li><a class="active" href="listTickets.jsp">Mis cupones</a></li>
            <li><a href="listServicesType.jsp">Servicios</a></li>
            <li><a href="myContracts.jsp">Mis Contratos</a></li>
            <li><a href="Contact.jsp">Contáctanos</a></li>
        </ul>
    </nav>


    <div class="login flex-item3">

        <form name="login" action="/front_job/login" id="login-form" method="post" accept-charset="utf-8">
            <input id="login-token" name="token" type="hidden" >
            <label for="username"><%=userMessage%></label>
            <input type="<%=state%>" id="username" placeholder="username" required></li>

            <div>Vence: <%=stringDate%></div>
            <img name="profileImg" class="profileImg" src="<%=image%>" alt="User image...">


            <label for="password" <%=state2%>>Password</label>
            <input type="<%=state3%>" id="password" placeholder="password" required>


            <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" style="height: 20px"><span class="content"><%=buttonLogin%></span></button>

        </form>
    </div>

</div>
<div class="container">
    <table id="myTable" class="table"></table>
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
