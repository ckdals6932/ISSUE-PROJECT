package sys.auth.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("authService")
public class AuthService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;
	
	public List<HashMap<String, Object>> authSearch(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> authInfo = comDao.list("sys_auth.select_SYS_AUTH", reqMap);
		
		return authInfo;
	}
	
	public HashMap<String, Object> authSave(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		String saveType = "U";
		
		// Insert인지 Update인지 확인
		if (reqMap.get("auth_seq").equals("")) {
			saveType = "I";
		}
		
		if (saveType == "I") {
			comDao.insert("sys_auth.insert_SYS_AUTH", reqMap);
			returnMap.put("save", "Y");
		} else if (saveType == "U") {
			comDao.insert("sys_auth.update_SYS_AUTH", reqMap);
			returnMap.put("save", "Y");
		}
		
		return returnMap;
	}
}
 