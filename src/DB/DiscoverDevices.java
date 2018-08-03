package DB;

import java.io.*;
import java.util.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.regex.Pattern;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
 

public class DiscoverDevices {
	private static Connection con;
	private static ResultSet rs=null;
	private static CallableStatement ps;
	public void discoverDevices(String args[] )
	{
			try {
		    /*InetAddress localhost = InetAddress.getLocalHost();
	        System.out.println(localhost);
	        System.out.println(localhost.getAddress());
	        byte[] ip = localhost.getAddress();
	 
	        /*for (int i = 1; i <= 254; i++) {
	            ip[3] = (byte) i;
	            InetAddress address = InetAddress.getByAddress(ip);
	            if (address.isReachable(500)) {
	            	ps=con.prepareCall("call InsertIntoDevices(?,?)");
	 				ps.setString(1,address.getHostName() );
	 				ps.setString(2, address.getHostAddress());
	 				ps.executeUpdate();
	                System.out.println(address.getHostAddress());
	                System.out.println(address.getHostName());
	            } 
	        }*/
	        String firstAdd = args[0];
	        String lastAddress = args[1];
	       /* 
	        InetAddress localhost = InetAddress.getLocalHost();
	        System.out.println(localhost);  
	        System.out.println(localhost.getAddress());
	        byte[] ip = localhost.getAddress();
	        
	        System.out.println(localhost.getAddress());
	        */
	        
	        con=GetConnection.getConnection();
	        InetAddress firstAddress = InetAddress.getByName(firstAdd);
	        byte[] ip = firstAddress.getAddress();
	        int a,b,c,d,e,f,i,j;
	        String[] first = firstAdd.split("\\.");
	        String[] last = lastAddress.split("\\.");
	        
	        a=Integer.parseInt(first[2]);
	        b=Integer.parseInt(last[2]);
	        c=Math.min(a, b);
	        d=Math.max(a, b);

	        a=Integer.parseInt(first[3]);
	        b=Integer.parseInt(last[3]);
	        e=Math.min(a, b);
	        f=Math.max(a, b);
	        for (i = c; i <= d; i++) {
	            ip[2] = (byte) i;
	            for(j=e;j<=f;j++) {
	            	 ip[3] = (byte) j;
	                 InetAddress address = InetAddress.getByAddress(ip);
	                 if (address.isReachable(500)) {
	                      System.out.println(address.getHostAddress());
	                      System.out.println(address.getHostName());
	                      ps=con.prepareCall("call InsertIntoDevices(?,?)");
	  	 				  ps.setString(1,address.getHostName() );
	  	 				  ps.setString(2, address.getHostAddress());
	  	 				  ps.executeUpdate();
	                 } 
	            }
	         }

			}
			catch(Exception e) {e.printStackTrace();}
		  
		  
		   
	} 
	
}
