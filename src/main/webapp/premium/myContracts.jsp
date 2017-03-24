<%@ page import="java.util.Date" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 12:35 PM
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
        String serviceID = request.getParameter("serviceID");
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
            url: "http://localhost:8080/api_job/private/api/v1/getContractsByUser/<%=userName%>",
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
                    result.append('<th>Precio final</th>');
                    result.append('<th>Pagado</th>');
                    result.append('<th>Terminado por admin</th>');
                    result.append('<th>Cancelado</th>');
                    result.append('<th>Confirmado por vendedor</th>');
                    result.append('<th>Terminado por vendedor</th>');
                    result.append('</tr>');
                    data.data.forEach(function (item, index) {
                        result.append('<tr>');
                        result.append('<td class="button imageTable"><a href="myContract.jsp?contractID=' + item.id + '">' + item.id + '</a></td>');
                        result.append('<td>' + item.service.name + '</td>');
                        result.append('<td>' + item.description + '</td>');
                        var price = item.price;
                        var discount = item.cupon;
                        if(discount == null)
                            discount = 0;
                        else{
                            discount = item.cupon.discount;
                        }
                        console.log((price * discount/ 100));
                        result.append('<td>' + (price - (price * discount/ 100)) + '</td>');
                        result.append('<td><input type="checkbox" disabled="true" name="payed" id="payed" ' + (item.payed === true ? 'checked' : '') + '></td>');
                        result.append('<td><input type="checkbox" disabled="true" name="admin" id="admin" ' + (item.confirmAdmin === true ? 'checked' : '') + '></td>');
                        result.append('<td><input type="checkbox" disabled="true" name="canceled" id="canceled" ' + (item.cancelled === true ? 'checked' : '') + '></td>');
                        result.append('<td><input type="checkbox" disabled="true" name="confirmed" id="confirmed" ' + (item.confirmed === true ? 'checked' : '') + '></td>');
                        result.append('<td><input type="checkbox" disabled="true" name="finished" id="finished" ' + (item.finish === true ? 'checked' : '') + '></td>');
                        result.append('<td class="button imageTable"><a href="Report.jsp?contractID=' + item.id + '&&email=' + item.service.userService.email + '">Denunciar</a></td>');
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
            <li><a href="listTickets.jsp">Mis cupones</a></li>
            <li><a href="listServicesType.jsp">Servicios</a></li>
            <li><a class="active" href="myContracts.jsp">Mis Contratos</a></li>
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
<div  class="container">
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
<script>
    function searchId() {
        window.location.href = "myContract.jsp?contractID=" + $('#contract').val();
    }
</script>
</body>
</html>
