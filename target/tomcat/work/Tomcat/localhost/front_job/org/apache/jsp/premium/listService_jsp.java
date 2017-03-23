/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-03-21 23:51:24 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.premium;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

public final class listService_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');
      out.write('\n');
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
        String type = request.getParameter("type");
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
    
      out.write("\n");
      out.write("\n");
      out.write("    <script type=\"text/javascript\" src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js\"></script>\n");
      out.write("    <script>\n");
      out.write("        $.ajax({\n");
      out.write("            url: \"http://localhost:8095/api_job/private/api/v1/getServicesByType/");
      out.print(type);
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
      out.write("                    var result = $('#myTable');\n");
      out.write("                    result.html('');\n");
      out.write("                    result.append('<tr>');\n");
      out.write("                    result.append('<th>Nombre</th>');\n");
      out.write("                    result.append('<th>Descripcion</th>');\n");
      out.write("                    result.append('<th>Precio</th>');\n");
      out.write("                    result.append('<th>Tipo</th>');\n");
      out.write("                    result.append('<th>Prestador de servicio</th>');\n");
      out.write("                    result.append('</tr>');\n");
      out.write("\n");
      out.write("                    data.data.forEach(function (item, index) {\n");
      out.write("                        result.append('<tr>');\n");
      out.write("                        result.append('<td>' + item.name + '</td>');\n");
      out.write("                        result.append('<td>' + item.description + '</td>');\n");
      out.write("                        result.append('<td>' + item.price + '</td>');\n");
      out.write("                        result.append('<td>' + item.serviceType.name + '</td>');\n");
      out.write("                        result.append('<td class=\"button imageTable\"><a href=\"userInformation.jsp?requestUserId=' + item.userService.id + '\">' + item.userService.username + '</a></td>');\n");
      out.write("                        result.append('<td class=\"button imageTable\"><a href=\"contractService.jsp?serviceID=' + item.id + '\">Contratar</a></td>');\n");
      out.write("                        result.append('</tr>');\n");
      out.write("                    });\n");
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
      out.write("            <div>Vence: ");
      out.print(stringDate);
      out.write("</div>\n");
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
      out.write("            <button type=\"button\" class=\"btn-login cancel\" onclick=\"");
      out.print(buttonLogin);
      out.write("()\" style=\"height: 20px\"><span class=\"content\">");
      out.print(buttonLogin);
      out.write("</span></button>\n");
      out.write("        </form>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("<div class=\"container\">\n");
      out.write("    <table id=\"myTable\"></table>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<footer>\n");
      out.write("    <p>Todos los derechos reservados</p>\n");
      out.write("    <p>© 2017 Developer Company Network y colaboradores individuales</p>\n");
      out.write("    <p>Terminos y Condiciones</p>\n");
      out.write("    <p>Aviso de Privacidad</p>\n");
      out.write("</footer>\n");
      out.write("\n");
      out.write("<script>\n");
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
