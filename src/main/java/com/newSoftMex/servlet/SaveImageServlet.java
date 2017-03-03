package com.newSoftMex.servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.newSoftMex.Utilities.FileUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Paths;
import java.util.*;

import static com.newSoftMex.Utilities.FileUtil.getExtention;

/**
 * Created by alan.flores on 2/14/17.
 */
@MultipartConfig
public class SaveImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entro");
        String description = request.getParameter("description");
        String name = request.getParameter("name");// Retrieves <input type="text" name="description">
        final Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">

        String filExtension = getExtention(filePart);
        String idServiceName = request.getParameter("idServiceName");
        String image = null;
        if(filExtension.equals(""))
            image = request.getParameter("imageName");

        final String relativePath = "images/imagesServicesT";
        final String path = getServletContext().getRealPath("/") + relativePath;
        final String fileName = Long.toString(new Date().getTime()) + "." + filExtension;//getSubmittedFileName(filePart);

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
            if(idServiceName == null){
                URL url = new URL("http://localhost:8095/api_job/private/api/v1/saveNewServiceType/" + description.replace(" ","%20") + "/" + name.replace(" ","%20") + "/" + ("../" + relativePath + "/").replace("/","--").replace(".","%2e").replace(" ","%20") + fileName.replace(".","%2e").replace(" ","%20") + "/");
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("PUT");
                connection.setDoInput(true);
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setRequestProperty("Accept", "application/json");
                connection.setRequestProperty("Authorization", "Bearer " + session.getAttribute("token"));
                InputStream inputStream = connection.getInputStream();
                bytes = new byte[1024];
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                while(inputStream.available() > 0){
                    inputStream.read(bytes);
                    baos.write(bytes);
                }
                System.out.println(new String(baos.toByteArray()).trim());
            }
            else{
                String urlString = null;
                if(image == null)
                    urlString = ("../" + relativePath + "/").replace("/","--").replace(".","%2e") + fileName.replace(".","%2e");
                else
                    urlString = image.replace("/","--").replace(".","%2e");
                URL url = new URL("http://localhost:8095/api_job/private/api/v1/saveNewServiceType/" + idServiceName.replace(" ","%20") + "/" + description.replace(" ","%20") + "/" + name.replace(" ","%20") + "/" + urlString.replace(" ","%20") + "/");
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST");
                connection.setDoInput(true);
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setRequestProperty("Accept", "application/json");
                connection.setRequestProperty("Authorization", "Bearer " + session.getAttribute("token"));
                InputStream inputStream = connection.getInputStream();
                bytes = new byte[1024];
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                while(inputStream.available() > 0){
                    inputStream.read(bytes);
                    baos.write(bytes);
                }
                System.out.println(new String(baos.toByteArray()).trim());
            }


            response.sendRedirect("admin/index.jsp");
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