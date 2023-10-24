package cmmn.login.web;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cmmn.login.service.LoginService;


/**
 * Handles requests for the application home page.
 */
@Controller("loginController")
public class LoginController {

	@Resource(name = "loginService")
	private LoginService loginService;
	
	@RequestMapping(value = "/cmmn/login/login.view", method = {RequestMethod.POST, RequestMethod.GET})
	public String login(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/login";
	}

	@RequestMapping(value = "/cmmn/login/userAddPopup.view", method = {RequestMethod.POST, RequestMethod.GET})
	public String userAdd(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/userAddPopup";
	}

	@RequestMapping(value = "/cmmn/login/loginUser.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String loginUser(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		HashMap<String, Object> result = loginService.loginUser(reqMap);
		model.addAttribute("loginInfo", result);
		return "jsonTemplate";
	}
	
}
