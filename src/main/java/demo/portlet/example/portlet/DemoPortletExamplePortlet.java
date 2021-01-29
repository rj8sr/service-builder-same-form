package demo.portlet.example.portlet;

import com.liferay.counter.kernel.service.CounterLocalService;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.util.ParamUtil;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import demo.portlet.example.constants.DemoPortletExamplePortletKeys;
import example.entity.model.Employee;
import example.entity.service.EmployeeLocalService;

/**
 * @author lenovo
 */
@Component(immediate = true, property = { "com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=DemoPortletExample", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + DemoPortletExamplePortletKeys.DEMOPORTLETEXAMPLE,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class DemoPortletExamplePortlet extends MVCPortlet {
private static Log log = LogFactoryUtil.getLog(DemoPortletExamplePortlet.class);
	@Reference
	private CounterLocalService counterLocalService;

	@Reference
	private EmployeeLocalService employeeLocalService;

	@Override
	public void render(RenderRequest request, RenderResponse response)
	    throws IOException, PortletException {
	    request.setAttribute("EmployeeLocalService", employeeLocalService);
	    super.render(request, response);
	}	
	
	public void addEmployee(ActionRequest request, ActionResponse response) {
		long id = counterLocalService.increment();
		Employee smp = null;
		smp = employeeLocalService.createEmployee(id);
		smp.setName(ParamUtil.getString(request, "name"));
		smp.setNumber(ParamUtil.getInteger(request, "number"));
		employeeLocalService.addEmployee(smp);
		log.info("addedd successfully" + smp);
	}

	public void deleteEmployee(ActionRequest actionRequest, ActionResponse actionResponse) throws PortalException {
		long empId = ParamUtil.getLong(actionRequest, "id");
		Employee empl = employeeLocalService.deleteEmployee(empId);
		if (empl != null) {
			log.info("Student have been deleted successfylly" + empl);
		} else {
			log.info("There is an Erron in delete Student");
		}
	}

	public void updateEmployee(ActionRequest actionRequest, ActionResponse actionResponse)
			throws SystemException, PortalException {
		long empId = ParamUtil.getLong(actionRequest, "id");
		Employee empl = employeeLocalService.getEmployee(empId);
		empl.setName(ParamUtil.getString(actionRequest, "name"));
		empl.setNumber(ParamUtil.getInteger(actionRequest, "number"));
		employeeLocalService.updateEmployee(empl);
		log.info("updated successfully" + empl);
	}

}