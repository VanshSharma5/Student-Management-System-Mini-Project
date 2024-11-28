<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>for_app4</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/swiper-icons.css">
    <link rel="stylesheet" href="assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="assets/css/Footer-Dark-icons.css">
    <link rel="stylesheet" href="assets/css/Simple-Slider-swiper-bundle.min.css">
    <link rel="stylesheet" href="assets/css/Simple-Slider.css">
</head>

<body>

    <%
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+application.getRealPath("/")+"/app4_Reload/assets/database/Student_Data.mdb");
            PreparedStatement students = con.prepareStatement("SELECT reg_no, student_name, age, course, branch FROM students ORDER BY student_name");
            ResultSet student = students.executeQuery();
    %>

    <h1 class="text-center border rounded" style="background: var(--swiper-theme-color);color: var(--bs-body-bg);">List Of Student</h1>
    <div class="table-responsive">


        <table class="table">
            <thead class="table-dark" style="color: var(--swiper-theme-color);background: var(--swiper-theme-color);">
                <tr style="color: var(--bs-table-color);background: var(--swiper-theme-color);">
                    <th style="margin-right: 43px;background: var(--swiper-theme-color);text-align: left;font-size: 12pt;padding-left: 12px;padding-right: 100px;">Registration no.</th>
                    <th style="margin-left: -1px;margin-right: -105px;padding-right: 99px;padding-left: 25px;background: var(--swiper-theme-color);">Name</th>
                    <th style="padding-right: 85px;padding-left: 7px;margin-left: -3px;margin-right: -48px;background: var(--swiper-theme-color);">Age</th>
                    <th style="margin-left: 31px;padding-left: px;background: var(--swiper-theme-color);">Course/Branch</th>
                    <th style="margin-left: 31px;padding-left: 41px;background: var(--swiper-theme-color);">View Data</th>
                </tr>
            </thead>
            <tbody>
        
        <%
            while(student.next()) {
                PreparedStatement courses = con.prepareStatement("SELECT name FROM courses WHERE id=?");
                courses.setInt(1,Integer.parseInt(student.getString("course")));
                PreparedStatement branches = con.prepareStatement("SELECT name FROM branches WHERE id=?");
                branches.setInt(1,Integer.parseInt(student.getString("branch")));
                   
                ResultSet course = courses.executeQuery();
                ResultSet branch = branches.executeQuery();
                   
                course.next();
                branch.next();

        %>

                <tr>
                    <td><%= student.getString("reg_no") %></td>
                    <td><%= student.getString("student_name") %></td>
                    <td><%= student.getString("age") %></td>
                    <td style="padding-left:-10px"><%= course.getString("name")+" / "+branch.getString("name") %></td>
                    <td><a href="maint.html" style="margin-left:50px"><u>more</u></a></td>
                </tr>
        
        <%
            }
        %>

            </tbody>
        </table>
    </div>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="assets/js/Simple-Slider-swiper-bundle.min.js"></script>
    <script src="assets/js/Simple-Slider.js"></script>

    <%
        }
        catch(Exception e) {
            out.write(e.getMessage());
            //response.sendRedirect("/../applications/app4_Reload/UnexpectedError.html");
        }
    %>

</body>

</html>