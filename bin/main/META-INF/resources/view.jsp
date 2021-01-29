<%@ include file="init.jsp"%>
<portlet:defineObjects />
<%

EmployeeLocalService employeeLocalServic = (EmployeeLocalService)request.getAttribute("EmployeeLocalService");
%>
<%
	List<Employee> employee = employeeLocalServic.getEmployees(0,
			employeeLocalServic.getEmployeesCount());
%>
<liferay-portlet:renderURL var="addEmployee">
	<portlet:param name="jspPage" value="/addEmployee.jsp" />
</liferay-portlet:renderURL>

<aui:button type="submit" name="" value="addEmployee"
	onClick="<%=addEmployee%>" />
<br>
<br>
<br>

<table class="myTable3">
	<tr class="myTable3">
		<th class="myTable">Name</th>
		<th class="myTable">Number</th>
		<th class="myTable1">Edit</th>
		<th class="myTable1">Delete</th>
	</tr>
	<%
		for (Employee st : employee) {
	%>
	<tr class="myTable3">
		<td class="myTable"><%=st.getName()%></td>
		<td class="myTable"><%=st.getNumber()%></td>

		<liferay-portlet:renderURL var="editEmployee">
			<portlet:param name="jspPage" value="/addEmployee.jsp" />
			<portlet:param name="id" value="<%=String.valueOf(st.getId())%>" />
		</liferay-portlet:renderURL>

		<portlet:actionURL name="deleteEmployee" var="deleteEmployeeActionURL">
			<portlet:param name="id" value="<%=String.valueOf(st.getId())%>" />
		</portlet:actionURL>

		<td class="myTable1"><aui:button name="" value="Update"
				onClick="<%=editEmployee%>"></aui:button></td>

		<td class="myTable1"><aui:button name="" value="Delete"
				onClick="<%=deleteEmployeeActionURL%>"></aui:button></td>

	</tr>
	<%
		}
	%>

</table>
<br>
<br>

