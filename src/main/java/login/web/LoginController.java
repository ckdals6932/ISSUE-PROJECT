package login.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import login.service.LoginService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {

	//LoginService loginService = new LoginService();
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		System.out.println("test");
		return "login";
	}

	@RequestMapping(value = "/userAddPopup.view", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "userAddPopup";
	}
}
