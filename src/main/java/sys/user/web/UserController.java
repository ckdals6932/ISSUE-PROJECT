package sys.user.web;

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

import sys.user.service.UserService;


/**
 * Handles requests for the application home page.
 */
@Controller("UserController")
public class UserController {

	@Resource(name = "UserService")
	private UserService userService;
	

	@RequestMapping(value = "/sys/user/user.view", method = RequestMethod.GET)
	public String userInfo(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/sys/user/user.jsp");
		return "/sys/user/user";
	}
	
	@RequestMapping(value = "/sys/user/userSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String userSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = userService.userSearch(reqMap);
		model.addAttribute("userInfo", result);
		return "jsonTemplate";
	}
}
