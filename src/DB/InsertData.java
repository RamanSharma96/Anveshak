package DB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.*;

public class InsertData {

	public static void insertData(String CPUusage, String hostname, String ip, String os, String mac, String ram, String disk, Connection conn) {
		// TODO Auto-generated method stub
		  
		System.out.println("CPU: "+CPUusage);
		System.out.println("HOST: "+hostname);
		System.out.println("IP: "+ip);
		System.out.println("OS: "+os);
		System.out.println("MAC: "+mac);
		System.out.println("Ram: "+ram);
		System.out.println("Disk: "+disk);
        
        
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
		ps.setFloat(2, new Float(CPUusage));
		s=ps.executeUpdate();
		System.out.println(s+" ROWS inserted!!!!");
		
		Thread.sleep(1000);
		ps=conn.prepareCall("call insertintomemory(?,?)");
		ps.setString(1,ip);
		ps.setFloat(2, new Float(ram));
		s=ps.executeUpdate();
		System.out.println(s+" ROWS inserted!!!!");
			
	    Thread.sleep(1000);
	    ps=conn.prepareCall("call insertintodisk(?,?,?)");
		ps.setString(1,ip);
		ps.setString(2,"Disk C");
		ps.setFloat(3, new Float(disk));
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
