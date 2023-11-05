package cmmn.common.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;


/**
 * Handles requests for the application home page.
 */
@Service("commonService")
public class CommonService {
	
	public String changePage(HashMap<String, Object> reqMap) throws Exception {
		String returnPage = "redirect:" + reqMap.get("page");
		return returnPage;
	}
}
 