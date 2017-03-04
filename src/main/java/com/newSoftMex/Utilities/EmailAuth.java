package com.newSoftMex.Utilities;


import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * Created by alan.flores on 1/9/17.
 */
public class EmailAuth extends Authenticator {

    private String password;
    private String user;

    protected PasswordAuthentication getPasswordAuthentication() {
        System.out.print(user);
        return new PasswordAuthentication(user,password);
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}
