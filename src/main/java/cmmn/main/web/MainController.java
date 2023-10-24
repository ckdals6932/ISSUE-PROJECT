package cmmn.main.web;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cmmn.main.service.MainService;


/**
 * Handles requests for the application home page.
 */
@Controller("mainController")
public class MainController {

	@Resource(name = "mainService")
	private MainService mainService;
	
	@RequestMapping(value = "/cmmn/main/main.view", method = RequestMethod.GET)
	public String main(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		model.addAttribute("page","WEB-INF/jsp/cmmn/main/main.jsp");
		return "cmmn/main/main";
	}
	
	
}
