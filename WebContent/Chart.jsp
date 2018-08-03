<%@ page language="java" import="java.util.*, java.sql.*, DB.GetConnection" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="Chart.bundle.js"></script>
	<script src="utils.js"></script>
	<style>
	canvas{
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
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
		//out.println(hostname);
	try{
	    con=GetConnection.getConnection();
		PreparedStatement ps=con.prepareStatement("select count(*) from alarms,devices where hostname=? and devices.deviceid=alarms.deviceid and errorid=1 group by errorid");
		ps.setString(1,hostname);
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
			a=rs.getInt(1);
		System.out.println("here: "+rs.getInt(1));}
		//System.out.println("Raman");
		
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
<div style="width:75%;">
		<canvas id="canvas"></canvas>
	</div>
	<br>
	<br>
	<!--button id="randomizeData">Randomize Data</button>
	<button id="addDataset">Add Dataset</button>
	<button id="removeDataset">Remove Dataset</button>
	<button id="addData">Add Data</button>
	<button id="removeData">Remove Data</button-->
	<script>
		//var MONTHS = ['00:00', '1:00', '2:00', '3:00', '4:00', '5:00', '6:00','7:00','8:00','9:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00'];
		var config = {
			type: 'line',
			data: {
				labels: ['00:00', '1:00', '2:00', '3:00', '4:00', '5:00', '6:00'],
				datasets: [{
					label: 'CPU Utilization',
					backgroundColor: window.chartColors.red,
					borderColor: window.chartColors.red,
					data: [
						1,
						2,
						3,
						47,
						23,
						89,
						97
					],
					fill: false,
				}, {
					label: 'Disk Utilization',
					fill: false,
					backgroundColor: window.chartColors.blue,
					borderColor: window.chartColors.blue,
					data: [
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor()
					],
				},
				{
					label: 'Memory Utilization',
					fill: false,
					backgroundColor: window.chartColors.yellow,
					borderColor: window.chartColors.yellow,
					data: [
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor(),
						randomScalingFactor()
					],
				}
				]
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: 'Utilization VS Time'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Time'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Utilization'
						}
					}]
				}
			}
		};
		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		};
		document.getElementById('randomizeData').addEventListener('click', function() {
			config.data.datasets.forEach(function(dataset) {
				dataset.data = dataset.data.map(function() {
					return randomScalingFactor();
				});
			});
			window.myLine.update();
		});
		var colorNames = Object.keys(window.chartColors);
		document.getElementById('addDataset').addEventListener('click', function() {
			var colorName = colorNames[config.data.datasets.length % colorNames.length];
			var newColor = window.chartColors[colorName];
			var newDataset = {
				label: 'Dataset ' + config.data.datasets.length,
				backgroundColor: newColor,
				borderColor: newColor,
				data: [],
				fill: false
			};
			for (var index = 0; index < config.data.labels.length; ++index) {
				newDataset.data.push(randomScalingFactor());
			}
			config.data.datasets.push(newDataset);
			window.myLine.update();
		});
		document.getElementById('addData').addEventListener('click', function() {
			if (config.data.datasets.length > 0) {
				var month = MONTHS[config.data.labels.length % MONTHS.length];
				config.data.labels.push(month);
				config.data.datasets.forEach(function(dataset) {
					dataset.data.push(randomScalingFactor());
				});
				window.myLine.update();
			}
		});
		document.getElementById('removeDataset').addEventListener('click', function() {
			config.data.datasets.splice(0, 1);
			window.myLine.update();
		});
		document.getElementById('removeData').addEventListener('click', function() {
			config.data.labels.splice(-1, 1); // remove the label first
			config.data.datasets.forEach(function(dataset) {
				dataset.data.pop(); 
			});
			window.myLine.update();
		});
	</script>
</body>
</html>
