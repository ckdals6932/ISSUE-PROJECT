package common.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

/**
 * Handles requests for the application home page.
 */
@Repository("commonDAO")
public class CommonDAO {

	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;

	public HashMap<String, Object> select(String sqlKey, HashMap<String, Object> reqMap) throws SQLException {
		HashMap<String, Object> result = sqlSession.selectOne(sqlKey);
		if (result != null) {
			result = toLowerKeyAll(result);
		}
		
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
			
			// Key 소문자화
			lowKey = StringUtils.lowerCase(hashKey);
			
			// DB 내용이 null일 경우를 대비해서 공백 문자로 대체
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
