package sys.code.web;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import sys.code.service.CodeService;


/**
 * Handles requests for the application home page.
 */
@Controller("CodeController")
public class CodeController {

	@Resource(name = "CodeService")
	private CodeService CodeService;
	

	@RequestMapping(value = "/sys/code/code.view", method = RequestMethod.GET)
	public String userInfo(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/sys/code/code.jsp");
		return "/sys/code/code";
	}
	
	@RequestMapping(value = "/sys/code/codeGroupSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String codeGroupSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = CodeService.codeGroupSearch(reqMap);
		model.addAttribute("codeInfo", result);
		return "jsonTemplate";
	}
	
	@RequestMapping(value = "/sys/code/codeSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String codeSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = CodeService.codeSearch(reqMap);
		model.addAttribute("codeInfo", result);
		return "jsonTemplate";
	}
	
}
