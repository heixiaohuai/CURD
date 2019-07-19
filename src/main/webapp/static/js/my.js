/*
<script type="text/javascript">

var totalRecord;
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
    totalRecord = result.extend.pageInfo.total;
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
    getDepts();
    $("#addEmpModal").modal({
        backdrop:"static",
        keyboard:true
    });
});

//获取当前部门的列表
function getDepts() {
    $.ajax({
        url:"${APP_PATH}/getdepts",
        type:"GET",
        success:function (result) {
            $("#addEmpModal select").empty();
            $.each(result.extend.deptInfo, function (index, item) {
                var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                $("#addEmpModal select").append(optionEle);
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

//对员工的信息进行校验
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

</script>*/
