package goo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class forlog
 */

public class forlog extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public forlog() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		Connection con = linkmysql.getConnection();
		usemysql ums = new usemysql(con);
		String theid = "";
		if ((String) request.getParameter("theid") != null) {
			theid = (String) request.getParameter("theid");
		}
		String thepwd = "";
		if ((String) request.getParameter("thepwd") != null) {
			thepwd = (String) request.getParameter("thepwd");
		}
		String thename = "";
		String ifreg = "1";
		String theresult = "";
		Vector user = new Vector();
		
		Vector usenum = new Vector();
		Vector usepwd = new Vector();

		try {
			user = ums.select("user;");
			for (int i = 0; i < user.size(); i++) {
				usenum.addElement(((Vector) user.get(i)).get(0));
				usepwd.addElement(((Vector) user.get(i)).get(2));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		for (int i = 0; i < usenum.size(); i++) {
			if (theid.equals(usenum.elementAt(i))) {
				ifreg = "2";
				if (thepwd.equals(usepwd.elementAt(i))) {
					ifreg = "0";
					thename = (String) ((Vector) user.get(i)).get(1);
				}
			}

		}

		theresult = theresult + ifreg + "#" + theid + "#" + thename + "#";
		//System.out.print(theresult+"||"+thepwd+"||");
		Cookie logck=new Cookie("logck",theid+"#"+thename+"#"+thepwd);
		session.setAttribute("gn", "");
		logck.setMaxAge(60*60);
		response.addCookie(logck);
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */
			out.println(theresult);
			out.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
