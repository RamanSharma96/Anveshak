<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Performance-Dashboard</title>

    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">

  </head>

<%
	String hostname=request.getParameter("hostname");
%>
  <body class="bg-dark">

    <div class="container">
      <div class="card card-register mx-auto mt-5">
        <div class="card-header">Setting Threshold</div>
        <div class="card-body">
          <form action="UpdateThreshold.jsp">
            <div class="form-group">
              <div class="form-row">
                <div class="col-md-6">
                  <b>Hostname</b>
                  <div class="form-label-group">
                    <input type="text" id="hostname" name="hostname" class="form-control" value=<%=hostname %> placeholder="First name"  readonly required="required" autofocus="autofocus">
                    <label for="firstName"></label>
                  </div><br/>
                  <b>CPU Usage Threshold in %</b>
                  <div class="form-label-group">
                    <input type="number" id="cpu_threshold" name="cpu_threshold" class="form-control" placeholder="First name" required="required" autofocus="autofocus">
                    <label for="firstName"></label> 
                  </div><br/>
                  <b>Minimum Free RAM Required in %</b>
                  <div class="form-label-group">
                    <input type="number" id="memory_threshold" name="memory_threshold" class="form-control" placeholder="First name" required="required" >
                    <label for="firstName"></label>
                  </div><br/>
                  <b>Minimum Free Disk Storage in GB</b>
                  <div class="form-label-group">
                    <input type="number" id="disk_threshold" name="disk_threshold" class="form-control" placeholder="First name" required="required" ">
                    <label for="firstName"></label>
                  </div><br/>
                 
                </div>
                <!-- <div class="col-md-6">
                  <div class="form-label-group">
                    <input type="text" id="lastName" class="form-control" placeholder="Last name" required="required">
                    <label for="lastName">Last name</label>
                  </div>
                </div> -->
              </div>
            </div>
            <input type="submit" value="Update Thresholds">
          </form>
          <!-- <div class="text-center">
            <a class="d-block small mt-3" href="login.html">Login Page</a>
            <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
          </div> -->
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  </body>

</html>
