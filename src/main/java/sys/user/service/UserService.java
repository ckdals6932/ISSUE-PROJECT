package sys.user.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("UserService")
public class UserService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;
	
	public HashMap<String, Object> getUserInfo(HashMap<String, Object> reqMap) throws Exception {
		reqMap.put("userSeq", "70");
		
		HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", reqMap);
		
		return userInfo;
	}
	
	public List<HashMap<String, Object>> userSearch(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> userInfo = comDao.list("sys_user.select_SYS_USER", reqMap);
		
		return userInfo;
	}
}
 