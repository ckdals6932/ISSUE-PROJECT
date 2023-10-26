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
		// ����� ID�� �����ϴ��� Ȯ��
		if (userInfo == null) {
			returnMap.put("id_error", "Y");
			return returnMap;
		}
		
		// �α��� ���� Ƚ���� 5�� �̻����� üũ
		if (Integer.valueOf(userInfo.get("login_fail_cnt").toString()) > 5) {
			returnMap.put("fail_cnt_error", "Y");
		}
		// ��й�ȣ�� ������ Ȯ��
		if (!reqMap.get("user_pw").equals(userInfo.get("password"))) {
			returnMap.put("pw_error", "Y");
		}
		// ���Ե� �������� Ȯ��
		if (!userInfo.get("status_cd").equals("IN")) {
			returnMap.put("status_error", "Y");
		}
		
		
		
		// �α��� ����
		if (returnMap == null && !userInfo.get("status_cd").equals("IN")) {
			mapSQL.put("login_fail_cnt", Integer.valueOf(userInfo.get("login_fail_cnt").toString()) + 1);
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		} else {
			// �α��� ���� (login_fail_cnt �ʱ�ȭ)
			mapSQL.put("login_fail_cnt", "0");
			comDao.update("cmmn_login.update_SYS_USER", mapSQL);
		}
		
		return returnMap;
	}
	
}
 