package goo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

public class content {
	Connection con = linkmysql.getConnection();
	usemysql ums = new usemysql(con);
	Vector content  = new Vector();
	Vector votenum = new Vector();
	Vector voteproject = new Vector();
	Vector voteamount = new Vector();
	public content (String num) {

		try {
			content  = ums.select("content where number='"+num+"' ;");
			for (int i = 0; i < content .size(); i++) {
				votenum.addElement(((Vector) content .get(i)).get(0));
				voteproject.addElement(((Vector) content .get(i)).get(1));
				voteamount.addElement(((Vector) content .get(i)).get(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public  Vector getvotenum() {
		return votenum;
	}
	public  Vector getvoteproject() {
		return voteproject;
	}
	public  Vector getvoteamount() {
		return voteamount;
	}
	
}
