package com.Handler;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.sql.DataSource;

import DB.InsertData;

public class ClientHandler extends Thread {

	    DataInputStream dis;
	    DataOutputStream dos;
	    final Socket s;
	    Connection con;
	    @Resource(name = "jdbc/AnveshakDB")
		private DataSource dataSource;

	 
	    // Constructor
	    public ClientHandler(Socket s, DataInputStream dis, DataOutputStream dos,Connection con) 
	    {
	        this.s = s;
	        this.dis = dis;
	        this.dos = dos;
	        this.con=con;
	    }
	 
	    @Override
	    public void run() 
	    {
	    	try {
	    	    String received;
	    	    String CPUusage;
	    	    String hostname;
	    	    String ip;
	    	    String os;
	    	    String mac;
	    	    String ram;
	    	    String disk;
	    	    String ar[]=new String[7];
	            boolean loop=true;
	            while (loop) 
	            {
	                try
	                {
	                	for(int i=0;i<7;i++) {
	                    // receive the string
	                    received = dis.readUTF();
	                    ar[i]=received;
	                	}
	                    CPUusage=ar[0];
	                    hostname=ar[1];
	                    ip=ar[2];
	                    os=ar[3];
	                    mac=ar[4];
	                    	InsertData.insertData(ar[0],ar[1],ar[2],ar[3],ar[4],ar[5],ar[6],con);
	                   
	                    
	                } catch (Exception e) {
	                     loop=false;
	                     
	                    e.printStackTrace();
	                }
	                 
	            }
	    	}
	    	catch(Exception e) {}
	    	
	    }

}
