package cmmn.main.service;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("mainService")
public class MainService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;
	
	public List<HashMap<String, Object>> noticeSearch(HashMap<String, Object> reqMap) throws Exception {
	      List<HashMap<String, Object>> noticeInfo = comDao.list("cmmn_main.select_SYS_BOARD", reqMap);
	      
	      return noticeInfo; 
	}
	
	public List<HashMap<String, Object>> userSearch(HashMap<String, Object> reqMap) throws Exception {
	      List<HashMap<String, Object>> userInfo = comDao.list("cmmn_main.select_SYS_USER", reqMap);
	      
	      return userInfo; 
	}
	
	public List<HashMap<String, Object>> cntSearch(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> cntInfo = comDao.list("cmmn_main.select_GEM_ITEM", reqMap);
	      
	      return cntInfo; 
	}

}
 