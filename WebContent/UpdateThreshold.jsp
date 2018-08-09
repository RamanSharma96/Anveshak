<%@ page language="java" import="java.sql.*, DB.GetConnection" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%!
		Connection con;
	%>
	<%
		//out.println(request.getParameter("threshold"));
		try{
			con=GetConnection.getConnection();
			PreparedStatement ps=con.prepareStatement("update devices set cputhreshold=?,diskthreshold=?,memorythreshold=? where hostname=?");
			ps.setInt(1,Integer.parseInt(request.getParameter("cpu_threshold")));
			ps.setInt(2,Integer.parseInt(request.getParameter("disk_threshold")));
			ps.setInt(3,Integer.parseInt(request.getParameter("memory_threshold")));
			ps.setString(4,request.getParameter("hostname"));
			ps.executeUpdate();
			 String redirectURL = "http://localhost:8080/AnveshakTeam2/Thresholds.jsp";
			 response.sendRedirect(redirectURL);
		}
		catch(Exception e){e.printStackTrace();}
	%>
</body>
</html>