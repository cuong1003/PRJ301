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
            
            function sortBy(field) {
                document.getElementById("sortField").value = field;
                document.getElementById("btnSort").click();
            }
        </script>
        <style>
            .sortable-header {
                color: inherit;
                text-decoration: none;
                font-weight: inherit;
                font-size: inherit;
                font-family: inherit;
            }
            .sortable-header:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <h1>Multi Filter</h1>
        <form action="MultiFilter" method="post" id="frmFilter">
            <input type="hidden" name="currentSortField" value="${currentSortField}"/>
            <input type="hidden" name="sortDirection" value="${sortDirection}"/>
            <input type='checkbox' name='All' value='All' 
                   ${deptSlt.contains("All")?"checked":""} onclick="myfun()"/>All<br/>
                <c:forEach items="${dao.dept}" var="de">
                    <input type='checkbox' value='${de.id}' name='chk${de.id}' 
                           ${deptSlt.contains(de.id)?"checked":""} onclick="myfun()"/>${de.name}<br/>
                </c:forEach>
            <input type="submit" name="btnFilter" value="Filter" id="btnFilter"/>
        </form>
                <form id='frmSort' method='post' action='MultiFilter' style="display:none;">
                    <input type="hidden" name="sortField" id="sortField" value="gpa"/>
                    <input type="submit" name="btnSort" value="Sort" id="btnSort"/>
                </form>
        <h1>Student Information</h1>
        <table>
            <tr>
                <th><a href="#" class="sortable-header" onclick="sortBy('id')">Id</a></th> 
                <th><a href="#" class="sortable-header" onclick="sortBy('name')">Name</a></th>
                <th><a href="#" class="sortable-header" onclick="sortBy('gender')">Gender</a></th>
                <th><a href="#" class="sortable-header" onclick="sortBy('department')">Department</a></th>
                <th><a href="#" class="sortable-header" onclick="sortBy('dob')">Dob</a></th>
                <th><a href="#" class="sortable-header" onclick="sortBy('gpa')">Gpa</a></th>
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