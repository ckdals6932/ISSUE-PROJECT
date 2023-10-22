package cmmn.login.web;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping(value = "/cmmn/login/login.view", method = RequestMethod.GET)
	// public String login(Locale reqMap, Model model) throws Exception {
	public String login(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/login";
	}

	@RequestMapping(value = "/cmmn/login/userAddPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public String userAdd(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		model.addAttribute("userInfo", loginService.getUserInfo(reqMap));
		
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/userAddPopup";
	}
}
