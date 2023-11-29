package sys.notice.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("noticeService")
public class NoticeService {
   
   @Resource(name = "commonDAO")
   private CommonDAO comDao;
    
   public List<HashMap<String, Object>> noticeSearch(HashMap<String, Object> reqMap) throws Exception {
	      List<HashMap<String, Object>> noticeInfo = comDao.list("sys_board.select_SYS_BOARD", reqMap);
	      
	      return noticeInfo; 
   }
   
   public HashMap<String, Object> noticeSave(HashMap<String, Object> reqMap) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> sqlMap = new HashMap<String, Object>();
		
		String saveType = "U";
		
		// Insert인지 Update인지 확인
		if (reqMap.get("board_seq").equals("")) {
			saveType = "I";
		}
		if (reqMap.get("delYn").equals("Y")) {
			saveType = "D";
		}
		
		// Validation
		sqlMap.put("auth_cd", reqMap.get("auth_cd"));
		HashMap<String, Object> boardInfo = comDao.select("sys_board.select_SYS_BOARD", sqlMap);
		if (saveType == "I" && boardInfo != null) {
			returnMap.put("auth_cd_error", "Y");
			return returnMap;
		}
		
		if (saveType == "I") {
			comDao.insert("sys_board.insert_SYS_BOARD", reqMap);
			returnMap.put("save", "Y");
		} else if (saveType == "U") {
			comDao.insert("sys_board.update_SYS_BOARD", reqMap);
			returnMap.put("save", "Y");
		} else if (saveType == "D") {
			comDao.insert("sys_board.delete_SYS_BOARD", reqMap);
			returnMap.put("save", "Y");
		}
		
		return returnMap;
	}
}
 