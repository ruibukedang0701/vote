package goo;

import java.sql.*;

public class linkmysql {
	// ��̬�������������ļ���
	static {

		try {
			String driverName = "com.mysql.jdbc.Driver";
			Class.forName(driverName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// �ṩ���ӵķ���
	public static Connection getConnection() {

		Connection con = null;
		try {
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/vote?useUnicode=true&characterEncoding=utf8", "root",
					"0882116038");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}

	// �ر����ӵķ���
	public static void close(ResultSet rs, Statement stmt, Connection con) {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if (stmt != null)
				stmt.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if (con != null)
				con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
