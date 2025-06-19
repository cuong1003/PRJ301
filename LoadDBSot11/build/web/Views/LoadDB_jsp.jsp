<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
                    <c:if test="${st.id==requestScope.update}">
                        <c:set var="stUpdate" value="${st}"/>
                    </c:if>
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
                </tr>
            </c:forEach>

        </table>
        <hr/>
        <form action='LoadDB_jsp' method='post'>
            Id: <input type='text' name='txtId' value='${stUpdate==null?"":stUpdate.id}'/><br/>
            Name: <input type='text' name='txtName' value='${stUpdate==null?"":stUpdate.name}'><br/>
            Gender: <input type='checkbox' name='chkGender' value='M'
                           ${(stUpdate!=null&&stUpdate.gender)?"checked":""}>Male/Female<br/>
            Department: <select name='sltDept'>
                <c:forEach items="${dao.dept}" var="de">
                    <option value ="${de.id}"
                            $({stUpdate!=null&&st.Update.departId.equals(de.id))
                            ?"selected":""}>${de.name}</option>"
                </c:forEach>
            </select> <br/> 
            Dob: <input type='date' name='datDob' value='${stUpdate==null?"":stUpdate.dob}'><br/> 
            Gpa: <input type='text' name='txtGpa' value='${stUpdate==null?"":stUpdate.gpa}'><br/>
            <input type='submit' name='btnInsert' value='Insert'/>
            <input type='submit' name='btnUpdate' value='Update'/>
        </form>
    </body>
</html>