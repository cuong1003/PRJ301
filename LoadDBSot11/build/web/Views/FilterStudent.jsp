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
        <h1>Filter Student</h1>
        <form action="FilterStudent" method="post" id="frmFilter">
            <select name='sltDept' onchange="myfun()">
                <option value='All' ${FDeptId.equals('All') ? 'selected' : ''}>All</option>
                <c:forEach items="${dao.dept}" var="de">
                    <option value = '${de.id}' ${FDeptId.equals(de.id)?"selected":"" }>${de.name}</option>
                </c:forEach>
            </select>
            <input type="submit" name="btnFilter" hidden value="Filter" id="btnFilter"/>
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
                    <c:if test="${requestScope.FDeptId.equals('All')||requestScope.FDeptId.equals(st.departId)}">
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
                    </c:if>
                </tr>
            </c:forEach>

        </table>

    </body>

</html>