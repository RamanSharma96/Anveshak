<%@ page language="java" import="java.util.*, java.sql.*, DB.GetConnection" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>

<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</head>
<body>

<%!
	Connection con;
%>
<%!
	int a=0;
	int b=0;
	int c=0;
%>
<script>
 function pieChart() {
var x=<%=a%>
var y=<%=b%>
var z=<%=c%>
console.log(z);
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title: {
		text: "Distribution of Alarms"
	},
	data: [{
		type: "pie",
		startAngle: 240,
		indexLabel: "{label} {y}", 
		dataPoints: [
			{y: x, label: "CPU ALARMS"},
			{y: y, label: "DISK ALARMS"},
			{y: z, label: "MEMORY ALARMS"},
			
		]
	}]
});
chart.render();
x=0;
y=0;z=0;
}
 </script>
 
<%
		response.setIntHeader("Refresh", 30);
		String hostname=request.getParameter("hostname");
		out.println(hostname);
	try{
	    con=GetConnection.getConnection();
		PreparedStatement ps=con.prepareStatement("select count(*) from alarms,devices where hostname=? and devices.deviceid=alarms.deviceid and errorid=1 group by errorid");
		ps.setString(1,hostname);
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
			a=rs.getInt(1);
		System.out.println("here: "+rs.getInt(1));}
		System.out.println("Raman");
		
		PreparedStatement ps2=con.prepareStatement("select count(*) from alarms,devices where hostname=? and devices.deviceid=alarms.deviceid and errorid=2 group by errorid");
		ps2.setString(1,hostname);
		rs=ps2.executeQuery();
		while(rs.next()){
			b=rs.getInt(1);
		System.out.println("here: "+rs.getInt(1));}
		System.out.println("Raman");
		
		PreparedStatement ps3=con.prepareStatement("select count(*) from alarms,devices where hostname=? and devices.deviceid=alarms.deviceid and errorid=3 group by errorid");
		ps3.setString(1,hostname);
		rs=ps3.executeQuery();
		while(rs.next()){
			c=rs.getInt(1);
		System.out.println("here: "+rs.getInt(1));}
		System.out.println("Raman");
		
	}
	catch(Exception e){e.printStackTrace();}
%>
<script>
pieChart()
</script>
</body>
</html>
