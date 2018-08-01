<%@ page language="java" import="java.io.*, java.util.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table>
	<%
		for(int i=1;i<=10;i++)
		{
	
	%>
	
	<tr>
	<td><%=out.println(i) %></td>
	</tr>
	<% 
		}
	%>
	</table>
</body>
</html>