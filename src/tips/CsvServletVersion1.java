package tips;


import com.google.appengine.api.datastore.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class CsvServletVersion1 extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("application/csv");
//response.setContentType("application/unknown"); //this also works
        response.setHeader("content-disposition", "filename=tips.csv"); // set the file name to whatever required..
        PrintWriter out = response.getWriter();
        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        Key tipStoreKey = KeyFactory.createKey(GetAllTipsServlet.TIPS_STORE_NAME_KEY, GetAllTipsServlet.TIPS_STORE_NAME_DEFAULT);
// Run an ancestor query to ensure we see the most up-to-date
        // view of the Greetings belonging to the selected Guestbook.
        Query query = new Query(GetAllTipsServlet.TIPS_STORE_KIND, tipStoreKey);//.addSort("date", Query.SortDirection.DESCENDING);
        List<Entity> tips = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(50));
        if (tips.isEmpty()) {

            out.println("0|\"No tips available\"|\"\"|\"\"");
        } else {
            for (Entity tip : tips) {
                String line =
                        "\"" + tip.getKey().getId() + "\"|" +
                                "\"" + tip.getProperty(GetAllTipsServlet.TIP_TIP_TEXT) + "\"|" +
                                "\"" + tip.getProperty(GetAllTipsServlet.TIP_ICON_URL) + "\"|" +
                                "\"" + tip.getProperty(GetAllTipsServlet.TIP_REF_URL) + "\"|" +
                                "\"" + tip.getProperty(GetAllTipsServlet.TIP_MODIFIED) + "\"";
                out.println(line);
            }
        }
        out.flush();
        out.close();
    }
}
