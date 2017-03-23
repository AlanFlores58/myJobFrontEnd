<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/mobile.css">
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
    String image = (String) sessionsa.getAttribute("image");
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
        <div class="cover">
            <div class="flex-item-navbar" id="navHeader">
                <a href="index.jsp"><img class="flex-item-logo" id="logo"></a>
            </div>
        </div>
        <ul class="navigation">
            <li><a href="listTickets.jsp">Mis cupones</a></li>
            <li><a href="listServicesType.jsp">Servicios</a></li>
            <li><a href="myContracts.jsp">Mis Contratos</a></li>
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

            <div class="getPremiunVersion">
                <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" ><span class="content"><%=buttonLogin%></span></button>
                <button type="button" class="btn-login" onclick="getPremium()"><span class="content">Version Premium</span></button>
            </div>
        </form>
    </div>

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
                href="mailto:myjob.group.mexico@gmail.com?Subject=Gracias por contactarnos !!" target="_top">myjob.group.mexico@gmail.com</a></span>
        </div>
        <div class="headers"><b>Llámanos:</b> <span>(044) - 33 1559 9255</span></div>
        <div class="headers"><b>Visítanos:</b> <span> Manuel Rivera Cambas 2869, Jardines de la Paz.</span></div>

    </form>

    <div class="formContent map" id="map"></div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="../js/auth.js"></script>
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