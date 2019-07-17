package com.hk.pojo;

public class Employee {
    private Integer empId;

    private String empName;

    private Integer empAge;

    private String empGender;

    private String empEmail;

    private Integer dId;

//    查询员工时一并查询员工的部门信息
    private Department department;

    public Employee() {
    }

    public Employee(Integer empId, String empName, Integer empAge, String empGender, String empEmail, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.empAge = empAge;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empAge=" + empAge +
                ", empGender='" + empGender + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", dId=" + dId +
                ", department=" + department +
                '}';
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public Integer getEmpAge() {
        return empAge;
    }

    public void setEmpAge(Integer empAge) {
        this.empAge = empAge;
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}