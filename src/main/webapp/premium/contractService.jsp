<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %><%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/10/17
  Time: 9:41 AM
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
            url: "http://localhost:8095/api_job/private/api/v1/getServicesById/<%=serviceID%>",
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

                    serviceName.append("" + data.data.name + "");
                    userService.append("" + data.data.userService.username + "");
                    user.append("<%=userName%>");
                    servicePrice.append("" + data.data.price + "");

                    //getCupons
                    $.ajax({
                        url: "http://localhost:8095/api_job/private/api/v1/getTicketsByUserNotUsed/<%=userName%>",
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
                        },
                        success: function (data) {
                            if (data.status === "200") {
                                console.log(data.data);
                                var result = $('#cupons');
                                result.html('');

                                result.append('<option value=""></option>')
                                data.data.forEach(function (item, index) {
                                    result.append('<option value="' + item.id + '">id=' + item.id + '/' + item.discount + '%</option>')
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

            <div>Vence: <%=stringDate%></div>
            <img name="profileImg" class="profileImg" src="<%=image%>" alt="User image...">


            <label for="password" <%=state2%>>Password</label>
            <input type="<%=state3%>" id="password" placeholder="password" required>


            <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" style="height: 20px"><span class="content"><%=buttonLogin%></span></button>

        </form>
    </div>

</div>
<div class="container">
    <form name="save" class="formContent" action="myContracts.jsp" id="save-form" method="get">
        <div class="headers">Nombre del Servicio: <span id="serviceName"></span></div>
        <div class="headers">Prestador de servicio: <span id="userService"></span></div>
        <div class="headers">Usuario: <span id="user"></span></div>
        <div class="headers">Descripcion: <input type="text" id="description"></div>
        <div class="headers">Precio del servicio: <span id="servicePrice"></span></div>
        <div class="headers">Precio acordado: <input type="text" id="price" onchange="calculatePrice()"></div>
        <div class="headers">Cupon: <select id="cupons" onchange="calculatePrice()"></select></div>
        <div class="headers">Fecha de inicio: <input type="date" id="dateBegins"></div>
        <div class="headers">Fecha final: <input type="date" id="dateFinish"></div>
        <div class="headers">Precio con descuento: <span id="priceWithDescount">0</span></div>
        <button type="button" class="btn-save btn-login" onclick="Save()"><span class="content">Guardar</span></button>
    </form>
</div>
<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>

<script>
    function Save() {
        var authorizeButton = $('.btn-save');

        var discount = $( "#cupons option:selected" ).text();
        if(discount === null || discount === undefined || discount === "")
            discount = 0;
        else{
            discount = discount.split("/")[0];
            discount = discount.split("=")[1];
        }


        $.ajax({
            url: "http://localhost:8095/api_job/private/api/v1/saveNewContract/<%=serviceID%>/" + $('#description').val() + "/" + $('#price').val() + "/<%=userName%>/" + $('#dateBegins').val() + "/" + $('#dateFinish').val() + "/" + discount,
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

    function calculatePrice(){
        var price = $('#price').val();
        if(price === null || price === undefined || price === "")
            price = 0;

        console.log(price);
        var discount = $( "#cupons option:selected" ).text();
        if(discount === null || discount === undefined || discount === "")
            discount = 0;
        else
            discount = discount.split("/")[1].substring(0, discount.split("/")[1].length - 1);
        console.log(discount);

        var serviceName = $("#priceWithDescount");
        serviceName.html('');

        serviceName.append(price - (price * discount/ 100));
    }
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
