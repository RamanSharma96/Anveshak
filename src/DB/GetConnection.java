package DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class GetConnection {

	private static Connection con=null;
	public static Connection getConnection() {
		
		try {
		Class.forName("com.mysql.jdbc.Driver");
	    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test?autoReconnect=true&useSSL=false", "root", "raman");
		}
		catch(Exception e) {e.printStackTrace();}
		return con;
	}

}
