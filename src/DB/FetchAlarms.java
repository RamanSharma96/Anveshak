package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.sql.*;


public class FetchAlarms {
	

	private static Connection con;
	private static ResultSet rs=null;
	public static ResultSet fetchAlarms()
	{
		try {
	    
	    //Class.forName("com.mysql.jdbc.Driver");
	    //con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monitoringsystem", "root", "raman");
	    con=GetConnection.getConnection();
		if(con==null)
			System.out.println("NO DB CONNECTION");
		Statement s=con.createStatement();
		rs=s.executeQuery(" select hostname,ipaddress,time,errorid,alarmcause from alarms,devices where alarms.deviceid=devices.deviceid order by time desc;");
		}
		catch(Exception e) {e.printStackTrace();}
		return rs;
	}
	public static ResultSet fetchAlarms(String hostname)
	{
		try {
		    
		    //Class.forName("com.mysql.jdbc.Driver");
		    //con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monitoringsystem", "root", "raman");
		    con=GetConnection.getConnection();
			if(con==null)
				System.out.println("NO DB CONNECTION");
			PreparedStatement ps=con.prepareStatement("select hostname,ipaddress,time,errorid,alarmcause from alarms,devices where alarms.deviceid=devices.deviceid and hostname=? order by time desc");
			ps.setString(1,hostname);
			rs=ps.executeQuery();
			}
			catch(Exception e) {e.printStackTrace();}
			return rs;
	}
	public static ResultSet fetchAlarmCount(String hostname)
	{
		try {
		    
		    //Class.forName("com.mysql.jdbc.Driver");
		    //con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monitoringsystem", "root", "raman");
		    con=GetConnection.getConnection();
			if(con==null)
				System.out.println("NO DB CONNECTION");
			PreparedStatement ps=con.prepareStatement("select count(*) from alarms as a,devices as d where d.deviceid=a.deviceid and d.hostname=?");
			ps.setString(1,hostname);
			rs=ps.executeQuery();
			}
			catch(Exception e) {e.printStackTrace();}
			return rs;
	}
}
