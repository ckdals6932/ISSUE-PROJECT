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
		reqMap.put("userSeq", "70");
		
		HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", reqMap);
		
		return userInfo;
	}
	
	public HashMap<String, Object> loginUser(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> mapSQL = new HashMap<String, Object>();
		mapSQL.put("userId", reqMap.get("userId"));
		HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", mapSQL);
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		// 사용자 ID가 존재하는지 확인
		if (!userInfo.isEmpty()) {
			returnMap.put("idError", "N");
		} else {
			returnMap.put("idError", "Y");
		}
		
		// 로그인 실패 횟수가 5번 이상인지 체크
		if (Integer.valueOf(userInfo.get("login_fail_cnt").toString()) < 5) {
			returnMap.put("failCntError", "N");
		} else {
			returnMap.put("failCntError", "Y");
		}
		
		// 비밀번호가 같은지 확인
		if (!userInfo.isEmpty() && reqMap.get("userPw").equals(userInfo.get("password"))) {
			returnMap.put("pwError", "N");
		} else {
			returnMap.put("pwError", "Y");
		}
		
		
		
		// 비밀번호 틀림
		if (returnMap.get("pwError").equals("Y")) {
			mapSQL.put("loginFailCnt", Integer.valueOf(userInfo.get("login_fail_cnt").toString()) + 1);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		// 로그인 성공 (login_fail_cnt 초기화)
		if (returnMap.get("idError").equals("N") && returnMap.get("pwError").equals("N")) {
			mapSQL.put("loginFailCnt", 0);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		
		return returnMap;
	}
	
}
 