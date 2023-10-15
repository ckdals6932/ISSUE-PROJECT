package cmmn.login.web;

import java.util.HashMap;

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
	
	@RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
	public String login(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {	
		
		return "login";
	}

	@RequestMapping(value = "/userAddPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public String userAdd(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		model.addAttribute("userInfo", loginService.getUserInfo(reqMap));
		return "userAddPopup";
	}
}
