package DB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class FetchDevices {

	private static Connection con;
	private static ResultSet rs=null;
	public static ResultSet fetchDevices()
	{
		try {
	    
	    //Class.forName("com.mysql.jdbc.Driver");
	    //con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monitoringsystem", "root", "raman");
	    con=GetConnection.getConnection();
		if(con==null)
			System.out.println("NO DB CONNECTION");
		Statement s=con.createStatement();
		rs=s.executeQuery("select hostname,ipaddress from devices");
		}
		catch(Exception e) {e.printStackTrace();}
		return rs;
	}
}
