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
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/messages_zh.js"></script>
    <%--引入BootStrap样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<%--    <script type="text/javascript" src="${APP_PATH}/static/js/my.js"></script>--%>
</head>
<body>

<%--添加员工的模态框--%>
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" name="empName" class="form-control" id="empName_input" placeholder="姓名">
                            <span class="help-block" id="emp_name_info"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="email" name="empEmail" class="form-control" id="empEmail_input" placeholder="邮箱">
                            <span class="help-block" id="emp_email_info"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-8">
                            <input type="text" name="empAge" class="form-control" id="empAge_input" placeholder="年龄">
                            <span class="help-block" id="emp_age_info"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="emp_gender1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="emp_gender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">添加员工</button>
            </div>
        </div>
    </div>
</div>

<%--修改员工的模态框--%>
<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="email" name="empEmail" class="form-control" id="empEmail_update" placeholder="邮箱">
                            <span class="help-block" id="update_emp_email_info"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-8">
                            <input type="text" name="empAge" class="form-control" id="empAge_update" placeholder="年龄">
                            <span class="help-block" id="update_emp_age_info"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="emp_gender1_update" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="emp_gender2_update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新员工</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
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
    var totalRecord, updateEmpId, currPage, pageSize;
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
            var checkboxTd = $("<td><input type='checkbox' class='check_item'></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empAgeTd = $("<td></td>").append(item.empAge);
            var empGenderTd = $("<td></td>").append(item.empGender == 'M'?'男':'女');
            var empEmailTd = $("<td></td>").append(item.empEmail);
            var empDeptTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("  编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("  删除");
            var empOperTd = $("<td></td>")
                .append(editBtn)
                .append(" ")
                .append(deleteBtn);
            $("<tr></tr>")
                .append(checkboxTd)
                .append(empIdTd)
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
        totalRecord = result.extend.pageInfo.total;
        currPage = result.extend.pageInfo.pageNum;
        pageSize = result.extend.pageInfo.pageSize;
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

    //点击新增按钮弹出新增员工的模态框
    $("#emp_add_modal").click(function () {
        //弹出之前重置表单
        $("#addEmpModal form")[0].reset();
        var validator = $("#addEmpModal form").validate();
        validator.resetForm();
        getDepts("#addEmpModal select");
        $("#addEmpModal").modal({
            backdrop:"static",
            keyboard:true
        });
    });

    //获取当前部门的列表
    function getDepts(ele) {
        $.ajax({
            url:"${APP_PATH}/getdepts",
            type:"GET",
            success:function (result) {
                $(ele).empty();
                $.each(result.extend.deptInfo, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                    $(ele).append(optionEle);
                });
            }
        });
    }

    $("#addEmpModal button:eq(2)").click(function () {
        if ( $(this).attr("validateStatus")=="failed"){
            return;
        }
        addEmp();
    });

    //添加员工的ajax请求
    function addEmp() {
        // validateEmpInfo();
        if (!$("#addEmpModal form").valid()){
            alert("输入的信息有误，请检查！");
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#addEmpModal form").serialize(),
            success:function (result) {
                if (result.code == 200){
                    if (result.extend.errorFields.empEmail != undefined){
                        $("#emp_email_info").append(result.extend.errorFields.empEmail);
                    }
                    if (result.extend.errorFields.empName != undefined){
                        $("#emp_name_info").append(result.extend.errorFields.empName);
                    }
                    if (result.extend.errorFields.empAge != undefined){
                        $("#emp_age_info").append(result.extend.errorFields.empAge);
                    }
                } else {
                    alert(result.msg);
                    $("#addEmpModal").modal("hide");
                    to_page(totalRecord);
                }
            }
        });
    }

    //对新增员工的信息进行校验
    $("#addEmpModal form").validate({
        rules:{
            empName:{
                required:true,
                maxlength:15,
                minlength:2
            },
            empEmail:{
                email:true
            },
            empAge:{
                max:80,
                min:18
            }
        },messages:{
            empName:{
                required:"请输入员工姓名",
                maxlength:"姓名不可超过15字符",
                minlength:"姓名最少需要2个字符"
            },
            empEmail:{
                email:"请输入正确的邮箱"
            },
            empAge:{
                max:"年龄最大不超过80岁",
                min:"年龄最小不低于18岁"
            }
        }
    });

    //对修改员工的信息进行校验
    $("#updateEmpModal form").validate({
        rules:{
            empName:{
                required:true,
                maxlength:15,
                minlength:2
            },
            empEmail:{
                email:true
            },
            empAge:{
                max:80,
                min:18
            }
        },messages:{
            empName:{
                required:"请输入员工姓名",
                maxlength:"姓名不可超过15字符",
                minlength:"姓名最少需要2个字符"
            },
            empEmail:{
                email:"请输入正确的邮箱"
            },
            empAge:{
                max:"年龄最大不超过80岁",
                min:"年龄最小不低于18岁"
            }
        }
    });

    //验证用户名是否重用
    $("#empEmail_input").change(function () {
        var empEmail = this.value;
        //发送ajax请求检验员工邮箱名是否可用
        $.ajax({
            url:"${APP_PATH}/checkemail",
            data:"empEmail="+empEmail,
            type:"POST",
            success:function (result) {
                if ($("#addEmpModal form").valid()) {
                    $("#emp_email_info").empty();
                    if (result.code == 100) {
                        $("#emp_save_btn").attr("validateStatus","success");
                        $("#emp_email_info").append("邮箱可用");
                    }else {
                        $("#emp_save_btn").attr("validateStatus","failed");
                        $("#emp_email_info").append("邮箱已被占用");
                    }
                }
            }
        });
    });

    $("#emps_table").on("click","tbody .edit_btn", function () {
        getDepts("#updateEmpModal select");
        updateEmpId = $(this).parents("tr").find("td").eq(1).text();
        getEmp(updateEmpId);
        //弹出之前重置表单
        $("#updateEmpModal form")[0].reset();
        var validator = $("#updateEmpModal form").validate();
        validator.resetForm();
        getDepts();
        $("#updateEmpModal").modal({
            backdrop:"static",
            keyboard:true
        });
    });

    //获取某个员工的信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                var empData = result.extend.empInfo;
                $("#empName_update_static").text(empData.empName);
                $("#empEmail_update").val(empData.empEmail);
                $("#empAge_update").val(empData.empAge);
                $("#updateEmpModal input[name=empGender]").val([empData.empGender]);
                $("#updateEmpModal select").val([empData.dId]);
            }
        });
    }

    $("#emp_update_btn").click(function () {
        if ( $(this).attr("validateStatus")=="failed"){
            return;
        }
        updateEmp(updateEmpId);
    });

    $("#empEmail_update").change(function () {
        var empEmail = this.value;
        //发送ajax请求检验员工邮箱名是否可用
        $.ajax({
            url:"${APP_PATH}/checkemail",
            data:"empEmail="+empEmail,
            type:"POST",
            success:function (result) {
                if ($("#updateEmpModal form").valid()) {
                    $("#update_emp_email_info").empty();
                    if (result.code == 100) {
                        $("#emp_update_btn").attr("validateStatus","success");
                        $("#update_emp_email_info").append("邮箱可用");
                    }else {
                        $("#emp_update_btn").attr("validateStatus","failed");
                        $("#update_emp_email_info").append("邮箱已被占用");
                    }
                }
            }
        });
    });

    function updateEmp(id) {
        if (!$("#addEmpModal form").valid()){
            alert("输入的信息有误，请检查！");
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"PUT",
            data:$("#updateEmpModal form").serialize(),
            success:function (result) {
                if (result.code == 200){
                    if (result.extend.errorFields.empEmail != undefined){
                        $("#emp_email_info").append(result.extend.errorFields.empEmail);
                    }
                    if (result.extend.errorFields.empName != undefined){
                        $("#emp_name_info").append(result.extend.errorFields.empName);
                    }
                    if (result.extend.errorFields.empAge != undefined){
                        $("#emp_age_info").append(result.extend.errorFields.empAge);
                    }
                } else {
                    alert(result.msg);
                    $("#updateEmpModal").modal("hide");
                    to_page(currPage);
                }
            }
        });
    }

    //删除单个员工的绑定事件
    $("#emps_table").on("click","tbody .delete_btn", function () {
        var empId = $(this).parents("tr").find("td").eq(1).text();
        var empName = $(this).parents("tr").find("td").eq(2).text();
        var flag = confirm("确定要删除"+empName+"吗？");
        if (flag){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currPage);
                }
            });
        }
    });
    
    //完成全选全部选
    $("#check_all").click(function () {
        // $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $("#emps_table").on("click",".check_item",function () {
        //判断当前选中的元素和每页的大小是否相同
        if ($(".check_item:checked").length == pageSize) {
            $("#check_all").prop("checked",true);
        }else {
            $("#check_all").prop("checked",false);
        }
    });


    //多选删除
    $("#emp_delete_all_btn").click(function () {
        var empIds = "";
        $.each($(".check_item:checked"), function () {
            empIds += $(this).parents("tr").find("td").eq(1).text() + "-";
        });
        if (confirm("确认要删除所勾选的员工信息？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currPage);
                }
            });
        }
    });
</script>

</body>
</html>
