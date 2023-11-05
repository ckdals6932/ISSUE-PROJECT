package cmmn.common.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cmmn.common.service.CommonService;
import sys.auth.service.AuthService;


/**
 * Handles requests for the application home page.
 */
@Controller("commonController")
public class CommonController {

	@Resource(name = "commonService")
	private CommonService commonService;
	
	@ResponseBody
	@RequestMapping(value = "/cmmn/common/changePage.json", method = {RequestMethod.POST, RequestMethod.GET})
	public String 권한화면(@RequestParam HashMap<String, Object> reqMap, Model model) throws Exception {
		String returnPage = commonService.changePage(reqMap);
		return returnPage;
	}
}
