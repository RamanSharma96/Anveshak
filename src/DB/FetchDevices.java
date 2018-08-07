package DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	public static ResultSet fetchDevicesMonitoring()
	{
		try {
		    con=GetConnection.getConnection();
			if(con==null)
				System.out.println("NO DB CONNECTION");
			Statement s=con.createStatement();
			rs=s.executeQuery("select hostname,ipaddress from devices where os is not null");
			}
			catch(Exception e) {e.printStackTrace();}
			return rs;
	}
	public static ResultSet fetchDevicesDeployed(String hostname)
	{
		try {
		    con=GetConnection.getConnection();
			if(con==null)
				System.out.println("NO DB CONNECTION");
			PreparedStatement ps=con.prepareStatement("select *from devices where hostname=? and os is not null limit 1");
			ps.setString(1, hostname);
			rs=ps.executeQuery();
			}
			catch(Exception e) {e.printStackTrace();}
			return rs;
	}
	
}
