<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %><%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 2:34 PM
  To change this template use File | Settings | File Templates.

  por usuario
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
        String contractID = request.getParameter("contractID");
        if (token != null) {
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
            url: "http://localhost:8080/api_job/private/api/v1/getContractByUserAndID/<%=userName%>/<%=contractID%>",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
            },
            success: function (data) {
                if (data.status === "200") {
                    console.log(data.data);
                    var serviceName = $("#serviceName");
                    var userService = $("#userService");
                    var user = $("#user");
                    var servicePrice = $("#servicePrice");
                    var description = $("#description");
                    var price = $("#price");
                    var cupons = $("#cupons");
                    var priceWithDescount = $("#priceWithDescount");
                    var buttonToPay = $("#pay-form");
                    var dateBegins = $("#dateBegins");
                    var date = new Date(data.data.dateStart);
                    dateBegins.append(date.getFullYear() + "-" + ((date.getMonth() + 1) > 9 ? "" : "0" + (date.getMonth() + 1)) + "-" + date.getDate());

                    var dateFinish = $("#dateFinish");
                    date = new Date(data.data.dateFinish);
                    dateFinish.append(date.getFullYear() + "-" + ((date.getMonth() + 1) > 9 ? "" : "0" + (date.getMonth() + 1)) + "-" + date.getDate());


                    serviceName.append(data.data.service.name);
                    userService.append(data.data.service.userService.username);
                    $("#userServiceText").val(data.data.service.userService.username);
                    user.append("<%=userName%>");
                    servicePrice.append(data.data.service.price);
                    price.append(data.data.price);
                    description.append(data.data.description);

                    $("#confirmed").prop("checked", data.data.confirmed);
                    $("#finished").prop("checked", data.data.finish);
                    $("#canceled").prop("checked", data.data.cancelled);
                    $("#admin").prop("checked", data.data.confirmAdmin);
                    $("#payed").prop("checked", data.data.payed);
                    var cupon = data.data.cupon;

                    var priceVal = data.data.price;

                    if (cupon === null) {
                        cupons.append("N/A");
                        discount = 0;
                    }
                    else {
                        cupons.append('id=' + cupon.id + '/' + cupon.discount + '%');
                        discount = cupon.discount;
                    }


                    priceWithDescount.append((priceVal - (priceVal * discount / 100)));

                    if (!data.data.payed)
                        buttonToPay.append('<button type="button" class="btn-pay btn-login" onclick="pay()" ><span class="content">Pagar</span></button>');


                    $.ajax({
                        url: "http://localhost:8080/api_job/private/api/v1/getCommentsByUserService/" + data.data.service.userService.username,
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


        function pay() {
            var tarjeta = prompt("Numero de tarjeta", "");

            if (tarjeta != null && tarjeta.trim() != "") {
                var numeroSecreto = prompt("Numero de secreto", "");
                if (numeroSecreto != null && numeroSecreto.trim() != "") {
                    $.ajax({
                        url: "http://localhost:8080/api_job/private/api/v1/payContract/<%=contractID%>",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
                        },
                        success: function (data) {
                            if (data.status === "200") {
                                console.log(data.data);
                                alert("Pagado!");
                                $("#pay-form").submit();
                            }
                            else {
                                alert(data.status);
                            }
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            }
        }
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
            <input id="login-token" name="token" type="hidden">
            <label for="username"><%=userMessage%>
            </label>
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
    <form name="login" class="formContent" action="myContracts.jsp" id="pay-form" method="post" accept-charset="utf-8">
        <div class="headers">Nombre del Servicio: <span id="serviceName"></span></div>
        <div class="headers">Prestador de servicio: <span id="userService"></span></div>
        <input type="hidden" id="userServiceText">
        <div class="headers">Usuario: <span id="user"></span></div>
        <div class="headers">Descripcion: <span id="description"></span></div>
        <div class="headers">Precio del servicio: <span id="servicePrice"></span></div>
        <div class="headers">Precio acordado: <span id="price"></span></div>
        <div class="headers">Cupon: <span id="cupons"></span></div>
        <div class="headers">Fecha de inicio: <span id="dateBegins"></span></div>
        <div class="headers">Fecha final: <span id="dateFinish"></span></div>
        <div class="headers">Precio con descuento: <span id="priceWithDescount"></span></div>
        <div class="headers">Pagado: <input type="checkbox" disabled="true" name="payed" id="payed"></div>
        <div class="headers">Terminado por admin: <input type="checkbox" disabled="true" name="admin" id="admin"></div>
        <div class="headers">Cancelado: <input type="checkbox" disabled="true" name="admin" id="canceled"></div>
        <div class="headers">Confirmado por vendedor: <input type="checkbox" disabled="true" name="admin" id="confirmed"></div>
        <div class="headers">Terminado por vendedor: <input type="checkbox" disabled="true" name="admin" id="finished">
        </div>
        Comentarios:
        <table id="myTable">

        </table>
        <div>
            Crear Comentario:
            <div class="headers"> <textarea id="comment" rows="4" cols="50"></textarea></div>
            <input type="button" class="button" onclick="saveComment()" value="Guardar Comentario">
        </div>
    </form>
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
    function saveComment() {

        if(!checkCampsNull($('#comment')))
            $.ajax({
                url: "http://localhost:8080/api_job/private/api/v1/createComment/" + $('#comment').val() + "/<%=userName%>/" + $('#userServiceText').val(),
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
                },
                success: function (data) {
                    if (data.status === "200") {
                        alert("Nuevo comentario ");
                        window.location.reload();
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
</script>
</body>
</html>
