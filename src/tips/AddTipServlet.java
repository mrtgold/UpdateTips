package tips;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 2/2/13
 * Time: 10:51 PM
 * To change this template use File | Settings | File Templates.
 */
public class AddTipServlet extends HttpServlet {
    private static final Logger log = Logger.getLogger(AddTipServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

//        String content = request.getParameter("content");
//        if (content == null) {
//            content = "(No greeting)";
//        }
//        if (user != null) {
//            log.info("Greeting posted by user " + user.getNickname() + ":" + content);
//        } else {
//            log.info("Greeting posted anonymously: " + content);
//        }
//
//        response.sendRedirect("/guestbook.jsp");

        // We have one entity group per Guestbook with all Greetings residing
        // in the same entity group as the Guestbook to which they belong.
        // This lets us run a transactional ancestor query to retrieve all
        // Greetings for a given Guestbook.  However, the write rate to each
        // Guestbook should be limited to ~1/second.


        //String guestbookName = request.getParameter("guestbookName");
        Key tipStoreKey = KeyFactory.createKey(GetAllTipsServlet.TIPS_STORE_NAME_KEY, GetAllTipsServlet.TIPS_STORE_NAME_DEFAULT);
        String tipText = request.getParameter(GetAllTipsServlet.TIP_TIP_TEXT);
        String iconUrl = request.getParameter(GetAllTipsServlet.TIP_ICON_URL);
        String refUrl = request.getParameter(GetAllTipsServlet.TIP_REF_URL);
        Entity greeting = new Entity(GetAllTipsServlet.TIPS_STORE_KIND, tipStoreKey);

        Date date = new Date();
//        String formattedDate = SimpleDateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, Locale.US).format(date);

        greeting.setProperty("user", user);
        greeting.setProperty(GetAllTipsServlet.TIP_MODIFIED, date.getTime());
        greeting.setProperty(GetAllTipsServlet.TIP_TIP_TEXT, tipText);
        greeting.setProperty(GetAllTipsServlet.TIP_ICON_URL, iconUrl);
        greeting.setProperty(GetAllTipsServlet.TIP_REF_URL, refUrl);

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(greeting);

        response.sendRedirect("manageTips.jsp");
    }

//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
}
