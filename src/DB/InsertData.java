package DB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.*;

public class InsertData {

	public static void insertData(String CPUusage, String hostname, String ip, String os, String mac, Connection conn) {
		// TODO Auto-generated method stub
		  
		
		System.out.println("CPUusage: "+ip);
        
        
        //DATABASE CODE
	    try {
        if(conn!=null) {
        Thread.sleep(1000);
        CallableStatement ps=conn.prepareCall("call updatedevices(?,?,?,?) ");
		ps.setString(1, hostname);
		ps.setString(2, ip);
		ps.setString(3, mac);
		ps.setString(4,os);
	    ps.executeUpdate();
	    int s=ps.executeUpdate();
        //System.out.println(s+" ROWS inserted!!!!");
        
        Thread.sleep(1000);
		ps=conn.prepareCall("call insertintocpu(?,?)");
		ps.setString(1,ip);
		ps.setString(2, CPUusage);
		s=ps.executeUpdate();
		System.out.println(s+" ROWS inserted!!!!");
        }
        else {
        	System.out.println("NO DB CONNECTION");
        }
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    }
		
	}


	
}
