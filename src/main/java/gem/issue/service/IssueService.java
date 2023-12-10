package gem.issue.service;

import java.util.ArrayList;
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
		List<HashMap<String, Object>> issueInfo = new ArrayList<HashMap<String, Object>>();
		String item_seq = (String) reqMap.get("item_seq");
		if (item_seq == null) {
			issueInfo = comDao.list("gem_issue.list_GEM_ITEM", reqMap);
		} else {
			issueInfo = comDao.list("gem_issue.select_GEM_ITEM", reqMap);
		}
		
		return issueInfo;
	}
	
	public HashMap<String, Object> issueSave(HashMap<String, Object> reqMap) throws Exception {
		String saveType = "U";
		
		// Insert인지 Update인지 확인
		if (reqMap.get("item_seq").equals("")) {
			saveType = "I";
		}
		
		if (saveType == "I") {
			reqMap.put("item_seq", this.getItemSeq(reqMap)); // SEQ 부여
			reqMap.put("item_cd", this.getItemCd(reqMap)); // Code 부여
		}
		
		if (saveType == "I") {
			comDao.insert("gem_issue.insert_GEM_ITEM", reqMap);
		} else if (saveType == "U") {
			comDao.insert("gem_issue.update_GEM_ITEM", reqMap);
		}
		
		if (reqMap.get("owner_user_seq").equals("") == false) {
			comDao.insert("gem_issue.merge_GEM_ITEM_REQUEST", reqMap);
		}
		
		return reqMap;
	}
	

	// 시퀀스 부여
	public String getItemSeq(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = comDao.select("gem_issue.getItemSeq", reqMap);
		return (String) returnMap.get("item_seq");
	}
	// 코드 부여
	public String getItemCd(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = comDao.select("gem_issue.getItemCd", reqMap);
		return (String) returnMap.get("item_cd");
	}

	// 사용자 리스트
	public List<HashMap<String, Object>> getUserList(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> returnList = comDao.list("gem_issue.getUserList", reqMap);
		for(HashMap<String, Object> data: returnList) {
			data.put("text", data.get("user_nm"));
			data.put("value", data.get("user_seq"));
		}
		return returnList;
	}
}
 