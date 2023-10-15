package cmmn.login.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("loginService")
public class LoginService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;
	
	public HashMap<String, Object> getUserInfo(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> userInfo = comDao.select("login.select_SYS_USER", reqMap);
		
		return userInfo;
	}
	
}
 