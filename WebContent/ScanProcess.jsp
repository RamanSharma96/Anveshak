<%@ page language="java" import="DB.DiscoverDevices" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:include page="Scan.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
   <% 
      // String from_ip=request.getParameter("from_ip");
   	   //String to_ip=request.getParameter("to_ip");
   	   DiscoverDevices d=new DiscoverDevices();
   	   response.setIntHeader("Refresh",5);
   	   //String args[]={from_ip,to_ip};
   	   d.discoverDevices();
   	   out.println("Scan in progress...");
   	   
   	 //String redirectURL = "http://localhost:8080/AnveshakTeam2/Scan.jsp";
	// response.sendRedirect(redirectURL);
   %>
   
                  
                  
</body>
</html>