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
		HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", reqMap);
		
		return userInfo;
	}
	
	public HashMap<String, Object> loginUser(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> mapSQL = new HashMap<String, Object>();
		mapSQL.put("user_id", reqMap.get("user_id"));
		HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", mapSQL);
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		// 사용자 ID가 존재하는지 확인
		if (userInfo == null) {
			returnMap.put("id_error", "Y");
			return returnMap;
		}
		
		// 로그인 실패 횟수가 5번 이상인지 체크
		if (Integer.valueOf(userInfo.get("login_fail_cnt").toString()) > 5) {
			returnMap.put("fail_cnt_error", "Y");
		}
		// 비밀번호가 같은지 확인
		if (!reqMap.get("user_pw").equals(userInfo.get("password"))) {
			returnMap.put("pw_error", "Y");
		}
		// 투입된 상태인지 확인
		if (!userInfo.get("status_cd").equals("IN")) {
			returnMap.put("status_error", "Y");
		}
		
		
		
		// 로그인 실패
		if (returnMap == null && !userInfo.get("status_cd").equals("IN")) {
			mapSQL.put("login_fail_cnt", Integer.valueOf(userInfo.get("login_fail_cnt").toString()) + 1);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		} else {
			// 로그인 성공 (login_fail_cnt 초기화)
			mapSQL.put("login_fail_cnt", "0");
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		
		return returnMap;
	}
	
}
 