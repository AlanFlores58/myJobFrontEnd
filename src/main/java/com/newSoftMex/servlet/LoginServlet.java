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
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.Map;
import java.lang.reflect.Type;

/**
 * Created by alan.flores on 1/30/17.
 */
public class LoginServlet extends HttpServlet{


    private static final String LOGIN ="http://localhost:8095/api_job/private/api/v1/currentUser/";
    private static final String USER_ROLE ="http://localhost:8095/api_job/private/api/v1/unUpgradePremium/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //PrintWriter writer = response.getWriter();
        String token = request.getParameter("token");
        System.out.println(token);
        HttpSession session;
        Map<String,Object> userData = authenticate(token);

        if(userData != null){
            session = request.getSession(false);
            if (session != null) {
                session.setAttribute("Authenticated", true);
                session.setAttribute("username", userData.get("username"));
                session.setAttribute("token", userData.get("token"));
                session.setAttribute("image", userData.get("image"));
                session.setAttribute("premiumDate", userData.get("premiumDate"));
                session.setAttribute("role", userData.get("role"));
                session.setAttribute("email", userData.get("email"));



                if(((String)userData.get("role")).equals("ROLE_PREMIUM")){
                    System.out.println(userData.get("premiumDate"));


                    Date date = new Date(Long.parseLong(String.format("%.0f", userData.get("premiumDate"))));
                    Date dateToday = new Date();
                    if(date.before(dateToday)){
                        Map<String,Object> userData2 = unUpgradePremiumAuth((String) userData.get("username"), token);
                        if(userData2 != null){
                            session.setAttribute("role","ROLE_USER");
                            session.setAttribute("premiumDate", null);
                            session.setAttribute("defeatedPremium", true);
                        }
                        else{
                            session.setAttribute("Authenticated", false);
                            session.setAttribute("username", null);
                            session.setAttribute("token", null);
                            session.setAttribute("image", null);
                            session.setAttribute("premiumDate", null);
                            session.setAttribute("role", null);
                            session.setAttribute("email", null);
                            response.sendError(403);
                        }
                    }

                }






                /*if(((String)userData.get("role")).equals("ROLE_ADMIN")) {
                    response.sendRedirect("/front_job/admin/index.jsp");
                }else if( ((String)userData.get("role")).equals("ROLE_USER")) {
                    response.sendRedirect("/front_job/user/index.jsp");
                }else if( ((String)userData.get("role")).equals("ROLE_PREMIUM")) {
                response.sendRedirect("/front_job/premium/index.jsp");
                }else if( ((String)userData.get("role")).equals("ROLE_RETAIL")) {
                    response.sendRedirect("/front_job/retail/index.jsp");
                }else
                    response.sendRedirect("/front_job/index.jsp");*/

                if((session.getAttribute("role")).equals("ROLE_ADMIN")) {
                    response.sendRedirect("/front_job/admin/index.jsp");
                }else if((session.getAttribute("role")).equals("ROLE_USER")) {
                    response.sendRedirect("/front_job/user/index.jsp");
                }else if((session.getAttribute("role")).equals("ROLE_PREMIUM")) {
                    response.sendRedirect("/front_job/premium/index.jsp");
                }else if((session.getAttribute("role")).equals("ROLE_RETAIL")) {
                    response.sendRedirect("/front_job/retail/index.jsp");
                }else
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

    private Map<String, Map> getCurrentUserInfo(String token){
        Map<String, Map> returnObject = null;
        try {
            URL url = new URL(LOGIN);
            URLConnection connection = url.openConnection();
            connection.setDoInput(true);
            connection.setRequestProperty("Authorization", "Bearer " + token);
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

    private Map<String,Object> unUpgradePremiumAuth(String username, String token){
        Map<String, Map> currentUser = unUpgradePremium(username, token);
        Map<String, Object> responseData = null;
        if (currentUser != null && currentUser.get("response") != null &&
                currentUser.get("response").get("data") != null) {
            responseData = (Map<String,Object>) currentUser.get("response").get("data");
        }
        return responseData;
    }

    private Map<String, Map> unUpgradePremium(String username, String token){
        Map<String, Map> returnObject = null;
        try {
            URL url = new URL(USER_ROLE + username.replace(" ","%20"));
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoInput(true);
            connection.setRequestProperty("Authorization", "Bearer " + token);
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
