package guestbook;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 2/2/13
 * Time: 10:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class GuestbookServlet extends javax.servlet.http.HttpServlet {
    //    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        response.setContentType("text/plain");
//        response.getWriter().println("Hello, world!");
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        if (user!=null){
        response.setContentType("text/plain");
        response.getWriter().println("Hello, " + user.getNickname());
        }else{
            response.sendRedirect(userService.createLoginURL(request.getRequestURI()));
        }

    }
}
