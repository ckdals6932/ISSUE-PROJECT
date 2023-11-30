package gem.issue.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cmmn.common.service.CommonService;
import gem.issue.service.IssueService;


/**
 * Handles requests for the application home page.
 */
@Controller("issueController")
public class IssueController {

	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "issueService")
	private IssueService issueService;
	

	@RequestMapping(value = "/gem/issue/issue.view", method = RequestMethod.GET)
	public String 조치사항화면(@RequestParam HashMap<String, Object> reqMap, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/gem/issue/issue.view");
		return "gem/issue/issue";
	}

	@RequestMapping(value = "/gem/issue/issueRegistrationPopup.view", method = RequestMethod.GET)
	public String 조치사항_생성_팝업(@RequestParam HashMap<String, Object> reqMap, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/gem/issue/issueRegistrationPopup.view");
		return "gem/issue/issueRegistrationPopup";
	}
	
	@RequestMapping(value = "/gem/issue/issueSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String 조치사항리스트(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = issueService.issueSearch(reqMap);
		model.addAttribute("data", result);
		return "jsonTemplate";
	}
}
