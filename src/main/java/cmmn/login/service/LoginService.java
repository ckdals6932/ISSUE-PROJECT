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
		// ����� ID�� �����ϴ��� Ȯ��
		if (!userInfo.isEmpty()) {
			returnMap.put("idError", "N");
		} else {
			returnMap.put("idError", "Y");
		}
		
		// �α��� ���� Ƚ���� 5�� �̻����� üũ
		if (Integer.valueOf(userInfo.get("login_fail_cnt").toString()) < 5) {
			returnMap.put("failCntError", "N");
		} else {
			returnMap.put("failCntError", "Y");
		}
		
		// ��й�ȣ�� ������ Ȯ��
		if (!userInfo.isEmpty() && reqMap.get("userPw").equals(userInfo.get("password"))) {
			returnMap.put("pwError", "N");
		} else {
			returnMap.put("pwError", "Y");
		}
		
		
		
		// ��й�ȣ Ʋ��
		if (returnMap.get("pwError").equals("Y")) {
			mapSQL.put("loginFailCnt", Integer.valueOf(userInfo.get("login_fail_cnt").toString()) + 1);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		// �α��� ���� (login_fail_cnt �ʱ�ȭ)
		if (returnMap.get("idError").equals("N") && returnMap.get("pwError").equals("N")) {
			mapSQL.put("loginFailCnt", 0);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		
		return returnMap;
	}
	
}
 