package com.newSoftMex.servlet;

import com.newSoftMex.Utilities.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

/**
 * Created by alan.flores on 2/14/17.
 */
@MultipartConfig
public class SaveImageUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final Part filePart = request.getPart("file");
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String mail = request.getParameter("mail");
        String password = request.getParameter("password");
        String username = request.getParameter("username");
        String sex = request.getParameter("sex").equals("male") ? "0" : "1";
        String type = request.getParameter("type").equals("comprar") ? "3" : "2";
        String cellphone = request.getParameter("cellphone");
        String telephone = request.getParameter("telephone");


        final String relativePath = "images/imagesUser";
        final String path = getServletContext().getRealPath("/") + relativePath;
        final String fileName = Long.toString(new Date().getTime()) + "." + FileUtil.getExtention(filePart);//getSubmittedFileName(filePart);

        OutputStream out = null;
        InputStream filecontent = null;
        //final PrintWriter writer = response.getWriter();
        try {
            out = new FileOutputStream(new File(path + File.separator
                    + fileName));
            filecontent = filePart.getInputStream();

            int read = 0;
            byte[] bytes = new byte[1024];

            while ((read = filecontent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }


            HttpSession session = request.getSession(false);
            URL url = new URL("http://localhost:8095/api_job/public/api/v1/signup/" + name.replace(" ","%20") + "/" + lastname.replace(" ","%20") + "/" + mail.replace(" ","%20") + "/" + username.replace(" ","%20") + "/" + password.replace(" ","%20") + "/" + type + "/" + sex + "/" + ("../" + relativePath + "/").replace("/","--").replace(".","%2e") + fileName.replace(".","%2e") + "/" + cellphone.replace(" ","%20") + "/" + telephone.replace(" ","%20"));
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            InputStream inputStream = connection.getInputStream();
            bytes = new byte[1024];
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            while(inputStream.available() > 0){
                inputStream.read(bytes);
                baos.write(bytes);
            }
            System.out.println(new String(baos.toByteArray()).trim());
            response.sendRedirect("index.jsp");
            // writer.println("New file " + fileName + " created at " + path);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            /*writer.println("You either did not specify a file to upload or are "
                    + "trying to upload a file to a protected or nonexistent "
                    + "location.");*/
            // writer.println("<br/> ERROR: " + fne.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
            if (filecontent != null) {
                filecontent.close();
            }
            //  if (writer != null) {
            //      writer.close();
            //  }
        }
    }

}