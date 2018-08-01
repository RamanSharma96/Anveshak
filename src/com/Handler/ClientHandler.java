package com.Handler;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.StringTokenizer;

public class ClientHandler extends Thread {

	    DataInputStream dis;
	    DataOutputStream dos;
	    final Socket s;
	     
	 
	    // Constructor
	    public ClientHandler(Socket s, DataInputStream dis, DataOutputStream dos) 
	    {
	        this.s = s;
	        this.dis = dis;
	        this.dos = dos;
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
	            boolean loop=true;
	            while (loop) 
	            {
	                try
	                {
	                    // receive the string
	                    received = dis.readUTF();
	                    
	                    //System.out.println(received);
	                    StringTokenizer st=new StringTokenizer(received,"\n");
	                    while(st.hasMoreTokens())
	                    {
	                    	System.out.println("Token: "+st.nextToken());
	                    }
	                    
	                } catch (IOException e) {
	                     loop=false;
	                    e.printStackTrace();
	                }
	                 
	            }
	    	}
	    	catch(Exception e) {}
	    	
	    }

}
