package goo;

import java.sql.*;
import java.util.Vector;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/*
		 * Connection con = linkmysql.getConnection(); usemysql a = new
		 * usemysql(con); Vector b;Vector c; try { b=a.select("user"); for(int
		 * i=0;i<b.size();i++){ c=(Vector)b.get(i); for(int j=0;j<c.size();j++){
		 * System.out.println("|"+c.get(j)+"|\t"); }
		 * 
		 * } } catch (SQLException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 * 
		 */

		content tv = new content("102");
		for (int i = 0; i < tv.getvotenum().size(); i++) {
			System.out.println(tv.getvotenum().get(i));
			System.out.println(tv.getvoteproject().get(i));
			System.out.println(tv.getvoteamount().get(i));
		}

	}
}
