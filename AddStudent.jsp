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
        try{
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+application.getRealPath("/")+"/app4_Reload/assets/database/Student_Data.mdb");
            Statement s = con.createStatement();
    %>

    <form action="student/add_student.jsp" style="margin-bottom: 5px;padding-bottom: 238px;padding-top: 98px;margin-left: 30px;margin-right: 28px;">
        <h2 class="font-monospace text-capitalize fw-bold text-center text-bg-primary border rounded focus-ring focus-ring-primary" style="padding-top: 34px;padding-bottom: 0px;margin-bottom: 63px;margin-top: -94px;color: var(--bs-body-bg);background: var(--swiper-theme-color);position: relative;display: block;overflow: visible;font-weight: bold;font-size: 32pt;padding-left: 0px;margin-left: -24px;margin-right: -22px;">Add Details</h2>
        <div class="row row-cols-2">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Name</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="text" style="text-align: center;" name="vname" pattern="[a-zA-Z0-9 ]+" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Age</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="number" style="text-align: center;" name="vage" min="18" max="120" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Date Of Birth</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control" value="2005-06-06" type="date" name="vdob" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Gender</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vgender">
                    <option value="male" required>Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Mobile no.</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="number" style="text-align: center;" name="vphon" min="1000000000" max="9999999999" step="1" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">State</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vstate" required>

                    <%
                        ResultSet state = s.executeQuery("SELECT * FROM states");
                        while(state.next()) {
                            out.write("<option value="+state.getString("id")+">"+state.getString("name")+"</option>");
                        }
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">City</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vcity" required>

                    <%
                        ResultSet city = s.executeQuery("SELECT * FROM cities");
                        while(city.next()) {
                            out.write("<option value="+city.getInt("id")+">"+city.getString("city")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Course</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vcourse" required>

                    <%
                        ResultSet courses = s.executeQuery("SELECT * FROM courses");
                        while(courses.next()) {
                            out.write("<option value="+courses.getInt("id")+">"+courses.getString("name")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Branch</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select" style="text-align: center;" name="vbranch" required>

                    <%
                        ResultSet branches = s.executeQuery("SELECT * FROM branches");
                        while(branches.next()) {
                            out.write("<option value="+branches.getInt("id")+">"+branches.getString("name")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2" style="margin-top: 72px;">
            <div class="col" style="text-align: center;"><input class="btn btn-primary" type="submit"></div>
            <div class="col" style="text-align: center;"><button class="btn btn-primary" type="reset" style="text-align: center;">Reset</button></div>
        </div>
    </form>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="assets/js/Simple-Slider-swiper-bundle.min.js"></script>
    <script src="assets/js/Simple-Slider.js"></script>

    <%
        }
        catch(Exception e) {
            response.sendRedirect("/../applications/app4_Reload/UnexpectedError.html");
        }
    %>
    
</body>

</html>