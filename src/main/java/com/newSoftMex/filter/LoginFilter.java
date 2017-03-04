package com.newSoftMex.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by alan.flores on 1/30/17.
 */
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        //timeout for inactivity in 20 seconds
        session.setMaxInactiveInterval(3*60);

        System.out.println(httpRequest.getRequestURI());
        if (!httpRequest.getRequestURI().startsWith("/front_job/index.jsp")
                && !httpRequest.getRequestURI().startsWith("/front_job/enableUser")
                && !httpRequest.getRequestURI().startsWith("/front_job/login")
                && !httpRequest.getRequestURI().startsWith("/front_job/getPremium")
                && !httpRequest.getRequestURI().startsWith("/front_job/Register.jsp")
                && !httpRequest.getRequestURI().startsWith("/front_job/images")
                && !httpRequest.getRequestURI().startsWith("/front_job/SendEmail")
                && !httpRequest.getRequestURI().startsWith("/front_job/saveImage")
                && !httpRequest.getRequestURI().startsWith("/front_job/saveImageUser")
                && !httpRequest.getRequestURI().startsWith("/front_job/css")
                && !httpRequest.getRequestURI().startsWith("/front_job/Contact.jsp")) {
            if (session.isNew() || session.getAttribute("Authenticated") == null) {
                session.setAttribute("RequestUrl", httpRequest.getRequestURI());
                session.setAttribute("Authenticated", false);
                httpResponse.sendRedirect("/front_job/index.jsp");
                return;
            } else if(!(boolean) session.getAttribute("Authenticated")){
                session.setAttribute("RequestUrl", httpRequest.getRequestURI());
                session.setAttribute("Authenticated", false);
                httpResponse.sendRedirect("/front_job/index.jsp");
                return;
            }else {
                if( httpRequest.getRequestURI().startsWith("/front_job/admin") && !((String)session.getAttribute("role")).equals("ROLE_ADMIN")) {
                    ((HttpServletResponse) response).sendError(403);
                }else if( httpRequest.getRequestURI().startsWith("/front_job/user") && !((String)session.getAttribute("role")).equals("ROLE_USER")) {
                    ((HttpServletResponse) response).sendError(403);
                }else if( httpRequest.getRequestURI().startsWith("/front_job/premium") && !((String)session.getAttribute("role")).equals("ROLE_PREMIUM")) {
                    ((HttpServletResponse) response).sendError(403);
                }else if( httpRequest.getRequestURI().startsWith("/front_job/retail") && !((String)session.getAttribute("role")).equals("ROLE_RETAIL")) {
                    ((HttpServletResponse) response).sendError(403);
                }
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
