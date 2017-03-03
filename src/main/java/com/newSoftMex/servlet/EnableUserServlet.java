package com.newSoftMex.servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

/**
 * Created by alan.flores on 2/7/17.
 */
public class EnableUserServlet extends HttpServlet {

    private static final String ENABLE_USER ="http://localhost:8095/api_job/public/api/v1/enableUser/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session;

        Map<String,Object> userData = authenticate((String)request.getParameter("username"));

        if(userData != null){
            session = request.getSession(false);
            if (session != null) {
                session.setAttribute("RequestUrl", request.getRequestURI());
                session.setAttribute("Authenticated", false);
                response.sendRedirect("/front_job/index.jsp");
            }
        }else{
            response.sendError(403);
        }



    }

    private Map<String,Object> authenticate(String token){
        Map<String, Map> currentUser = getCurrentUserInfo(token);
        Map<String, Object> responseData = null;
        if (currentUser != null && currentUser.get("response") != null &&
                currentUser.get("response").get("data") != null) {
            responseData = (Map<String,Object>) currentUser.get("response").get("data");
        }
        return responseData;
    }

    private Map<String, Map> getCurrentUserInfo(String username){
        Map<String, Map> returnObject = null;
        try {
            URL url = new URL(ENABLE_USER + username.replace(" ","%20"));
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("PUT");
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            InputStream inputStream = connection.getInputStream();
            byte[] bytes = new byte[1024];
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            while(inputStream.available() > 0){
                inputStream.read(bytes);
                baos.write(bytes);
            }
            System.out.println(new String(baos.toByteArray()).trim());
            Gson gson = new Gson();
            Type stringStringMap = new TypeToken<Map<String, Map>>(){}.getType();

            returnObject= gson.fromJson("{\"response\":" + new String(baos.toByteArray()).trim() + "}", stringStringMap);
        }catch(IOException ioe){
            ioe.printStackTrace();
        }
        return returnObject;
    }
}
