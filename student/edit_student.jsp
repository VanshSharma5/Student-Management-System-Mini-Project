<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+application.getRealPath("/")+"/app4_Reload/assets/database/Student_Data.mdb");
            PreparedStatement qury = con.prepareStatement("UPDATE students SET student_name=?, branch=?, course=?, gender=?, age=?, dob=?, phon=?, state=?, city=? WHERE reg_no=?");
            PreparedStatement quryd = con.prepareStatement("DELETE students WHERE reg_no=?");

            String name = request.getParameter("vname");
            int branch = Integer.parseInt(request.getParameter("vbranch"));
            int course = Integer.parseInt(request.getParameter("vcourse"));
            int age = Integer.parseInt(request.getParameter("vage"));
            String gender = request.getParameter("vgender");
            String dob = request.getParameter("vdob");
            String phon = request.getParameter("vphon");
            int state = Integer.parseInt(request.getParameter("vstate"));
            int city = Integer.parseInt(request.getParameter("vcity"));
            String reg_no = request.getParameter("vreg_no");

            qury.setString(1, name);
            qury.setInt(2, branch);
            qury.setInt(3,course);
            qury.setString(4, gender);
            qury.setInt(5, age);
            qury.setString(6, dob);
            qury.setString(7, phon);
            qury.setInt(8, state);
            qury.setInt(9, city);
            qury.setString(10, reg_no);
            quryd.setString(1, reg_no);

            if ("UPDATE".equals(request.getParameter("bupdate"))) {
                qury.executeUpdate();
            }
            else{
                quryd.executeUpdate();
            }


            //out.write("<H2>SUCCESSFULLY SAVES      "+request.getParameter("bsubmit") + request.getParameter("bdelete")  +"</H2>");
            response.sendRedirect("/../applications/app4_Reload/Loading.html");
        }
        catch(Exception obj) {
            response.sendRedirect("/../applications/app4_Reload/UnexpectedError.html");
            //out.write(obj.getMessage());

        }   
    %>
</body>
</html>