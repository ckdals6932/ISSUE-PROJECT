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
		String saveType = "U";
		
		// Insert���� Update���� Ȯ��
		if (reqMap.get("item_seq").equals("")) {
			saveType = "I";
		}
		
		if (saveType == "I") {
			// SEQ �ο�
			reqMap.put("item_seq", this.getItemSeq(reqMap));
			// Code �ο�
			reqMap.put("item_cd", this.getItemCd(reqMap));
		}
		
		if (saveType == "I") {
			comDao.insert("gem_issue.insert_GEM_ITEM", reqMap);
		} else if (saveType == "U") {
			comDao.insert("gem_issue.update_GEM_ITEM", reqMap);
		}
		
		return reqMap;
	}
	

	// ������ �ο�
	public String getItemSeq(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = comDao.select("gem_issue.getItemSeq", reqMap);
		return (String) returnMap.get("item_seq");
	}
	// �ڵ� �ο�
	public String getItemCd(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = comDao.select("gem_issue.getItemCd", reqMap);
		return (String) returnMap.get("item_cd");
	}
}
 