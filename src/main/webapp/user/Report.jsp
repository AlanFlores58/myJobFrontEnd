<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 3/3/17
  Time: 11:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/mobile.css">
</head>
<body>
<%
    HttpSession sessionsa = request.getSession(false);
    String user = (String) sessionsa.getAttribute("username");
    String token = (String) sessionsa.getAttribute("token");
    String role = (String) sessionsa.getAttribute("role");
    String image = (String) sessionsa.getAttribute("image");
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
    String contractID = request.getParameter("contractID");
    String email = request.getParameter("email");
%>
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
    <form id="report-form" class="formContent" action="/front_job/SendEmail" method="post">
        <h3>Escribe tu queja</h3>
        <input type="hidden" id="contractId" name="contractId" value="<%=contractID%>">
        <input type="hidden" id="email" name="email" value="<%=email%>">
        <div class="headers">
            <textarea id="message" name="message" placeholder="Escribe tu queja...." tabindex="5" rows="4" cols="50"></textarea>
        </div>
        <button type="button" class="btn-login" onclick="sendEmail()" >Enviar</button>
    </form>
</div>
<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="../js/auth.js"></script>
<script type="text/javascript" src="../js/CheckElements.js"></script>
<script>

    function sendEmail() {
        if(!checkCampsNull($('#message')))
            $('#report-form').submit();
    }
</script>
</body>
</html>
