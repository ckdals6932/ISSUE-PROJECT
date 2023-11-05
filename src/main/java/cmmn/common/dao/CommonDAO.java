package cmmn.common.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import cmmn.common.vo.LoginUserVO;

/**
 * Handles requests for the application home page.
 */
@Repository("commonDAO")
public class CommonDAO {

	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;

	public HashMap<String, Object> select(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		HashMap<String, Object> result = sqlSession.selectOne(sqlKey, reqMap);
		if (result != null) {
			result = toLowerKeyAll(result);
		}
		
		return result;
	}

	public LoginUserVO selectLogin(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		LoginUserVO result = sqlSession.selectOne(sqlKey, reqMap);
		return result;
	}
	
	public List<HashMap<String, Object>> list(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		List<HashMap<String, Object>> resultList = sqlSession.selectList(sqlKey, reqMap);
		
		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for (HashMap<String, Object> result : resultList) {
			if (result != null ) {
				result = toLowerKeyAll(result);
			}
			rtnList.add(result);
		}
		return rtnList;
	}
	
	public int insert(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		int result = sqlSession.insert(sqlKey, reqMap);
		return result;
	}
	
	public int update(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		int result = sqlSession.update(sqlKey, reqMap);
		return result;
	}
	
	public int delete(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		int result = sqlSession.delete(sqlKey, reqMap);
		return result;
	}
	
	private HashMap<String, Object> toLowerKeyAll(HashMap<String, Object> result) {
		Iterator<?> iter = result.keySet().iterator();
		String hashKey = "";
		Object val = "";
		String lowKey = "";
		
		HashMap<String, Object> tmpHm = new HashMap<String, Object>();
		while (iter.hasNext()) {
			hashKey = (String) iter.next();
			
			lowKey = StringUtils.lowerCase(hashKey);
			
			val = result.get(hashKey);
			if (val == null) {
				val = "";
			} else {
				val = val.toString();
			}
			
			tmpHm.put(lowKey, val);
		}
		
		return tmpHm;
	}
}
