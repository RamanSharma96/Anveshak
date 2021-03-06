<%@ page language="java" import="DB.FetchDevices, DB.FetchAlarms, DB.GetConnection, java.sql.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Servers</title>

    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">

  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="index.html">Monitoring System</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Navbar Search -->
      <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
          <div class="input-group-append">
            <button class="btn btn-primary" type="button">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>
      </form>

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-0">
        <!-- <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-bell fa-fw"></i>
            <span class="badge badge-danger">9+</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-envelope fa-fw"></i>
            <span class="badge badge-danger">7</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-user-circle fa-fw"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#">Settings</a>
            <a class="dropdown-item" href="#">Activity Log</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
          </div>
        </li> -->
      </ul>

    </nav>

    <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="Alarms.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Alarms</span>
          </a>
        </li>
         </li>
         <li class="nav-item active">
          <a class="nav-link" href="Servers.jsp"> 
            <i class="fas fa-fw fa-table"></i>
            <span>Servers</span></a>
        </li>
         <li class="nav-item active">
          <a class="nav-link" href="Thresholds.jsp">
            <i class="fas fa-fw fa-table"></i>
            <span>Configure Thresholds</span></a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="Scan.jsp">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Scan</span></a>
        </li>
       <!--  <li class="nav-item active">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>Server Details</span></a>
        </li> -->
      </ul>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">Home</a>
            </li>
            <li class="breadcrumb-item active">Monitoring List </li> 
          </ol>
			 <div style="background-color:#dcdcdc ;height:100px">
			 	<table width="100%"">
			 		<tr>
			 		<th style="text-align:center;padding-top:20px ">Total No. Alarms</th>
			 		<th style="text-align:center;padding-top:20px ">Total No. Devices Monitored </th>
			 		</tr>
			 		<tr>
			 		 <td style="text-align:center;font-size:40px "><%=alarms_count %></td>
			 		 <td style="text-align:center;font-size:40px "><%=devices_count %></td>
			 		</tr>  
			 	</table>
			 </div>
			 <br>  
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
               Devices Being Monitored</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Hostname</th>
                      <th>IP Address</th>
                      <th>Alarms</th>
                    </tr>
                  </thead>
                  <%! ResultSet rs;
        		  	  static int prev_count=-1;
        		      static int cur_count=0;
        		      int refresh_time=30;
        		      static int alarms_count;
        		      static int devices_count;
        		  %>
                  <% 
                  
                  Connection con;
                  con=GetConnection.getConnection();
                  PreparedStatement ps=con.prepareStatement("select count(*) from devices where os is not null");
                  ResultSet rs=ps.executeQuery();
                  while(rs.next())
                  {
                	  devices_count=rs.getInt(1);
                  }
                 
                  ps=con.prepareStatement("select count(*) from alarms");
                  rs=ps.executeQuery();
                   while(rs.next())
                  {
                	  alarms_count=rs.getInt(1);
                  }
                  
                  rs=FetchDevices.fetchDevicesMonitoring();
                  ResultSet rs2;
                  int alarm_count=0;
                  response.setIntHeader("Refresh", refresh_time);
                  while(rs.next()){  
                	  rs2=FetchAlarms.fetchAlarmCount(rs.getString(1));
                	  while(rs2.next())
                	  {
                		  alarm_count=rs2.getInt(1);
                	  }
                   	%>
                   	 <tr>
                      <td><a href=<%="Chart.jsp?hostname="+rs.getString(1)%> target="_blank"><%=rs.getString(1)%></td></a>
                     <td><%=rs.getString(2)%></td>
                     <td>
                     	<a style="color:red" href=<%="Alarms.jsp?hostname="+rs.getString(1)%>>Alarm(<%=alarm_count %>)</a>
                     	&nbsp;&nbsp; <a style="color:orange" href=<%="PieChart.jsp?hostname="+rs.getString(1) %> target="_blank">Visualize </a>
                     </td> 
                    </tr>
                   <%
                  } %>
                  
                </table>
              </div>
            </div>
            <div class="card-footer small text-muted">Updates every <%=refresh_time%> seconds</div>
          </div>

          <!-- <p class="small text-center text-muted my-5">
            <em>More table examples coming soon...</em>
          </p>
 -->
        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <!-- <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright � Your Website 2018</span>
            </div>
          </div>
        </footer>
 -->
      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <!-- <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">�</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.html">Logout</a>
          </div>
        </div>
      </div>
    </div> -->

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="js/demo/datatables-demo.js"></script>

  </body>

</html>
