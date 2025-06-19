<%-- 
    Document   : Demojsp
    Created on : Jun 5, 2025, 8:17:09 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World! JSP - Java Server Pages</h1>
        <!-- Loại 1: Biểu thức JSP -->
        <h2>Loại 1: 1+1 = <%= 1+1%></h2> 
        <p>
            < % = ... % > dấu ... là một giá trị/biểu thức. <br/>
            Cách thức hoạt động: đưa nguyên giá trị ở ... vào out.print(...)
        <p>
        <!-- Loại 2: Scriptlet -->
        <h2>Loại 2: Java code <% int x = 10; %></h2>
        syntax &lt;%...%&gt; dấu ... là một dòng code hoặc một đoạn code java độc lập.
        Nó bê nguyên ... vào trong method _jspService
        <p>Lưu ý với script-let &lt;%= ...%&gt; và &lt;% ...%&gt; thì nó thực hiện theo thứ tự của scriptlet đều nằm trong _jspService method
            với loại 2 thì nó gọi là khai báo biến cục bộ</p>
        <br/>
        với loại 2 chúng ta vẫn có thể như sau
        <% out.write("<h1>Welcome PRJ301 - JSP file</h1>");%>
        <!-- Loại 3: Khai báo phương thức hoặc biến toàn cục -->
        <h2>Loại 3:  java code nằm ngoài _jspService method
            <%! void m1(){int x = 20, y=30;}
                        public static final double PI = 3.14;%></h2>
        <p>Lưu ý: Loại 3 không tuân theo thứ tự, đôi khi scriptlet được gọi là khai báo biến toàn cục hoặc định nghĩa method mới</p>
        <!-- Loại 4: Các điều hướng -->
        <h2>Loại 4: các điều hướng < %@ ... % ></h2>
        <p> với các điều hướng thì nó có thể nằm ngoài _jspService method cũng như nằm ngoài class servlet,
            nó có thể nằm ở trong import, có thể nằm ở phần include, có thể ở page</p>
            <%@page import="java.util.*" %>
    </body>
</html>