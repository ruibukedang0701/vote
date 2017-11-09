package goo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class hadlog
 */
public class hadlog extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public hadlog() {
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
		Cookie[] cook = request.getCookies();
		String[] tem = new String[] {};
		String theresult = "";
		boolean hadlog = false;
		if (cook != null) {
			for (int i = 0; i < cook.length; i++) {
				if (cook[i].getName().equals("logck")) {
					tem = cook[i].getValue().split("#");

				}
			}
		}
		if (tem.length > 0) {
			hadlog = true;
		} else {
			hadlog = false;
		}
		
		if (hadlog) {

			String gn = "";

			if ((String) request.getParameter("gn") != null) {
				gn = (String) request.getParameter("gn");
			}
			String projectnum = "X";

			if ((String) request.getParameter("projectnum") != null) {
				projectnum = (String) request.getParameter("projectnum");
			}
			if (gn.equals("wv")) {

				wv(session, ums, tem[0]);
			} else if (gn.equals("mv")) {// mv();
				if (projectnum.matches("[0-9]*") && !projectnum.equals("") && Integer.parseInt(projectnum, 10) > 0) {
					mv(request, ums, tem[0], Integer.parseInt(projectnum, 10));
				}
			} else if (gn.equals("sv")) {// sv();
				wv(session,ums,tem[0]);
				int svid=-1;
				if (projectnum.matches("[0-9]*") && !projectnum.equals("") && Integer.parseInt(projectnum, 10) > 0) {
					System.out.print("....."+projectnum);
					
					svid=Integer.parseInt(projectnum, 10);
				
				Vector svone=new Vector();
			
				
				try {
					svone = (Vector)ums.select(" thevote where number= "+svid+" ;");
					if(svone!=null){
						svone = (Vector)ums.select(" thevote where number= "+svid+" ;").get(0);
						for(int i=0;i<svone.size();i++){}
						if(svone.get(6).equals("1")){
							sv(session, ums, tem[0], svid,0);
						}
						else{
							sv(session, ums, tem[0], svid,1);
							
						}
					}

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
			} else if (gn.equals("lv")) {// lv();
			}
			session.setAttribute("gn", gn);

		}

		if (request.getParameter("gv") != null) {
			int gvid=Integer.parseInt(request.getParameter("id"), 10);
			
			Vector gvone=new Vector();
			try {
				gvone = (Vector)ums.select(" thevote where number= "+gvid+" ;").get(0);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(gvone.get(6).equals("1")){
			gv(request, ums, gvid,request.getParameter("sel"));
			}
		}
		if (request.getParameter("boback") != null&&request.getParameter("boback") != "") {
			session.setAttribute("gn", "");
		}
		try (

				PrintWriter out = response.getWriter()) {
			// TODO output your page here. You may use following sample
			// code.
			out.println(theresult);
			out.close();
		}
		/*
		 * String thename = ""; String ifreg = "1"; String theresult = "";
		 * 
		 * 
		 * for (int i = 0; i < usenum.size(); i++) { if
		 * (theid.equals(usenum.elementAt(i))) { ifreg = "2"; if
		 * (thepwd.equals(usepwd.elementAt(i))) { ifreg = "0"; thename =
		 * (String) ((Vector) user.get(i)).get(1); } }
		 * 
		 * }
		 * 
		 * 
		 * try (PrintWriter out = response.getWriter()) { // TODO output your
		 * page here. You may use following sample code. out.println(theresult);
		 * out.close(); } }
		 */
	}

	private void sv(HttpSession session, usemysql ums, String host, int votenum,int canvote) {
		// TODO Auto-generated method stub	
		String thesql = "update thevote set canvote="+canvote+" where number=? ";
		try {
			ums.update(thesql,votenum);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void gv(HttpServletRequest request, usemysql ums, int id, String sel) {
		// TODO Auto-generated method stub
		String thesql;	String[] sql={};
			sql = sel.split(",");
		for (int i = 0; i < sql.length; i++) {
			thesql = "update content set vamount=vamount+1 where number=? and project='"+sql [i].trim()+"' ;";
		try {
			ums.update(thesql,id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}}

	private void mv(HttpServletRequest request, usemysql ums, String host, int projectnum) {
		// TODO Auto-generated method stub

		String thesql;
		java.sql.Date start_date = new java.sql.Date(System.currentTimeMillis());
		try {
			int acountums = ums.select("thevote").size() + 1;
			thesql = "thevote#" + acountums + "#'" + request.getParameter("athetheme") + "'#'" + host + "'#'"
					+ start_date + "'#'" + request.getParameter("atheendtime") + "'#'"
					+ request.getParameter("athetype") + "'#" + "1";
			ums.insert(thesql);
			for (int i = 1; i <= projectnum; i++) {
				thesql = "content" + "#" + acountums + "#'" + request.getParameter("theip" + i + "2") + "'#" + "0";
				ums.insert(thesql);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void wv(HttpSession session, usemysql ums, String hostname) {
		// TODO Auto-generated method stub
		Vector usevote = new Vector();
		Vector usenum = new Vector();
		Vector usetheme = new Vector();
		Vector usestarttime = new Vector();
		Vector useendtime = new Vector();
		Vector usetype = new Vector();
		Vector usecanvote = new Vector();
		try {
			usevote = ums.select("thevote where host='" + hostname + "';");
			for (int i = 0; i < usevote.size(); i++) {
				usenum.addElement(((Vector) usevote.get(i)).get(0));
				usetheme.addElement(((Vector) usevote.get(i)).get(1));
				usestarttime.addElement(((Vector) usevote.get(i)).get(3));
				useendtime.addElement(((Vector) usevote.get(i)).get(4));
				usetype.addElement(((Vector) usevote.get(i)).get(5));

				if (((Vector) usevote.get(i)).get(6).equals("1")) {

					usecanvote.addElement("ÔÊÐí");
				} else {
					usecanvote.addElement("½ûÖ¹");
				}

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("usenum", usenum);
		session.setAttribute("usetheme", usetheme);
		session.setAttribute("usestarttime", usestarttime);
		session.setAttribute("useendtime", useendtime);
		session.setAttribute("usetype", usetype);
		session.setAttribute("usecanvote", usecanvote);

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
