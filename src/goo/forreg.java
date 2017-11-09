package goo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class forreg
 */
public class forreg extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public forreg() {
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
		Connection con = linkmysql.getConnection();
		usemysql ums = new usemysql(con);
		String theid = (String) request.getParameter("theid");
		String thename = (String) request.getParameter("thename");
		String thepwd = (String) request.getParameter("thepwd");
		String ifreg = "0";
		String theresult = "";
		Vector b = new Vector();

		Vector usenum = new Vector();
		try {
			b = ums.select("user;");
			for (int i = 0; i < b.size(); i++) {
				usenum.addElement(((Vector) b.get(i)).get(0));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (int i = 0; i < usenum.size(); i++) {
			if (theid.equals(usenum.elementAt(i))) {
				ifreg = "1";
			}
		}

		try {
			ums.insert("user#'" + theid + "'#'" + thename + "'#'" + thepwd+"'");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			ifreg = "2";
		}
		theresult = theresult + ifreg + "#" + theid + "#";
	
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
