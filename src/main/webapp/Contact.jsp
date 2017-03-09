<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="css/mobile.css">
    <%--<style type="text/css">html, body { height: 100%; margin: 0; padding: 0; }--%>
    <%--#map { height: 100%; }--%>
    <%--</style>--%>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPiMd_wot2cZ0axHiWPubGUs4iQBIxQ50&callback=initMap">
    </script>
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
    if (token != null) {
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
    <form id="contact" class="formContent" action="" method="post">
        <h2>Contáctanos </h2>
        <p>Gracias por interesarte en MyJob. En MyJob valoramos mucho tus opiniones y nos gustaría ofrecerte el mejor
            servicio y ponerte en contacto con nosotros
            para proporcionarte la información que necesites.
            Queremos escuchar tus ideas, comentarios o dudas. Queremos mejorar MyJob para prestarte un mejor
            servicio.</p>


        <div class="headers">Director General: <span>Gustavo Adolfo Reynoso Díaz</span></div>
        <div class="headers"><b>Envíanos un correo:</b> <span><a
                href="mailto:gustavo.reynoso@myjob.com?Subject=Gracias por contactarnos !!" target="_top">gustavo.reynoso@myjob.com</a></span>
        </div>
        <div class="headers"><b>Llámanos:</b> <span>(044) - 33 1559 9255</span></div>
        <div class="headers"><b>Visítanos:</b> <span> Manuel Rivera Cambas 2869, Jardines de la Paz.</span></div>

    </form>

    <div class="formContent map" id="map"></div>
</div>


<script type="text/javascript">

    var map;
    function initMap() {
        var location = {lat: 20.645925, lng: -103.300351};
        map = new google.maps.Map(document.getElementById('map'), {
            center: location,
            zoom: 16,
        });
        var marker = new google.maps.Marker({
            position: location,
            map: map
        });
    }

</script>


<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
</body>
</html>