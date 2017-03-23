<%--
  Created by IntelliJ IDEA.
  User: alan.flores
  Date: 2/13/17
  Time: 3:47 PM
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
            url: "http://localhost:8095/api_job/private/api/v1/getServiceTypeByID/<%=serviceTypeID%>",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer <%=token%>');
            },
            success: function (data) {
                if (data.status === "200") {
                    console.log(data.data);
                    var name = $('#name');
                    var description = $('#description');
                    var img = $('#img');
                    name.val(data.data.name);
                    description.val(data.data.description);
                    img.attr("src", data.data.image);
                    $('#imageName').val(data.data.image);

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
            <li><a href="newServiceType.jsp">Nuevo tipo de servicio</a></li>
            <li><a class="active" href="listServicesType.jsp">Editar tipo de servicio</a></li>
            <li><a href="myContracts.jsp">Contratos</a></li>
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
    <form name="saveImage"  class="formContent" action="/front_job/saveImage" id="save-form" method="post" enctype="multipart/form-data">

        <div class="headers"><img src="" name="serviceImage" id="img" alt="Image preview..."></div>
        <div class="headers"><input type="file" id=file name="file" onchange="previewFile()"/></div>
        <div class="headers">Nombre: <input type="text" id="name" name="name" /></div>
        <div class="headers">Descripcion: <input type="text" id="description" name="description" /></div>
        <div class="headers"><input type="hidden" name="imageName" id="imageName" value=""/></div>
        <div class="headers"><input type="hidden" name="idServiceName" id="idServiceName" value="<%=serviceTypeID%>"></div>
        <button class="btn-login" onclick="saveImage()">Save</button>
    </form>
</div>
<footer>

    <p>Todos los derechos reservados</p>
    <p>© 2017 Developer Company Network y colaboradores individuales</p>
    <p>Terminos y Condiciones</p>
    <p>Aviso de Privacidad</p>
</footer>
<script type="text/javascript" src="../js/auth.js"></script>
<script>

    function previewFile(){
        var preview = document.querySelector('img[name=serviceImage]'); //selects the query named img
        var file    = document.querySelector('input[name=file]').files[0]; //sames as here
        var reader  = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
        }

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
        } else {
            preview.src = "";
        }
    }

    previewFile();

    function saveImage(){
        $('#save-form').submit();
    }

    previewFile();  //calls the function named previewFile()

</script>
</body>
</html>