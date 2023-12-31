package cmmn.login.web;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cmmn.common.vo.LoginUserVO;
import cmmn.login.service.LoginService;


/**
 * Handles requests for the application home page.
 */
@Controller("loginController")
public class LoginController {

	@Resource(name = "loginService")
	private LoginService loginService;
	
	@RequestMapping(value = "/cmmn/login/login.view", method = {RequestMethod.POST, RequestMethod.GET})
	public String login(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/login";
	}

	@RequestMapping(value = "/cmmn/login/userAddPopup.view", method = {RequestMethod.POST, RequestMethod.GET})
	public String userAdd(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/cmmn/login/login.jsp");
		return "cmmn/login/userAddPopup";
	}

	@RequestMapping(value = "/cmmn/login/loginUser.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String loginUser(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		HashMap<String, Object> result = loginService.loginUser(reqMap);
		String forwardURL = "";
		
		if (result.get("login").equals("Y")) {
			session.setAttribute("loginUser", loginService.getUserData(reqMap));
			forwardURL = this.success(request, response, reqMap, model);
		}
		
		model.addAttribute("loginInfo", result);
		model.addAttribute("forwardURL", forwardURL);
		return "jsonTemplate";
	}
	
	public String success(HttpServletRequest request, HttpServletResponse response, @RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		String forwardURL = "";
		
		try {
			HttpSession session = request.getSession();
			if (session != null) {
				if (session.getAttribute("loginUser") != null) {
					LoginUserVO loginUser = (LoginUserVO)session.getAttribute("loginUser");
					session.setAttribute("user_id", loginUser.getUserId());
					session.setAttribute("login_user_seq", loginUser.getUserSeq());
					session.setAttribute("login_user_nm", loginUser.getUserNm());
					session.setAttribute("login_user_auth", loginUser.getAuthCd());
				}
				
				forwardURL = "redirect:/cmmn/main/main.view";
			}
		} catch(Exception e) {
			System.out.println(e);
			forwardURL = "/login.view";
		}
		
		return forwardURL;
	}
}
