<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Filter Student</title>
        <script>
            function myfun() {
                document.getElementById("btnFilter").click();
            }
        </script>
    </head>
    <body>
        <h1>Multi Filter</h1>
        <form action="MultiFilter" method="post" id="frmFilter">
            <input type='checkbox' name='All' value='All' 
                   ${deptSlt.contains("All")?"checked":""} onclick="myfun()"/>All<br/>
                <c:forEach items="${dao.dept}" var="de">
                    <input type='checkbox' value='${de.id}' name='chk${de.id}' 
                           ${deptSlt.contains(de.id)?"checked":""} onclick="myfun()"/>${de.name}<br/>
                </c:forEach>
            <input type="submit" name="btnFilter" value="Filter" id="btnFilter"/>
        </form>
                <form id='frmSort' method='post' action='MultiFilter'>
                    <input type="submit" name="btnSort" value="Sort by Gpa"/>
                    
                </form>
        <h1>Student Information</h1>
        <table>
            <tr>
                <th>Id</th> 
                <th>Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Dob</th>
                <th>Gpa</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${dao.std}" var ="st">
                <tr>
                     <%--<c:if test='${deptSlt.contains("All") || deptSlt.contains(st.departId)}'>--%>
                        <td>${st.id}</td>
                        <td>${st.name}</td>
                        <td>${st.gender}</td>
                        <td>${dao.GetDeptName(st.departId)}</td>
                        <td>${st.dob}</td>
                        <td>${st.gpa}</td>
                        <td>
                            <a href="LoadDB_jsp?type=0&id=${st.id}">Update</a>
                            <a href="LoadDB_jsp?type=1&id=${st.id}">Delete</a>
                        </td>
                     <%--</c:if>--%>
                </tr>
            </c:forEach>

        </table>

    </body>

</html>