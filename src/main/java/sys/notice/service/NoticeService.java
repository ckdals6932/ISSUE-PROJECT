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
}
 