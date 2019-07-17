<%--
  Created by IntelliJ IDEA.
  User: 13055
  Date: 2019/7/17
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <!--
        其中的request.getContextPath()是以/开头，不以/结尾
    -->
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--  web路径
        不以/开头的相对路径，寻找资源时是以当前资源的路径为基准。
        以/开头的相对路径，寻找资源时是以服务器的路径（http://localhost:8080）为基准。
    -->
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.7.2.js"></script>
    <%--引入BootStrap样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <%--显示分页相关的信息--%>
    <div class="row">
        <%--分页的文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条的信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        to_page(1);
    });

    function to_page(pageNum) {
        $.ajax({
            url:"${APP_PATH}/getemps/",
            data:"pageNum="+pageNum,
            type:"GET",
            success:function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    //解析显示员工表格
    function build_emps_table(result) {
        //先清空
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empAgeTd = $("<td></td>").append(item.empAge);
            var empGenderTd = $("<td></td>").append(item.empGender == 'M'?'男':'女');
            var empEmailTd = $("<td></td>").append(item.empEmail);
            var empDeptTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("  编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("  删除");
            var empOperTd = $("<td></td>")
                .append(editBtn)
                .append(" ")
                .append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(empAgeTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptTd)
                .append(empOperTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息数据
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("第"+ result.extend.pageInfo.pageNum +"页，总"+ result.extend.pageInfo.pages +"页，共"+ result.extend.pageInfo.total +"条记录")
    }

    //解析显示分页条，并且点击分页可以跳转下一页
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var previousPageLi = $("<li></li>").append($("<a></a>").append("<span></span>").append("&laquo;"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            previousPageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });
            previousPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("<span></span>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if (!result.extend.pageInfo.hasNextPage) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }

        ul.append(firstPageLi).append(previousPageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
               to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        $("#page_nav_area").append(navEle);
    }
</script>

</body>
</html>
