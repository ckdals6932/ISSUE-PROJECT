package cmmn.main.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
	
	@RequestMapping(value = "/cmmn/main/noticeSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String noticeSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
      List<HashMap<String, Object>> result = mainService.noticeSearch(reqMap);
      model.addAttribute("noticeInfo", result);
      return "jsonTemplate";
	}
	
	@RequestMapping(value = "/cmmn/main/userSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String userSearch(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
      List<HashMap<String, Object>> result = mainService.userSearch(reqMap);
      model.addAttribute("userInfo", result);
      return "jsonTemplate";
	}
	
	@RequestMapping(value = "/cmmn/main/cntSearch.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String 개수검색(@RequestParam HashMap<String, Object> reqMap, ModelMap model) throws Exception {
		List<HashMap<String, Object>> result = mainService.cntSearch(reqMap);
      model.addAttribute("cntInfo", result);
      return "jsonTemplate";
	}
	
}
