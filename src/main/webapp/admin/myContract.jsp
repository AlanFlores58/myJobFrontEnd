<%--
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
        String contractID = request.getParameter("contractID");
        String serviceTypeID = request.getParameter("serviceTypeID");
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
    %>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script>
        $.ajax({
            url: "http://localhost:8095/api_job/private/api/v1/getContractByID/<%=contractID%>",
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
                    var userService= $("#userService");
                    var user = $("#user");
                    var servicePrice = $("#servicePrice");
                    var description = $("#description");
                    var price = $("#price");
                    var cupons = $("#cupons");
                    var priceWithDescount = $("#priceWithDescount");
                    var profit = $("#profit");
                    var buttonToPay = $("#pay-form");
                    var dateBegins = $("#dateBegins");
                    var date = new Date(data.data.dateStart);
                    dateBegins.append(date.getFullYear() + "-" + ((date.getMonth()+ 1) > 9 ? "" : "0" + (date.getMonth()+ 1)) + "-" + date.getDate());

                    var dateFinish = $("#dateFinish");
                    date = new Date(data.data.dateFinish);
                    dateFinish.append(date.getFullYear() + "-" + ((date.getMonth()+ 1) > 9 ? "" : "0" + (date.getMonth()+ 1)) + "-" + date.getDate());


                    serviceName.append(data.data.service.name);
                    userService.append(data.data.service.userService.username);
                    user.append(data.data.userContract.username);
                    servicePrice.append(data.data.service.price);
                    price.append(data.data.price);
                    description.append(data.data.description);

                    $( "#confirmed" ).prop( "checked", data.data.confirmed );
                    $( "#finished" ).prop( "checked", data.data.finish );
                    $( "#canceled" ).prop( "checked", data.data.cancelled );
                    $( "#admin" ).prop( "checked", data.data.confirmAdmin );
                    $("#payed").prop( "checked", data.data.payed );
                    var cupon = data.data.cupon;

                    var priceVal = data.data.price;

                    if(cupon === null) {
                        cupons.append("N/A");
                        discount = 0;
                    }
                    else{
                        cupons.append('id=' + cupon.id + '/' + cupon.discount + '%');
                        discount = cupon.discount;
                    }


                    priceWithDescount.append((priceVal - (priceVal * discount/ 100)));
                    profit.append((priceVal - (priceVal * discount/ 100)) * .1)

                    if(!data.data.cancelled && !data.data.confirmAdmin) {
                        buttonToPay.append('<button type="button" class="btn-confirm btn-login" onclick="confirm()" ><span class="content">Cornfirmar</span></button>');
                        buttonToPay.append('<button type="button" class="btn-cancel btn-login cancel" onclick="cancel()" ><span class="content">Cancelar</span></button>');
                    }
                }
                else {
                    alert(data.status);
                }
            },
            error: function (err) {
                alert(err);
            }
        });

        function cancel() {
            $.ajax({
                url: "http://localhost:8095/api_job/private/api/v1/cancelContract/<%=contractID%>",
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
        function confirm() {
            $.ajax({
                url: "http://localhost:8095/api_job/private/api/v1/finishContractByAdmin/<%=contractID%>",
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
            <li><a href="listServicesType.jsp">Editar tipo de servicio</a></li>
            <li><a class="active" href="myContracts.jsp">Contratos</a></li>
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
<form name="login" class="formContent" action="myContracts.jsp" id="pay-form" method="post" accept-charset="utf-8">
    <div class="headers">Nombre del Servicio: <span id="serviceName"></span></div>
    <div class="headers">Prestador de servicio: <span id="userService"></span></div>
    <div class="headers">Usuario: <span id="user"></span></div>
    <div class="headers">Descripcion: <span id="description"></span></div>
    <div class="headers">Precio del servicio: <span id="servicePrice"></span></div>
    <div class="headers">Precio acordado: <span id="price"></span></div>
    <div class="headers">Cupon: <span id="cupons"></span></div>
    <div class="headers">Fecha de inicio: <span id="dateBegins"></span></div>
    <div class="headers">Fecha final: <span id="dateFinish"></span></div>
    <div class="headers">Precio con descuento: <span id="priceWithDescount"></span></div>
    <div class="headers">Ganancia MyJobGroup(10%): <span id="profit"></span></div>
    <div class="headers">Pagado: <input type="checkbox" disabled="true" name="payed" id="payed"></div>
    <div class="headers">Terminado por admin: <input type="checkbox" disabled="true" name="admin" id="admin"></div>
    <div class="headers">Cancelado: <input type="checkbox" disabled="true" name="admin" id="canceled"></div>
    <div class="headers">Confirmado por vendedor: <input type="checkbox" disabled="true" name="admin" id="confirmed"></div>
    <div class="headers">Terminado por vendedor: <input type="checkbox" disabled="true" name="admin" id="finished"></div>
</form>
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
