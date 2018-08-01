package com.listener;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;

import javax.servlet.ServletContext;

import com.Handler.ClientHandler;

public class Server implements Runnable {

	private ServletContext sc;
	private Connection con;
	public Server(ServletContext sc2, Connection con2) {
		// TODO Auto-generated constructor stub
		sc=sc2;
		con=con2;
	}

	

	public void run() {
		// TODO Auto-generated method stub
		try {
			//SOCKET CODE
			
			 ServerSocket ss = new ServerSocket(Integer.parseInt(sc.getInitParameter("port")));
	        
		     Socket s;
		  
		        // running infinite loop for getting
		        // client request
		        while (true) 
		        {
		            // Accept the incoming request
		            s = ss.accept();
		 
		            System.out.println("New client request received : " + s);
		             
		            // obtain input and output streams
		            DataInputStream dis = new DataInputStream(s.getInputStream());
		            DataOutputStream dos = new DataOutputStream(s.getOutputStream());
		             
		            System.out.println("Creating a new handler for this client...");
		 
		            // Create a new handler object for handling this request.
		             ClientHandler mtch = new ClientHandler(s,dis, dos,con);
		 
		            // Create a new Thread with this object.
		             Thread t = new Thread(mtch);
		             
		 
		            // start the thread.
		            t.start();
		 
		 
		        }
			}
			catch(Exception e) {}
		
	}

}
