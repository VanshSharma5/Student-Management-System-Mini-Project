<%@page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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

<body style="padding-top: 72px;">

    <%
    try{
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+application.getRealPath("/")+"/app4_Reload/assets/database/Student_Data.mdb");
        Statement s = con.createStatement();
    %>

    <h2 class="font-monospace text-capitalize fw-bold text-center text-bg-primary border rounded focus-ring focus-ring-primary" style="padding-top: 34px;padding-bottom: 0px;margin-bottom: 63px;margin-top: -94px;color: var(--bs-body-bg);background: var(--swiper-theme-color);position: relative;display: block;overflow: visible;font-weight: bold;font-size: 32pt;padding-left: 0px;margin-left: -24px;margin-right: -22px;">Edit Detail</h2>
    <h1 class="text-start" style="margin-left: 27px;">Search Here&nbsp;</h1>
    <form style="margin-top: 13px;margin-bottom: 26px;">
        <div class="row row-cols-2">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start m-auto" style="text-align: center;">Registration no.</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control" pattern="[A-Z0-9]+" style="text-align: center;" name="vreg_no" required></div>
        </div><p></p>
    <input class="btn btn-primary d-flex flex-fill justify-content-center align-items-center align-content-center m-auto" type="submit" name="search_q" value="SUBMIT"style="text-align: center;padding-top: 5px;margin-top: -2px;margin-bottom: 2px;">

        <%
            if("SUBMIT".equals(request.getParameter("search_q"))) {
                PreparedStatement students = con.prepareStatement("SELECT * FROM students WHERE reg_no=?");  
                students.setString(1, request.getParameter("vreg_no"));
                ResultSet student = students.executeQuery();
        %>

    </form>
    <h1 class="text-center" style="margin-top: 20px;">
    
        <%
                if(!student.next()) {
                    out.write("No Data Found ??");
                }
                else {
                    out.write("Searched data Found :");

                    PreparedStatement branches = con.prepareStatement("SELECT * FROM branches WHERE id=?");  
                    branches.setInt(1, student.getInt("branch"));
                    PreparedStatement cities = con.prepareStatement("SELECT * FROM cities WHERE id=?");    
                    cities.setInt(1, student.getInt("city"));
                    PreparedStatement courses = con.prepareStatement("SELECT * FROM courses WHERE id=?");    
                    courses.setInt(1, student.getInt("course"));
                    PreparedStatement states = con.prepareStatement("SELECT * FROM states WHERE id=?");    
                    states.setInt(1, student.getInt("state"));

                    ResultSet branch = branches.executeQuery();
                    ResultSet city = cities.executeQuery();
                    ResultSet course = courses.executeQuery();
                    ResultSet state = states.executeQuery();
                    
                    branch.next();
                    city.next();
                    course.next();
                    state.next();

                    SimpleDateFormat htmlDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String formattedDate = htmlDateFormat.format(student.getDate("dob"));
        %>
    
    </h1>
    <form action="student/edit_student.jsp" style="margin-bottom: 5px;margin-left: 30px;margin-right: 28px;padding-bottom: 243px;padding-top: 1px;margin-top: 29px;">
        <div class="row row-cols-2" hidden>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Registration no.</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="text" style="text-align: center;" name="vreg_no" pattern="[a-zA-Z0-9 ]+" value="<% out.write(student.getString("reg_no")); %>" ></div>
        </div>
        <div class="row row-cols-2">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Name</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="text" style="text-align: center;" name="vname" pattern="[a-zA-Z0-9 ]+" value="<% out.write(student.getString("student_name")); %>" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Age</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="number" style="text-align: center;" name="vage" min="18" max="120" step="1" value="<% out.write(student.getString("age")); %>" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Date Of Birth</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control" type="date" name="vdob"  value="<% out.write(formattedDate); %>" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Gender</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vgender" required>

            <%
                out.write("<option value="+student.getString("gender")+">"+student.getString("gender").substring(0, 1).toUpperCase() +student.getString("gender").substring(1)+"</option>");
            %>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Mobile no.</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><input class="form-control d-flex flex-row justify-content-start align-content-start" type="number" style="text-align: center;" name="vphon" min="1000000000" max="9999999999" step="1" value="<% out.write(student.getString("phon")); %>" required></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">State</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vstate" required>

                    <%
                        out.write("<option value="+state.getString("id")+">"+state.getString("name")+"</option>");
                        ResultSet qstate = s.executeQuery("SELECT * FROM states");
                        while(qstate.next()) {
                            out.write("<option value="+qstate.getString("id")+">"+qstate.getString("name")+"</option>");
                        }
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">City</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vcity" required>

                    <%
                        out.write("<option value="+city.getInt("id")+">"+city.getString("city")+"</option>");
                        ResultSet qcity = s.executeQuery("SELECT * FROM cities");
                        while(qcity.next()) {
                            out.write("<option value="+qcity.getInt("id")+">"+qcity.getString("city")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Course</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select d-flex flex-row justify-content-start align-content-start" style="text-align: center;" name="vcourse" required>

                    <%
                        out.write("<option value="+course.getInt("id")+">"+course.getString("name")+"</option>");
                        ResultSet qcourses = s.executeQuery("SELECT * FROM courses");
                        while(qcourses.next()) {
                            out.write("<option value="+qcourses.getInt("id")+">"+qcourses.getString("name")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2 d-flex flex-row justify-content-start align-content-start">
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><label class="col-form-label d-flex flex-row justify-content-start align-content-start" style="text-align: center;">Branch</label></div>
            <div class="col d-flex flex-row justify-content-start align-content-start" style="text-align: center;"><select class="form-select" style="text-align: center;" name="vbranch" required>

                    <%
                        out.write("<option value="+branch.getString("id")+">"+branch.getString("name")+"</option>");
                        ResultSet qbranches = s.executeQuery("SELECT * FROM branches");
                        while(qbranches.next()) {
                            out.write("<option value="+qbranches.getInt("id")+">"+qbranches.getString("name")+"</option>");
                        }
                        
                    %>

            </select></div>
        </div>
        <div class="row row-cols-2" style="margin-top: 72px;">
            <div class="col" style="text-align: center;"><input class="btn btn-primary" type="submit" value="UPDATE" name="bupdate"></div>
            <div class="col" style="text-align: center;"><input class="btn btn-primary" type="submit" value="DELETE" name="bdelete" style="text-align: center;"></button></div>
        </div>
    </form>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="assets/js/Simple-Slider-swiper-bundle.min.js"></script>
    <script src="assets/js/Simple-Slider.js"></script>

    <%
                }
            }
        }
        catch(Exception obj) {
            response.sendRedirect("/../applications/app4_Reload/UnexpectedError.html");
            //out.write(obj.getMessage());
        }
    %>

</body>

</html>