<%--
  Created by IntelliJ IDEA.
  User: 13055
  Date: 2019/7/16
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--引入jQuery--%>
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <%--引入BootStrap样式--%>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(function () {
           $("button").click(function () {
               alert(123123123);

           });
        });
    </script>

</head>
<body>
    <button type="button" class="btn btn-success">按钮</button>
</body>
</html>
