/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-03-03 14:57:46 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Register_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>MyJob Group</title>\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/mobile.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");

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

      out.write("\n");
      out.write("\n");
      out.write("<div class=\"flex-container navbar navbar-default navbar-fixed-top\" role=\"navigation\">\n");
      out.write("\n");
      out.write("    <nav>\n");
      out.write("        <div class=\"cover\">\n");
      out.write("            <div class=\"flex-item-navbar\" id=\"navHeader\">\n");
      out.write("                <a href=\"index.jsp\"><img class=\"flex-item-logo\" id=\"logo\"></a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <ul class=\"navigation\">\n");
      out.write("            <li><a class=\"active\" href=\"Register.jsp\">Regístrate</a></li>\n");
      out.write("            <li><a href=\"Contact.jsp\">Contáctanos</a></li>\n");
      out.write("        </ul>\n");
      out.write("    </nav>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("<div class=\"container\">\n");
      out.write("    <form id=\"sigup-form\" class=\"formContent\" action=\"/front_job/saveImageUser\" method=\"post\" enctype=\"multipart/form-data\">\n");
      out.write("\n");
      out.write("        <h1>Registro</h1>\n");
      out.write("\n");
      out.write("        <div class=\"headers\"><img name=\"profileImg\" src=\"\" height=\"200\" alt=\"Image preview...\"></div>\n");
      out.write("        <div class=\"headers\"><input type=\"file\" name=\"file\" onchange=\"previewFile()\"/></div>\n");
      out.write("\n");
      out.write("        <fieldset>\n");
      out.write("            <legend><span class=\"number\"></span>Información Básica</legend>\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label for=\"name\">Nombre:</label>\n");
      out.write("                <input type=\"text\" id=\"name\" name=\"name\">\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label for=\"lastname\">Apellido:</label>\n");
      out.write("                <input type=\"text\" id=\"lastname\" name=\"lastname\">\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label for=\"mail\">Email:</label>\n");
      out.write("                <input type=\"email\" id=\"mail\" name=\"mail\">\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label for=\"name\">Nombre de Usuario:</label>\n");
      out.write("                <input type=\"text\" id=\"username2\" name=\"username\">\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label for=\"password\">Contraseña:</label>\n");
      out.write("                <input type=\"password\" id=\"password\" name=\"password\">\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label>Sexo:</label>\n");
      out.write("                <input type=\"radio\" id=\"male\" value=\"male\" name=\"sex\" checked=\"checked\"><label for=\"male\" class=\"light\">Hombre</label>\n");
      out.write("                <input type=\"radio\" id=\"female\" value=\"female\" name=\"sex\"><label for=\"female\" class=\"light\">Mujer</label>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"headers\">\n");
      out.write("                <label>Tipo:</label>\n");
      out.write("                <input type=\"radio\" id=\"buy\" value=\"comprar\" name=\"type\" checked=\"checked\"><label for=\"buy\" class=\"light\">Comprar</label>\n");
      out.write("                <input type=\"radio\" id=\"sell\" value=\"vender\" name=\"type\"><label for=\"sell\" class=\"light\">Vender</label>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </fieldset>\n");
      out.write("        <button type=\"button\" class=\"btn-login\" onclick=\"signup()\" >Sign Up</button>\n");
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
      out.write("<script type=\"text/javascript\" src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js\"></script>\n");
      out.write("<script>\n");
      out.write("    function previewFile(){\n");
      out.write("        var preview = document.querySelector('img[name=profileImg]'); //selects the query named img\n");
      out.write("        var file    = document.querySelector('input[type=file]').files[0]; //sames as here\n");
      out.write("        var reader  = new FileReader();\n");
      out.write("\n");
      out.write("        reader.onloadend = function () {\n");
      out.write("            preview.src = reader.result;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        if (file) {\n");
      out.write("            reader.readAsDataURL(file); //reads the data as a URL\n");
      out.write("        } else {\n");
      out.write("            preview.src = \"\";\n");
      out.write("        }\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    previewFile();\n");
      out.write("\n");
      out.write("    function signup() {\n");
      out.write("        var authorizeButton = $('.btn-login');\n");
      out.write("        $('#sigup-form').submit();\n");
      out.write("    }\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
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
