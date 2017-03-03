<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="css/contacto.css">
    <link rel="stylesheet" type="text/css" href="css/mobile.css">
</head>
<body>
<%
    HttpSession sessionsa = request.getSession(false);
    String user = (String) sessionsa.getAttribute("username");
    String token = (String) sessionsa.getAttribute("token");
    String role = (String) sessionsa.getAttribute("role");
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
            <li><a href="Register.jsp">Regístrate</a></li>
            <li><a class="active" href="Contact.jsp">Contáctanos</a></li>
        </ul>
    </nav>

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
            <button name="submit" type="button" id="contact-submit" data-submit="...Sending">Submit</button>
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
</body>
</html>