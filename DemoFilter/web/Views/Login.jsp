
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Login Form</h1>
        <h1 style="color:red">${fail}</h1>
        <form action="Login" method="post">
            Username: <input type="text" name="username" value="abc" placeholder="Enter your username"> <br>
            Password: <input type="text" name="password" value="123" placeholder="Enter your password"> <br>
            Roll: <input type="number" name="r" min="0" max="100" value="0">
            <input type="submit" name="btnLogin" value="Login"/>
        </form>
    </body>
</html>
