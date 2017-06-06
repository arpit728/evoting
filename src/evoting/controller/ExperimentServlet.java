package evoting.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by arpit on 2/2/17.
 */
@WebServlet("/exp")
public class ExperimentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {


        /*try {
            throw new ServletException();
        } catch (ServletException e) {
            //e.printStackTrace();
        }*/
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new Object().equals(new Object());
        HttpSession session=request.getSession(false);
        System.out.println("The new session got created, session = "+session.getId());
        ArrayList a=new ArrayList();
        a.size();
    }

}
