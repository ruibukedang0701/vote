package goo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

public class thevote {
	Connection con = linkmysql.getConnection();
	usemysql ums = new usemysql(con);

	Vector thevote = new Vector();
	Vector votenum = new Vector();
	Vector votetheme = new Vector();
	Vector votehost = new Vector();
	Vector votestarttime = new Vector();
	Vector voteendtime = new Vector();
	Vector votetype = new Vector();
	Vector votecanvote = new Vector();
	public thevote() {

		try {
			thevote = ums.select("thevote ORDER BY starttime DESC ;");
			for (int i = 0; i < thevote.size(); i++) {
				votenum.addElement(((Vector) thevote.get(i)).get(0));
				votetheme.addElement(((Vector) thevote.get(i)).get(1));
				votehost.addElement(((Vector) thevote.get(i)).get(2));
				votestarttime.addElement(((Vector) thevote.get(i)).get(3));
				voteendtime.addElement(((Vector) thevote.get(i)).get(4));
				votetype.addElement(((Vector) thevote.get(i)).get(5));
				if(((Vector) thevote.get(i)).get(6).equals("0")){
				votecanvote.addElement("½ûÖ¹");}
				else{
					votecanvote.addElement("ÔÊÐí");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public  Vector getvotenum() {
		return votenum;
	}
	public  Vector getvotetheme() {
		return votetheme;
	}
	public  Vector getvotehost() {
		return votehost;
	}
	public  Vector getvotestarttime() {
		return votestarttime;
	}
	public  Vector getvoteendstime() {
		return voteendtime;
	}
	public  Vector getvotetype() {
		return votetype;
	}
	public  Vector getvotecanvote() {
		return votecanvote;
	}
}
