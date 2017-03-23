<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 1/30/17
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
    <title>MyJob Group</title>
    <link rel="stylesheet" type="text/css" href="../css/mobile.css">
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
    String image = (String) sessionsa.getAttribute("image");
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
                <li><a href="newService.jsp">Nuevo servicio</a></li>
                <li><a href="listService.jsp">Actualizar servicio</a></li>
                <li><a href="confrimService.jsp">Confirmar contrato</a></li>
                <li><a href="finishService.jsp">Terminar contrato</a></li>
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


                <button type="button" class="btn-login cancel" onclick="<%=buttonLogin%>()" ><span class="content"><%=buttonLogin%></span></button>
            </form>
        </div>

    </div>


<div class="container">
    <div id=artiststhumbnail>
        <div class="frame">
            <div class="frame2">
                <img class="mySlides" src="../images/images800/employees-group.jpg">
                <img class="mySlides" src="../images/images800/workteam800.jpg">
                <img class="mySlides" src="../images/images800/trabajo-en-equipo-1.jpg">
                <img class="mySlides" src="../images/images800/familia-1.png">
                <img class="mySlides" src="../images/images800/thumbs-up.jpg">
            </div>
        </div>
    </div>

    <div>
        <img class="artiststhumbnail" id="comentariosImage">
    </div>
</div>
    <footer>

        <p>Todos los derechos reservados</p>
        <p>© 2017 Developer Company Network y colaboradores individuales</p>
        <p>Terminos y Condiciones</p>
        <p>Aviso de Privacidad</p>
    </footer>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script type="text/javascript" src="../js/auth.js"></script>
    <script>
        var myIndex = 0;
        carousel();

        function carousel() {
            var i;
            var x = document.getElementsByClassName("mySlides");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            myIndex++;
            if (myIndex > x.length) {
                myIndex = 1;
            }
            x[myIndex - 1].style.display = "block";
            setTimeout(carousel, 2000);     //change image every two minutes
        }
    </script>

</body>
</html>
