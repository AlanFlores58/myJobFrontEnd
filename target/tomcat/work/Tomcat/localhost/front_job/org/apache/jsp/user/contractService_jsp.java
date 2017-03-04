/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-03-04 20:58:29 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class contractService_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\" name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <title>MyJob Group</title>\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"../css/mobile.css\">\n");
      out.write("    ");

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
        System.out.println(user);
        System.out.println(role);
    
      out.write("\n");
      out.write("    <script type=\"text/javascript\" src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js\"></script>\n");
      out.write("    <script>\n");
      out.write("        $.ajax({\n");
      out.write("            url: \"http://localhost:8095/api_job/private/api/v1/getServicesById/");
      out.print(serviceID);
      out.write("\",\n");
      out.write("            type: \"GET\",\n");
      out.write("            contentType: \"application/json; charset=utf-8\",\n");
      out.write("            dataType: \"json\",\n");
      out.write("            beforeSend: function (xhr) {\n");
      out.write("                xhr.setRequestHeader('Authorization', 'bearer ");
      out.print(token);
      out.write("');\n");
      out.write("            },\n");
      out.write("            success: function (data) {\n");
      out.write("                if (data.status === \"200\") {\n");
      out.write("                    console.log(data.data);\n");
      out.write("                    var serviceName = $(\"#serviceName\");\n");
      out.write("                    var userService= $(\"#userService\");\n");
      out.write("                    var user = $(\"#user\");\n");
      out.write("                    var servicePrice = $(\"#servicePrice\");\n");
      out.write("\n");
      out.write("                    serviceName.append(\"\" + data.data.name + \"\");\n");
      out.write("                    userService.append(\"\" + data.data.userService.username + \"\");\n");
      out.write("                    user.append(\"");
      out.print(userName);
      out.write("\");\n");
      out.write("                    servicePrice.append(\"\" + data.data.price + \"\");\n");
      out.write("\n");
      out.write("                    //getCupons\n");
      out.write("                    $.ajax({\n");
      out.write("                        url: \"http://localhost:8095/api_job/private/api/v1/getTicketsByUserNotUsed/");
      out.print(userName);
      out.write("\",\n");
      out.write("                        type: \"GET\",\n");
      out.write("                        contentType: \"application/json; charset=utf-8\",\n");
      out.write("                        dataType: \"json\",\n");
      out.write("                        beforeSend: function (xhr) {\n");
      out.write("                            xhr.setRequestHeader('Authorization', 'bearer ");
      out.print(token);
      out.write("');\n");
      out.write("                        },\n");
      out.write("                        success: function (data) {\n");
      out.write("                            if (data.status === \"200\") {\n");
      out.write("                                console.log(data.data);\n");
      out.write("                                var result = $('#cupons');\n");
      out.write("                                result.html('');\n");
      out.write("\n");
      out.write("                                result.append('<option value=\"\"></option>')\n");
      out.write("                                data.data.forEach(function (item, index) {\n");
      out.write("                                    result.append('<option value=\"' + item.id + '\">id=' + item.id + '/' + item.discount + '%</option>')\n");
      out.write("                                });\n");
      out.write("                            }\n");
      out.write("                            else {\n");
      out.write("                                alert(data.status);\n");
      out.write("                            }\n");
      out.write("                        },\n");
      out.write("                        error: function (err) {\n");
      out.write("                            alert(err);\n");
      out.write("                        }\n");
      out.write("                    });\n");
      out.write("\n");
      out.write("                }\n");
      out.write("                else {\n");
      out.write("                    alert(data.status);\n");
      out.write("                }\n");
      out.write("            },\n");
      out.write("            error: function (err) {\n");
      out.write("                alert(err);\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("    </script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<div class=\"flex-container navbar navbar-default navbar-fixed-top\" role=\"navigation\">\n");
      out.write("\n");
      out.write("    <nav>\n");
      out.write("        <div class=\"cover\">\n");
      out.write("            <div class=\"flex-item-navbar\" id=\"navHeader\">\n");
      out.write("                <a href=\"index.jsp\"><img class=\"flex-item-logo\" id=\"logo\"></a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <ul class=\"navigation\">\n");
      out.write("            <li><a href=\"listTickets.jsp\">Mis cupones</a></li>\n");
      out.write("            <li><a class=\"active\" href=\"listServicesType.jsp\">Servicios</a></li>\n");
      out.write("            <li><a href=\"myContracts.jsp\">Mis Contratos</a></li>\n");
      out.write("            <li><a href=\"Contact.jsp\">Contáctanos</a></li>\n");
      out.write("        </ul>\n");
      out.write("    </nav>\n");
      out.write("\n");
      out.write("\n");
      out.write("    <div class=\"login flex-item3\">\n");
      out.write("\n");
      out.write("        <form name=\"login\" action=\"/front_job/login\" id=\"login-form\" method=\"post\" accept-charset=\"utf-8\">\n");
      out.write("            <input id=\"login-token\" name=\"token\" type=\"hidden\" >\n");
      out.write("            <label for=\"username\">");
      out.print(userMessage);
      out.write("</label>\n");
      out.write("            <input type=\"");
      out.print(state);
      out.write("\" id=\"username\" placeholder=\"username\" required></li>\n");
      out.write("\n");
      out.write("            <img name=\"profileImg\" class=\"profileImg\" src=\"");
      out.print(image);
      out.write("\" alt=\"User image...\">\n");
      out.write("\n");
      out.write("\n");
      out.write("            <label for=\"password\" ");
      out.print(state2);
      out.write(">Password</label>\n");
      out.write("            <input type=\"");
      out.print(state3);
      out.write("\" id=\"password\" placeholder=\"password\" required>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"getPremiunVersion\">\n");
      out.write("                <button type=\"button\" class=\"btn-login cancel\" onclick=\"");
      out.print(buttonLogin);
      out.write("()\" ><span class=\"content\">");
      out.print(buttonLogin);
      out.write("</span></button>\n");
      out.write("                <button type=\"button\" class=\"btn-login\" onclick=\"getPremium()\"><span class=\"content\">Version Premium</span></button>\n");
      out.write("            </div>\n");
      out.write("        </form>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("<div class=\"container\">\n");
      out.write("    <form name=\"save\" class=\"formContent\" action=\"myContracts.jsp\" id=\"save-form\" method=\"get\">\n");
      out.write("        <div class=\"headers\">Nombre del Servicio: <span id=\"serviceName\"></span></div>\n");
      out.write("        <div class=\"headers\">Prestador de servicio: <span id=\"userService\"></span></div>\n");
      out.write("        <div class=\"headers\">Usuario: <span id=\"user\"></span></div>\n");
      out.write("        <div class=\"headers\">Descripcion: <input type=\"text\" id=\"description\"></div>\n");
      out.write("        <div class=\"headers\">Precio del servicio: <span id=\"servicePrice\"></span></div>\n");
      out.write("        <div class=\"headers\">Precio acordado: <input type=\"text\" id=\"price\" onchange=\"calculatePrice()\"></div>\n");
      out.write("        <div class=\"headers\">Cupon: <select id=\"cupons\" onchange=\"calculatePrice()\"></select></div>\n");
      out.write("        <div class=\"headers\">Fecha de inicio: <input type=\"date\" id=\"dateBegins\"></div>\n");
      out.write("        <div class=\"headers\">Fecha final: <input type=\"date\" id=\"dateFinish\"></div>\n");
      out.write("        <div class=\"headers\">Precio con descuento: <span id=\"priceWithDescount\">0</span></div>\n");
      out.write("        <button type=\"button\" class=\"btn-save btn-login\" onclick=\"Save()\"><span class=\"content\">Guardar</span></button>\n");
      out.write("    </form>\n");
      out.write("</div>\n");
      out.write("<footer>\n");
      out.write("\n");
      out.write("    <p>Todos los derechos reservados</p>\n");
      out.write("    <p>© 2017 Developer Company Network y colaboradores individuales</p>\n");
      out.write("    <p>Terminos y Condiciones</p>\n");
      out.write("    <p>Aviso de Privacidad</p>\n");
      out.write("</footer>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("    function Save() {\n");
      out.write("        var authorizeButton = $('.btn-save');\n");
      out.write("\n");
      out.write("        var discount = $( \"#cupons option:selected\" ).text();\n");
      out.write("        if(discount === null || discount === undefined || discount === \"\")\n");
      out.write("            discount = 0;\n");
      out.write("        else{\n");
      out.write("            discount = discount.split(\"/\")[0];\n");
      out.write("            discount = discount.split(\"=\")[1];\n");
      out.write("        }\n");
      out.write("\n");
      out.write("\n");
      out.write("        $.ajax({\n");
      out.write("            url: \"http://localhost:8095/api_job/private/api/v1/saveNewContract/");
      out.print(serviceID);
      out.write("/\" + $('#description').val() + \"/\" + $('#price').val() + \"/");
      out.print(userName);
      out.write("/\" + $('#dateBegins').val() + \"/\" + $('#dateFinish').val() + \"/\" + discount,\n");
      out.write("            type: \"POST\",\n");
      out.write("            contentType: \"application/json; charset=utf-8\",\n");
      out.write("            dataType: \"json\",\n");
      out.write("            beforeSend: function (xhr) {\n");
      out.write("                xhr.setRequestHeader('Authorization', 'bearer ");
      out.print(token);
      out.write("');\n");
      out.write("            },\n");
      out.write("            success: function (data) {\n");
      out.write("                if (data.status === \"200\") {\n");
      out.write("                    alert(\"Nuevo servicio almacenado: \" + data.data.name);\n");
      out.write("                    $('#save-form').submit();\n");
      out.write("                }\n");
      out.write("                else {\n");
      out.write("                    alert(\"Usuario o contraseña no validos.\");\n");
      out.write("                }\n");
      out.write("            },\n");
      out.write("            error: function (err) {\n");
      out.write("                alert(err);\n");
      out.write("            },\n");
      out.write("        });\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    function calculatePrice(){\n");
      out.write("        var price = $('#price').val();\n");
      out.write("        if(price === null || price === undefined || price === \"\")\n");
      out.write("            price = 0;\n");
      out.write("\n");
      out.write("        console.log(price);\n");
      out.write("        var discount = $( \"#cupons option:selected\" ).text();\n");
      out.write("        if(discount === null || discount === undefined || discount === \"\")\n");
      out.write("            discount = 0;\n");
      out.write("        else\n");
      out.write("            discount = discount.split(\"/\")[1].substring(0, discount.split(\"/\")[1].length - 1);\n");
      out.write("        console.log(discount);\n");
      out.write("\n");
      out.write("        var serviceName = $(\"#priceWithDescount\");\n");
      out.write("        serviceName.html('');\n");
      out.write("\n");
      out.write("        serviceName.append(price - (price * discount/ 100));\n");
      out.write("    }\n");
      out.write("    function Login() {\n");
      out.write("        var authorizeButton = $('.btn-login');\n");
      out.write("        $.ajax({\n");
      out.write("            url : \"http://localhost:8095/api_job/public/api/v1/login/\" + $('#username').val() + \"/\" + $('#password').val() + \"\",\n");
      out.write("            type: \"GET\",\n");
      out.write("            contentType: \"application/json; charset=utf-8\",\n");
      out.write("            dataType   : \"json\",\n");
      out.write("            success    : function(data){\n");
      out.write("                if(data.status === \"200\"){\n");
      out.write("                    console.log(data.data.token);\n");
      out.write("                    alert(\"Usuario valido.\");\n");
      out.write("                    $('#login-token').val(data.data.token);\n");
      out.write("                    $('#login-form').submit();\n");
      out.write("                }\n");
      out.write("                else{\n");
      out.write("                    alert(\"Usuario o contraseña no validos.\");\n");
      out.write("                    authorizeButton.onclick = handleAuthClick;\n");
      out.write("                }\n");
      out.write("            },\n");
      out.write("            error: function(err){\n");
      out.write("                alert(err);\n");
      out.write("            },\n");
      out.write("        });\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    function Logout() {\n");
      out.write("        $.get(\"/front_job/logout\", function(data) {\n");
      out.write("            window.location.href = \"/front_job/index.jsp\";\n");
      out.write("        });\n");
      out.write("    }\n");
      out.write("    function getPremium() {\n");
      out.write("        var tarjeta = prompt(\"Numero de tarjeta\", \"\");\n");
      out.write("\n");
      out.write("        if (tarjeta != null && tarjeta.trim() != \"\") {\n");
      out.write("            var numeroSecreto = prompt(\"Numero de secreto\", \"\");\n");
      out.write("            if (numeroSecreto != null && numeroSecreto.trim() != \"\") {\n");
      out.write("                $.post(\"/front_job/getPremium\", function (data) {\n");
      out.write("                    window.location.href = \"/front_job/premium/index.jsp\";\n");
      out.write("                });\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("\n");
      out.write("    }\n");
      out.write("</script>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
