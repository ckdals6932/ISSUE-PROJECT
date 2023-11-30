package gem.issue.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;

import cmmn.common.dao.CommonDAO;
import cmmn.common.service.CommonService;
import cmmn.common.vo.LoginUserVO;


/**
 * Handles requests for the application home page.
 */
@Service("issueService")
public class IssueService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;

	@Resource(name = "commonService")
	private CommonService commonService;
	
	public List<HashMap<String, Object>> issueSearch(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> issueInfo = comDao.list("gem_issue.select_GEM_ITEM", reqMap);
		
		return issueInfo;
	}
	
	public HashMap<String, Object> issueSave(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> sqlMap = new HashMap<String, Object>();
		
		String saveType = "U";
		
		// Insert인지 Update인지 확인
		if (reqMap.get("auth_seq").equals("")) {
			saveType = "I";
		}
		if (reqMap.get("delYn").equals("Y")) {
			saveType = "D";
		}
		
		// Validation
		sqlMap.put("auth_cd", reqMap.get("auth_cd"));
		HashMap<String, Object> authInfo = comDao.select("sys_auth.select_SYS_AUTH", sqlMap);
		if (saveType == "I" && authInfo != null) {
			returnMap.put("auth_cd_error", "Y");
			return returnMap;
		}
		
		if (saveType == "I") {
			comDao.insert("sys_auth.insert_SYS_AUTH", reqMap);
			returnMap.put("save", "Y");
		} else if (saveType == "U") {
			comDao.insert("sys_auth.update_SYS_AUTH", reqMap);
			returnMap.put("save", "Y");
		} else if (saveType == "D") {
			comDao.insert("sys_auth.delete_SYS_AUTH", reqMap);
			returnMap.put("save", "Y");
		}
		
		return returnMap;
	}
}
 