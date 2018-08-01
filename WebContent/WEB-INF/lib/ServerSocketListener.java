
	import java.io.*;  
	import java.net.*; 
	import javax.servlet.*;
	
	public class ServerSocketListener implements ServletContextListener{  
		
	       //Run this before web application is started
		@Override
		public void contextInitialized(ServletContextEvent arg0) {
			System.out.println("ServletContextListener started");	
			ServerSocket ss;
			Socket s;
			public static void init(){  
			try{  
			ss=new ServerSocket(6666);  
			Socket s=ss.accept();//establishes connection   
			DataInputStream dis=new DataInputStream(s.getInputStream());  
			String  str=(String)dis.readUTF();  
			System.out.println("message= "+str);  
			ss.close();  
			}catch(Exception e){System.out.println(e);}  
			}  	
		}
		
		@Override
		public void contextDestroyed(ServletContextEvent arg0) {
			System.out.println("ServletContextListener destroyed");
		}
	}

