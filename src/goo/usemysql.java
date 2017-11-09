package goo;

import java.sql.*;
import java.util.Vector;

public class usemysql {
	Connection con;
	Statement stmt;
	ResultSet rs;

	public Connection getCon() {
		return con;
	}

	public Statement getStmt() {
		return stmt;
	}

	public ResultSet getRs() {
		return rs;
	}

	public usemysql(Connection con) {

		this.con = con;
		try {
			stmt = con.createStatement();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void createTable(String thesql) throws SQLException {// ´´½¨
		String[] sql = thesql.split("#");
		stmt.executeQuery("drop table if exists " + sql[0] + " ;");
		String esql = "";
		for (int i = 1; i < sql.length; i++) {
			esql = esql + sql[i] + ",";
		}
		esql = esql.substring(0, esql.length() - 1);
		stmt.executeUpdate("create table " + sql[0] + " (" + esql + ");");

	}

	public void insert(String thesql) throws SQLException {// Ìí¼Ó
		
		String[] sql = thesql.split("#");
		String runsql = "insert into " + sql[0] + " values(";
		for (int i = 1; i < sql.length; i++) {
			runsql = runsql + sql[i] + ",";
		}
		runsql = runsql.substring(0, runsql.length() - 1) + ");";
		
		stmt.executeUpdate(runsql);
	}

	public void update(String sql,int thesql1) throws SQLException {
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, thesql1);
		pst.executeUpdate();
	}

	public Vector select(String thesql) throws SQLException {
		// String[] sql = thesql.split("#");
		// if(sql.length>1){sql[0]=sql[0]+" ORDER BY "+sql[1]+ " DESC ;";}
		rs = stmt.executeQuery("select * from " + thesql);
		
		Vector selRs = new Vector();
		while (rs.next()) {
			Vector seltem = new Vector();
			for (int i = 1; i < rs.getMetaData().getColumnCount() + 1; i++) {
				seltem.addElement(rs.getString(i));
			}
			selRs.addElement(seltem);
		}
		return selRs;
	}
}
