<%-- 
    Document   : LoadDB_jsp
    Created on : Jun 5, 2025, 9:18:18 AM
    Author     : c9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
        <script>
            function myfun() {
                document.getElementById(`frmFilter`).submit();
            }
        </script>
    </head>
    <body>
        <h1>Filter Student</h1>
        <div class="FilterArea">
        <form style="display: inline-block" action="FilterStudent" method="post" id="frmFilter">
            Filter: 
            <select name="sltDept" onchange="document.getElementById('frmFilter').submit()">
                <option value="ALL" ${requestScope.FDeptId == 'ALL' ? 'selected' : ''}>All</option>
                <c:forEach items="${dao.dept}" var="de">
                    <option value="${de.id}" ${requestScope.FDeptId == de.id ? 'selected' : ''}>${de.name}</option>
                </c:forEach>                
            </select>
            <select name="logicFilter" onchange="document.getElementById('frmFilter').submit()">
                <option value="AND" ${requestScope.FLogic == 'AND' ? 'selected' : ''}>AND</option>
                <option value="OR" ${requestScope.FLogic == 'OR' ? 'selected' : ''}>OR</option>
            </select>
            <select name="genderFilter" onchange="document.getElementById('frmFilter').submit()">
                <option value="All" ${requestScope.FGender == 'All' ? 'selected' : ''}>All</option>
                <option value="M" ${requestScope.FGender == 'M' ? 'selected' : ''}>Male</option>
                <option value="F" ${requestScope.FGender == 'F' ? 'selected' : ''}>Female</option>
            </select>
        </form>
        </div>
        <h1>Student Information</h1>

        <!-- gender true/false -->
        <hr>
        <h3>Gender true/false</h3>
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
                    <c:choose>
                        <c:when test="${requestScope.FLogic == 'OR' && !requestScope.FDeptId.equals('ALL') && requestScope.FGender != 'All'}">
                            <c:if test="${requestScope.FDeptId.equals(st.departId) || (requestScope.FGender == 'M' && st.gender) || (requestScope.FGender == 'F' && !st.gender)}">
                                <td>${st.id}</td>
                                <td>${st.name}</td>
                                <td>${st.gender ? 'Male' : 'Female'}</td>
                                <td>${dao.GetDeptName(st.departId)}</td>
                                <td>${st.dob}</td>
                                <td>${st.gpa}</td>
                                <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                                    <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${(requestScope.FDeptId.equals('ALL') || requestScope.FDeptId.equals(st.departId)) 
                                      && (requestScope.FGender == 'All'  
                                          || (requestScope.FGender == 'M' && st.gender) 
                                          || (requestScope.FGender == 'F' && !st.gender))}">
                                <td>${st.id}</td>
                                <td>${st.name}</td>
                                <td>${st.gender ? 'Male' : 'Female'}</td>
                                <td>${dao.GetDeptName(st.departId)}</td>
                                <td>${st.dob}</td>
                                <td>${st.gpa}</td>
                                <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                                    <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
        <h1 style="border-top-style: solid;border-top-width:2px">Gender Male/Female - <span class="sp text-success">BTVN SLOT10</span> </h1>
        <form action="FilterStudent" method="post" id="radioFilter">
            Department: <input type="radio" name="radioDept" value="ALL" ${requestScope.FDeptId == 'ALL' ? 'checked' : ''} 
                               onclick="document.getElementById('radioFilter').submit()">ALL</option>
            <c:forEach items="${dao.dept}" var="de">
                <input type="radio" name="radioDept" value="${de.id}" ${requestScope.FDeptId == de.id ? 'checked' : ''} 
                       onclick=document.getElementById('radioFilter').submit()>${de.name}</option>
            </c:forEach><br><!-- comment -->
            <!--<input type="submit" name="btnFilter" value="Filter" id="btnFilter">-->
        </form>
        <form>
        </form>
        <h1>Student Information</h1>

        <hr>
        <h3>Filter Radio-box</h3>
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
                    <c:if test="${requestScope.FDeptId.equals('ALL') 
                                  ||requestScope.FDeptId.equals(st.departId)}">
                          <td>${st.id}</td>
                          <td>${st.name}</td>
                          <td>${st.gender ? 'Male' : 'Female'}</td>
                          <td>${dao.GetDeptName(st.departId)}</td>
                          <td>${st.dob}</td>
                          <td>${st.gpa}</td>
                          <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                              <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                          </c:if>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
