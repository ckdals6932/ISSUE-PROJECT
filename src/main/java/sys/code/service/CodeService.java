package sys.code.service;

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
@Service("codeService")
public class CodeService {
   
   @Resource(name = "commonDAO")
   private CommonDAO comDao;
   
   public HashMap<String, Object> getUserInfo(HashMap<String, Object> reqMap) throws Exception {
      HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", reqMap);
      
      return userInfo;
   }
   
   public List<HashMap<String, Object>> codeGroupSearch(HashMap<String, Object> reqMap) throws Exception {
      List<HashMap<String, Object>> codeGroupInfo = comDao.list("sys_code.select_SYS_CODE_GROUP", reqMap);
      
      return codeGroupInfo;
   }
   
   public List<HashMap<String, Object>> codeSearch(HashMap<String, Object> reqMap) throws Exception {
      List<HashMap<String, Object>> codeInfo = comDao.list("sys_code.select_SYS_CODE", reqMap);
      
      return codeInfo;
   }
   
   public HashMap<String, Object> codeGroupSave(HashMap<String, Object> reqMap) throws Exception {
      HashMap<String, Object> returnMap = new HashMap<String, Object>();
      HashMap<String, Object> sqlMap = new HashMap<String, Object>();
      System.out.println(reqMap);
	
	 for (Map.Entry<String, Object> entry : reqMap.entrySet()) {
		 String key = entry.getKey(); 
		 Object value = entry.getValue();
		 
		 // 정규표현식을 사용하여 [cd_grp_seq] 부분을 추출
         Pattern pattern = Pattern.compile("\\[([^\\]]+)\\]");
         Matcher matcher = pattern.matcher(key);

         while (matcher.find()) {
             key = matcher.group(1);
         }
		 // key와 value를 사용하여 작업 수행	     
	     System.out.println("key : " + key + " ,  value : " + value);
	     
	     sqlMap.put(key, value);
		 if(key.contains("db_type")) {
			 if("I".equals(value)) {
				 System.out.println("I");
				 List<HashMap<String, Object>> codeGroupInfo = comDao.list("sys_code.insert_SYS_CODE_GROUP", sqlMap);
				 returnMap.put("Insert", "Y");
			 } else if ("U".equals(value)) {
				 System.out.println("U");
				 List<HashMap<String, Object>> codeGroupInfo = comDao.list("sys_code.update_SYS_CODE_GROUP", sqlMap);
				 returnMap.put("Update", "Y");
			 } else if (value == "D") {
				 
			 }
			 sqlMap.clear(); 
		 }
	 } 
      // Insert, Update, Delete 확인
      return returnMap;
   }
}
 