package tips;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 2/6/13
 * Time: 5:16 AM
 * To change this template use File | Settings | File Templates.
 */
public class GetAllTipsServlet extends HttpServlet {
    public static final String TIPS_STORE_NAME_PARAMETER = "tipsStoreName";
    public static final String TIPS_STORE_NAME_DEFAULT = "default";
    public static final String TIPS_STORE_NAME_KEY = "TipsStore";
    public static final String TIPS_STORE_KIND= "Tip";

    public static final String TIP_TIP_TEXT= "TipText";
    public static final String TIP_ICON_URL= "TipIconUrl";
    public static final String TIP_REF_URL= "TipRefUrl";
    public static final String TIP_MODIFIED= "LastModified";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
