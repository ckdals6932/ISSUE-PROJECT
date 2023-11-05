package sys.code.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmmn.common.dao.CommonDAO;


/**
 * Handles requests for the application home page.
 */
@Service("CodeService")
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
   
   public HashMap<String, Object> userSave(HashMap<String, Object> reqMap) throws Exception {
      HashMap<String, Object> returnMap = new HashMap<String, Object>();
      HashMap<String, Object> sqlMap = new HashMap<String, Object>();
      String saveType = "U";
      
      // Insert인지 Update인지 확인
      if (reqMap.get("user_seq").equals("")) {
         saveType = "I";
      }
      
      // Validation
      sqlMap.put("user_id", reqMap.get("user_id"));
      HashMap<String, Object> userInfo = comDao.select("cmmn_login.select_SYS_USER", sqlMap);
      if (saveType == "I" && userInfo != null) {
         returnMap.put("user_id_error", "Y");
         return returnMap;
      }
      
      // 데이터 변환
      if (reqMap.get("phone").equals("") == false) {
         reqMap.put("phone", reqMap.get("phone").toString().replaceAll("-", ""));         
      }
      if (reqMap.get("birth_dt").equals("") == false) {
         reqMap.put("birth_dt", reqMap.get("birth_dt").toString().replaceAll("-", ""));      
      }
      
      if (saveType == "I") {
         comDao.insert("sys_user.insert_SYS_USER", reqMap);
         returnMap.put("save", "Y");
      } else if (saveType == "U") {
         comDao.insert("sys_user.update_SYS_USER", reqMap);
         returnMap.put("save", "Y");
      }
      
      return returnMap;
   }
}
 