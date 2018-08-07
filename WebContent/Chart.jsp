<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="DB.GetConnection"%>

<html>
<head>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</head>
<body>

<%!
int cpuc,cpun,memc,memn,diskc,diskn; 
       String a="";
   String b="";
       String c="";
           
 
%>
<script>
window.onload=  function() {
    var pointsc="<%out.print(a);%>";
    var pointsm="<%out.print(b);%>";
    var pointsd="<%out.print(c);%>";
  var arrc=pointsc.split("a");
  var arrm=pointsm.split("a");
  var arrd=pointsd.split("a");
  var ycpu=[];
  var ymem=[];
  var ydisk=[];
    var xa=[-45,-40,-35,-30,-25,-20,-15,-10,-5,0]
  var dataPointsCPU = [];
  var dataPointsMem = [];
  var dataPointsDisk = [];
    var i=10,j=0;
  for(i=9;i>=0;i--)
  {
    ycpu[j]=parseInt(arrc[i]);
    ymem[j]=parseInt(arrm[i]);
    ydisk[j++]=parseInt(arrd[i]);

  }

for (var i = 0; i < 10; i++) {
  dataPointsCPU.push({
    x: xa[i],
    y: ycpu[i]
  });
  dataPointsMem.push({
    x: xa[i],
    y: ymem[i]
  });
  dataPointsDisk.push({
    x: xa[i],
    y: ydisk[i]
  });
}
var chartcpu = new CanvasJS.Chart("chart1", {
  title: {
    text: " Populating chart using array "
  },
  axisY: {
    title: "CPU Utilization",
    stripLines: [{
      value: 20,
      label: "Normal",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    },{value: 30,
      label: "Critical",
      labelFontColor:"blue",
      thickness:3,
      color:"#e63900"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsCPU
  }]
});

chartcpu.render();
var chartmem = new CanvasJS.Chart("chart2", {
  title: {
    text: " Populating chart using array "
  },
  axisY: {
    title: "CPU Utilization",
    stripLines: [{
      value: 20,
      label: "Normal",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    },{value: 30,
      label: "Critical",
      labelFontColor:"blue",
      thickness:3,
      color:"#e63900"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsMem
  }]
});

chartmem.render();
var chartdisk = new CanvasJS.Chart("chart3", {
  title: {
    text: " Populating chart using array "
  },
  axisY: {
    title: "CPU Utilization",
    stripLines: [{
      value: 20,
      label: "Normal",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    },{value: 30,
      label: "Critical",
      labelFontColor:"blue",
      thickness:3,
      color:"#e63900"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsDisk
  }]
});


chartdisk.render();
}

</script>

<%
try{
     

// declare a connection by using Connection interface 
Connection con = GetConnection.getConnection();
PreparedStatement ps=con.prepareStatement("select c.cpuutil from devices d, cpu_utilization c where d.hostname=? and d.deviceid=c.deviceid order by time desc limit 10");
ps.setString(1,request.getParameter("hostname")); 
ResultSet rs=ps.executeQuery();
rs.next();
for(int i=0;i<10;i++)
{
  a=a+Double.toString(rs.getFloat(1))+"a";
  rs.next();
}  
ps=con.prepareStatement("select c.memoryutil from devices d, memory_utilization c where d.hostname=? and d.deviceid=c.deviceid order by time desc limit 10");
ps.setString(1,request.getParameter("hostname")); 
rs=ps.executeQuery();
rs.next();
for(int i=0;i<10;i++)
{
  b=b+Double.toString(100- rs.getFloat(1))+"a";
  rs.next();
} 
ps=con.prepareStatement("select c.diskutil from devices d, disk_utilization c where d.hostname=? and d.deviceid=c.deviceid order by time desc limit 10");
ps.setString(1,request.getParameter("hostname")); 
rs=ps.executeQuery();
rs.next();
for(int i=0;i<10;i++)
{
  c=c+Double.toString(512-rs.getFloat(1))+"a";
  rs.next();
} 

ps=con.prepareStatement("select cputhreshold,diskthreshold,memorythreshold from devices");
rs=ps.executeQuery();
rs.next();
cpun=(int)(rs.getFloat(1));
diskn=512-(int)(rs.getFloat(2));
memc=100-(int)(rs.getFloat(3));

}
       catch(Exception e){out.println(e);}    
%>
<div id="chart1" style="height: 360px; width: 100%;"></div><br><br>
<div id="chart2" style="height: 360px; width: 100%;"></div><br><br>
<div id="chart3" style="height: 360px; width: 100%;"></div>

</body>
</html>

---------

<script>
window.onload=  function() {
    var pointsc="<%out.print(a);%>";
    var pointsm="<%out.print(b);%>";
    var pointsd="<%out.print(c);%>";
  var arrc=pointsc.split("a");
  var arrm=pointsm.split("a");
  var arrd=pointsd.split("a");
  var ycpu=[];
  var ymem=[];
  var ydisk=[];
    var xa=[-45,-40,-35,-30,-25,-20,-15,-10,-5,0]
  var dataPointsCPU = [];
  var dataPointsMem = [];
  var dataPointsDisk = [];
    var i=10,j=0;
  for(i=9;i>=0;i--)
  {
    ycpu[j]=parseInt(arrc[i]);
    ymem[j]=parseInt(arrm[i]);
    ydisk[j++]=parseInt(arrd[i]);

  }

for (var i = 0; i < 10; i++) {
  dataPointsCPU.push({
    x: xa[i],
    y: ycpu[i]
  });
  dataPointsMem.push({
    x: xa[i],
    y: ymem[i]
  });
  dataPointsDisk.push({
    x: xa[i],
    y: ydisk[i]
  });
}
var chartcpu = new CanvasJS.Chart("chart1", {
  title: { 
	
    text: " CPU Utilization vs Time "
  },
  axisY: {
	  maximum:100,
    title: "CPU Utilization",
    stripLines: [{
      value: <%=cpun%>,
      label: "Threshold",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsCPU
  }]
});

chartcpu.render();
var chartmem = new CanvasJS.Chart("chart2", {
  title: {
	
    text: " Memory Utilization vs Time  "
  },
  axisY: {
	  maximum:100,
    title: "Memory Utilization",
    stripLines: [{
      value: <%=memc%>,
      label: "Threshold",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsMem
  }]
});
chartmem.render();
var chartdisk = new CanvasJS.Chart("chart3", {
  title: {
    text: " Disk Utilization vs Time "
  },
  axisY: {
	  maximum:512,
    title: "Disk Utilization",
    stripLines: [{
      value: <%=diskn%>,
      label: "Threshold",
      labelFontColor:"blue",
      thickness:3,
      color:"red"
    }]
  },
  data: [{
    type: "spline",
    lineColor: "blue",
    dataPoints: dataPointsDisk
  }]
});
chartdisk.render();

}

</script>
