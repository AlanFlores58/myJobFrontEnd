package com.newSoftMex.servlet;

import com.newSoftMex.Utilities.EmailAuth;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by alan.flores on 3/3/17.
 */
public class SendEmailServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String contractId = request.getParameter("contractId");
        String message = request.getParameter("message");
        String email2 = request.getParameter("email");
        String email = (String) session.getAttribute("email");
        try {
            sendEmail("myjob.group.mexico@gmail.com," + email + "," + email2,"Problemas con contrato " + contractId, "Ususario: " + username + "\n"
                                                                                     + "Id del contrato: " + contractId + "\n"
                                                                                     + "Mensaje: " + message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
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

    private boolean sendEmail(String emailTo,String subject, String body) throws javax.mail.MessagingException {

        System.out.println(emailTo);
        Properties props = new Properties();
        String emailFrom = "myjob.group.mexico@gmail.com";
        String password = "12345678qwerty";
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        EmailAuth emailAuth = new EmailAuth();
        emailAuth.setPassword(password);
        emailAuth.setUser(emailFrom);
        Session session = Session.getDefaultInstance(props,emailAuth);

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailFrom));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(emailTo));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

            System.out.println("Done");
            return true;

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
