package com.listener;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.*;

//import com.Handler.ClientHandler;



/**
 * Application Lifecycle Listener implementation class ServerSocketListener
 *
 */
@WebListener
public class ServerSocketListener implements ServletContextListener {
	ServerSocket ss;
	Socket s;
	Connection con;
	
	@Resource(name = "jdbc/AnveshakDB")
	private DataSource dataSource;

    /**
     * Default constructor. 
     */
    public ServerSocketListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    	try {
			ss.close();
			System.out.println("Socket closed");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    	System.out.println("ServletContextListener started");
    	ServletContext sc=sce.getServletContext();
    	
    	
		try{  
		//DATABASE CODE
		con = dataSource.getConnection();
		
		Server s=new Server(sc,con);

        // Create a new Thread with this object.
         Thread t = new Thread(s);
         

        // start the thread.
        t.start();
		
		
		}catch(Exception e){System.out.println(e);}  
	}
    
	
}
