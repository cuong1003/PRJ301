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
        
    </head>
    <body>
        <h1>Student Information</h1>
        
        <!-- gender true/false -->
        <h3 style="border-top-style: solid;border-top-width:2px">Gender true/false</h3>
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
                <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                    <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                    
                </tr>
            </c:forEach>
        </table>
        <hr><!-- comment -->
        <form action='LoadDB_jsp' method='post'>
            Id: <input type='text' name='txtId' value='${stUpdate==null?"":stUpdate.id}'/><br/>
            
            Name: <input type='text' name='txtName' value='${stUpdate==null?"":stUpdate.name}'><br/>
            
            Gender: <input type='checkbox' name='chkGender' value='M'
                           ${(stUpdate!=null&&stUpdate.gender)?"checked":""}>Male/Female<br/>
            
            Department: <select name='sltDept'>
                <c:forEach items="${dao.dept}" var = "de">
                    <option value="${de.id}" 
                            ${(stUpdate!=null&&stUpdate.departId.equals(de.id))
                                     ?"selected":""}>${de.name}</option>
                </c:forEach>
            </select> <br/> 
            
            Dob: <input type='date' name='datDob' value='${stUpdate==null?"":stUpdate.dob}'><br/> 
            
            Gpa: <input type='text' name='txtGpa' value='${stUpdate==null?"":stUpdate.gpa}'><br/>
            
            <input type='submit' name='btnInsert' value='Insert'/>
            <input type='submit' name='btnUpdate' value='Update'/>
        </form>
        
            <h3 style="border-top-style: solid;border-top-width:2px">Gender Male/Female - <span class="sp text-success">BTVN SLOT8</span> </h3>
        <!-- gender true/false -->
        <table>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Dob</th>
                <th>Gpa</th>   
            </tr>
            <c:forEach items="${dao.std}" var ="st">
                <tr>
                <td>${st.id}</td>
                <td>${st.name}</td>
                <td>${st.gender?'Male':'Female'}</td>
                <td>${dao.GetDeptName(st.departId)}</td>
                <td>${st.dob}</td>
                <td>${st.gpa}</td>                    
                </tr>
            </c:forEach>
        </table>
        <h3 style="border-top-style: solid;border-top-width:2px">Gender CheckBox - <span class="sp text-success">BTVN SLOT8</span></h3>
        <!-- gender true/false -->
        <table>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Dob</th>
                <th>Gpa</th>   
            </tr>
            <c:forEach items="${dao.std}" var ="st">
                <tr>
                <td>${st.id}</td>
                <td>${st.name}</td>
                <td><input type="checkbox" id="" name="" ${st.gender?'checked':''}>Male
                <input type="checkbox" id="" name=""${st.gender?'':'checked'}>Female</td>
                <td>${dao.GetDeptName(st.departId)}</td>
                <td>${st.dob}</td>
                <td>${st.gpa}</td>                    
                </tr>
            </c:forEach>
        </table>
        <h3 style="border-top-style: solid;border-top-width:2px">Gender Radio - <span class="sp text-success">BTVN SLOT8</span></h3>
        <!-- gender true/false -->
        <table>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Dob</th>
                <th>Gpa</th>   
            </tr>
            <c:forEach items="${dao.std}" var ="st">
                <tr>
                <td>${st.id}</td>
                <td>${st.name}</td>
                <td><input type="radio" id="" name="${st.id}" ${st.gender?'checked':''}>Male
                <input type="radio" id="" name="${st.id}" ${!st.gender?'checked':''}>Female</td>
                <td>${dao.GetDeptName(st.departId)}</td>
                <td>${st.dob}</td>
                <td>${st.gpa}</td>                    
                </tr>
            </c:forEach>
        </table>
        <h3 style="border-top-style: solid;border-top-width:2px">Gender Combobox - <span class="sp text-success">BTVN SLOT8</span></h3>
        <!-- gender true/false -->
        <table>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Department</th>
                <th>Dob</th>
                <th>Gpa</th>   
            </tr>
            <c:forEach items="${dao.std}" var ="st">
                <tr>
                <td>${st.id}</td>
                <td>${st.name}</td>
                <td>
                    <select>
                        <option value="" ${st.gender ? 'selected' : ''}>Male</option>
                        <option value="" ${!st.gender ? 'selected' : ''}>Female</option>
                    </select>
                </td>
                <td>${dao.GetDeptName(st.departId)}</td>
                <td>${st.dob}</td>
                <td>${st.gpa}</td>                    
                </tr>
            </c:forEach>
        </table>
        <h3 style="border-top-style: solid;border-top-width:2px">Gender form radio - <span class="sp text-success">BTVN SLOT9</span></h3>
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
                <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                    <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                    
                </tr>
            </c:forEach>
        </table>
        <hr><!-- comment -->
        <form action='LoadDB_jsp' method='post'>
            Id: <input type='text' name='txtId' value='${stUpdate==null?"":stUpdate.id}'/><br/>
            
            Name: <input type='text' name='txtName' value='${stUpdate==null?"":stUpdate.name}'><br/>
            
            Gender: <input style='margin-left: 10px' type='radio' name='chkGender' value='M'
                           ${(stUpdate!=null&&stUpdate.gender)?"checked":""}>Male
                    <input style='margin-left: 10px' type='radio' name='chkGender' value='F'
                           ${(stUpdate!=null&&stUpdate.gender)?"checked":""}>Female<br/>
            
            Department: <select name='sltDept'>
                <c:forEach items="${dao.dept}" var = "de">
                    <option value="${de.id}" 
                            ${(stUpdate!=null&&stUpdate.departId.equals(de.id))
                                     ?"selected":""}>${de.name}</option>
                </c:forEach>
            </select> <br/> 
            
            Dob: <input type='date' name='datDob' value='${stUpdate==null?"":stUpdate.dob}'><br/> 
            
            Gpa: <input type='text' name='txtGpa' value='${stUpdate==null?"":stUpdate.gpa}'><br/>
            
            <input type='submit' name='btnInsert' value='Insert'/>
            <input type='submit' name='btnUpdate' value='Update'/>
        </form>
        <h3 style="border-top-style: solid;border-top-width:2px">Gender form combobox - <span class="sp text-success">BTVN SLOT9</span></h3>
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
                <td><a href="LoadDB_jsp?type=0&id=${st.id}" class="btn btn-primary">Update</a>
                    <a href="LoadDB_jsp?type=1&id=${st.id}" class="btn btn-danger">Delete</a></td>
                    
                </tr>
            </c:forEach>
        </table>
        <hr><!-- comment -->
        <form action='LoadDB_jsp' method='post'>
            Id: <input type='text' name='txtId' value='${stUpdate==null?"":stUpdate.id}'/><br/>
            
            Name: <input type='text' name='txtName' value='${stUpdate==null?"":stUpdate.name}'><br/>
            
            Gender: <select name='chkGender'>
                        <option value="">>--Choose your sex--<</option>
                        <option value="M" ${(stUpdate!=null&&stUpdate.gender)?"selected":""}>Male</option>
                        <option value="F" ${(stUpdate!=null&&stUpdate.gender)?"selected":""}>Female</option>
            </select><br>
            
            Department: <select name='sltDept'>
                <c:forEach items="${dao.dept}" var = "de">
                    <option value="${de.id}" 
                            ${(stUpdate!=null&&stUpdate.departId.equals(de.id))
                                     ?"selected":""}>${de.name}</option>
                </c:forEach>
            </select> <br/> 
            
            Dob: <input type='date' name='datDob' value='${stUpdate==null?"":stUpdate.dob}'><br/> 
            
            Gpa: <input type='text' name='txtGpa' value='${stUpdate==null?"":stUpdate.gpa}'><br/>
            
            <input type='submit' name='btnInsert' value='Insert'/>
            <input type='submit' name='btnUpdate' value='Update'/>
        </form>
    </body>
</html>
