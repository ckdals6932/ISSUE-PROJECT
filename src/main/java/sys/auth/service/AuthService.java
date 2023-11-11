package sys.auth.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;

import cmmn.common.dao.CommonDAO;
import cmmn.common.service.CommonService;


/**
 * Handles requests for the application home page.
 */
@Service("authService")
public class AuthService {
	
	@Resource(name = "commonDAO")
	private CommonDAO comDao;

	@Resource(name = "commonService")
	private CommonService commonService;
	
	public List<HashMap<String, Object>> authSearch(HashMap<String, Object> reqMap) throws Exception {
		List<HashMap<String, Object>> authInfo = comDao.list("sys_auth.select_SYS_AUTH", reqMap);
		
		return authInfo;
	}
	
	public HashMap<String, Object> authSave(HashMap<String, Object> reqMap, MultiValueMap<String, Object> reqList) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> dataList = commonService.getGridColDatas(reqList);
		reqMap.put("data_list", dataList);
		
		comDao.delete("sys_auth.delete_SYS_AUTH", reqMap);
		comDao.insert("sys_auth.insert_SYS_AUTH", reqMap);
		returnMap.put("save", "Y");
		
		return returnMap;
	}
}
 