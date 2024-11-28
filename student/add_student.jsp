<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
        }
        .receipt-container {
            max-width: 900px;
            margin: auto;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 1.8em;
            color: #333;
        }
        .details {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 20px;
        }
        .details div {
            flex: 1 1 calc(50% - 20px);
        }
        .total {
            font-weight: bold;
            margin-top: 20px;
            text-align: right;
        }
        .amount {
            color: #4CAF50;
            font-size: 1.2em;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 0.9em;
        }
        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #45a049;
        }
        @media screen and (max-width: 768px) {
            .details div {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="header">
            <h1>Registration Receipt</h1>
            <p><strong>Date:</strong> <%= new java.util.Date() %></p>
        </div>

    <%
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+application.getRealPath("/")+"/app4_Reload/assets/database/Student_Data.mdb");
            PreparedStatement qury = con.prepareStatement("INSERT INTO students(reg_no, student_name, branch, course, gender, age, dob, phon, state, city ) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");

            Date now = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String dateTimeString = formatter.format(now);
            String reg_no = "BST" + dateTimeString;

            String name = request.getParameter("vname");
            int branch = Integer.parseInt(request.getParameter("vbranch"));
            int course = Integer.parseInt(request.getParameter("vcourse"));
            int age = Integer.parseInt(request.getParameter("vage"));
            String gender = request.getParameter("vgender");
            String dob = request.getParameter("vdob");
            String phon = request.getParameter("vphon");
            int state = Integer.parseInt(request.getParameter("vstate"));
            int city = Integer.parseInt(request.getParameter("vcity"));

            qury.setString(1, reg_no);
            qury.setString(2, name);
            qury.setInt(3, branch);
            qury.setInt(4,course);
            qury.setString(5, gender);
            qury.setInt(6, age);
            qury.setString(7, dob);
            qury.setString(8, phon);
            qury.setInt(9, state);
            qury.setInt(10, city);

            qury.executeUpdate();
            
            // recipt formation

            PreparedStatement pbranches = con.prepareStatement("SELECT * FROM branches WHERE id=?");  
            pbranches.setInt(1, branch);
            PreparedStatement pcities = con.prepareStatement("SELECT * FROM cities WHERE id=?");    
            pcities.setInt(1, city);
            PreparedStatement pcourses = con.prepareStatement("SELECT * FROM courses WHERE id=?");    
            pcourses.setInt(1, course);
            PreparedStatement pstates = con.prepareStatement("SELECT * FROM states WHERE id=?");    
            pstates.setInt(1, state);

            ResultSet pbranch = pbranches.executeQuery();
            ResultSet pcity = pcities.executeQuery();
            ResultSet pcourse = pcourses.executeQuery();
            ResultSet pstate = pstates.executeQuery();

            pbranch.next();
            pcity.next();
            pcourse.next();
            pstate.next();

            long duration = Integer.parseInt(pcourse.getString("duration"));
            long annual_fee = Integer.parseInt(pcourse.getString("annual_fee"));
            long total_fee = duration * annual_fee ;
            long tax18 = (total_fee*18)/100;
    %>

        <div class="details">
            <div><strong>Registration No:</strong> <%= reg_no %></div>
            <div><strong>Student Name:</strong> <%= name %></div>
            <div><strong>Branch:</strong> <%= pbranch.getString("name") %></div>
            <div><strong>Course:</strong> <%= pcourse.getString("name") %></div>
            <div><strong>Gender:</strong> <%= gender.substring(0, 1).toUpperCase() +gender.substring(1) %></div>
            <div><strong>Age:</strong> <%= age %></div>
            <div><strong>Date of Birth:</strong> <%= dob %></div>
            <div><strong>Phone:</strong> <%= phon %></div>
            <div><strong>State:</strong> <%= pstate.getString("name") %></div>
            <div><strong>City:</strong> <%= pcity.getString("city") %></div>
            <div><strong>Course Duration:</strong> <%= duration %></div>
            <div><strong>Annual Fee:</strong> &#8377;<%= annual_fee %></div>
        </div>
        <hr>
        <div class="total">
            <div><strong>Subtotal:</strong> &#8377;<%= total_fee %></div>
            <div><strong>Taxes (18%):</strong> &#8377;<%= tax18 %></div>
            <div><strong>Prospectus Charges:</strong> &#8377;<%= 1000 %></div>
            <div class="amount"><strong>Total Course Fee:</strong> &#8377;<%= total_fee+1000+tax18 %></div>
        </div>
        <hr>
        <form>
        <div class="footer">
            <p>Thank you for registering!</p>
            <p>You will automatically Redirected on the Home page in 10 seconds please<br>
            save your recipt own</p>
            <a href="redirect.jsp" class="btn">Go to Home</a>
        </div>
    </div>
 
    <script>
        setTimeout(function() {
            window.location.href = "redirect.jsp";
        }, 12000);
    </script>

    <%   
            //out.write("<H2>SUCCESSFULLY SAVES</H2>");
            //response.sendRedirect("/../applications/app4_Reload/Loading.html");
         }
        catch(Exception obj) {
            response.sendRedirect("/../applications/app4_Reload/UnexpectedError.html");
            //out.write(obj.getMessage());
        }  
    %>

</body>
</html>