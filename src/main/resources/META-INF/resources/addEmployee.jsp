<%@ include file="init.jsp"%>
<portlet:defineObjects />
<portlet:actionURL var="addEmployeee" name="addEmployee">
</portlet:actionURL>

<portlet:actionURL name="updateEmployee" var="editEmployeeAction">
</portlet:actionURL>
<%

EmployeeLocalService employeeLocalService = (EmployeeLocalService)request.getAttribute("EmployeeLocalService");
%>
<%
	long empId = ParamUtil.getLong(renderRequest, "id");
	String actionURL = "";
	long id = 0;
	String name = "";
	String number = "";
	String addUpdate = "";
	String valuee = "";
	
	if (empId > 0) {
		actionURL = editEmployeeAction.toString();
		Employee emp = employeeLocalService.getEmployee(empId);
		id = emp.getId();
		name = emp.getName();
		number = String.valueOf(emp.getNumber());
		addUpdate = "Edit Employee :: " + name;
		valuee = "update";
		
		
	} else {
		actionURL = addEmployeee.toString();
		name = null;
		number = null;
		addUpdate = "Add Employee";
		valuee = "add Employee";
		
	}
%>
<h3>
	<%=addUpdate%></h3>
<aui:form action="<%=actionURL%>" method="POST" name="name">
	<aui:input name="id" type="hidden" value="<%=id%>"  >
			
		</aui:input>
	<aui:input name="name" type="text" value="<%=name%>" >
	<aui:validator name="required" />
				<aui:validator name="alphanum" />
	<aui:validator name="maxLength">10</aui:validator>
	</aui:input>
	<aui:input name="number" type="number" value="<%=number%>" >
	<aui:validator name="required"  />
	<aui:validator name="maxLength">10</aui:validator>
	<aui:validator name="number" />
	
	
	</aui:input>
	<aui:input type="submit" value="<%=valuee%>" name=""></aui:input>
</aui:form>










