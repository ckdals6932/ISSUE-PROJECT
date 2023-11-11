package sys.auth.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cmmn.common.service.CommonService;
import sys.auth.service.AuthService;


/**
 * Handles requests for the application home page.
 */
@Controller("authController")
public class AuthController {

	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "authService")
	private AuthService authService;
	

	@RequestMapping(value = "/sys/auth/auth.view", method = RequestMethod.GET)
	public String 권한화면(@RequestParam HashMap<String, Object> reqMap, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/sys/auth/auth.view");
		return "sys/auth/auth";
	}
	
	@RequestMapping(value = "/sys/auth/authSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String 권한리스트(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = authService.authSearch(reqMap);
		model.addAttribute("data", result);
		return "jsonTemplate";
	}
	
	@RequestMapping(value = "/sys/auth/authSave.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String 권한저장(@RequestParam HashMap<String, Object> reqMap, ModelMap model, @RequestParam MultiValueMap<String, Object> reqList) throws Exception {
		HashMap<String, Object> result = authService.authSave(reqMap, reqList);
		model.addAttribute("authInfo", result);
		return "jsonTemplate";
	}
}
