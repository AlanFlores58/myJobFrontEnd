<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/contacto.css">
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
%>

<div class="flex-container navbar navbar-default navbar-fixed-top" role="navigation">

    <nav>
        <div class="flex-item-navbar" id="navHeader">
            <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
        </div>
        <ul class="navigation">
            <li><a href="newService.jsp">Nuevo servicio</a></li>
            <li><a href="listService.jsp">Actualizar servicio</a></li>
            <li><a href="confrimService.jsp">Confirmar contrato</a></li>
            <li><a href="finishService.jsp">Terminar contrato</a></li>
            <li><a class="active" href="Contact.jsp">Contáctanos</a></li>
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
    <form id="contact" action="" method="post">
        <h3>Colorlib Contact Form</h3>
        <h4>Contact us for custom quote</h4>
        <fieldset>
            <input placeholder="Your name" type="text" tabindex="1" required autofocus>
        </fieldset>
        <fieldset>
            <input placeholder="Your Email Address" type="email" tabindex="2" required>
        </fieldset>
        <fieldset>
            <input placeholder="Your Phone Number (optional)" type="tel" tabindex="3" required>
        </fieldset>
        <fieldset>
            <input placeholder="Your Web Site (optional)" type="url" tabindex="4" required>
        </fieldset>
        <fieldset>
            <textarea placeholder="Type your message here...." tabindex="5" required></textarea>
        </fieldset>
        <fieldset>
            <button name="submit" type="submit" id="contact-submit" data-submit="...Sending">Submit</button>
        </fieldset>
        <%--<p class="copyright">Designed by <a href="https://colorlib.com" target="_blank" title="Colorlib">Colorlib</a>--%>
        <%--</p>--%>
    </form>
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
            url: "http://localhost:8095/api_job/public/api/v1/login/" + $('#username').val() + "/" + $('#password').val() + "",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                if (data.status === "200") {
                    console.log(data.data.token);
                    alert("Usuario valido.");
                    $('#login-token').val(data.data.token);
                    $('#login-form').submit();
                }
                else {
                    alert("Usuario o contraseña no validos.");
                    authorizeButton.onclick = handleAuthClick;
                }
            },
            error: function (err) {
                alert(err);
            },
        });
    }

    function Logout() {
        $.get("/front_job/logout", function (data) {
            window.location.href = "/front_job/index.jsp";
        });
    }
</script>
</body>
</html>