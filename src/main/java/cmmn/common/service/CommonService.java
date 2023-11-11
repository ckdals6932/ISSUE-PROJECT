package cmmn.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


/**
 * Handles requests for the application home page.
 */
@Service("commonService")
public class CommonService {
	
	public String changePage(HashMap<String, Object> reqMap) throws Exception {
		String returnPage = "redirect:" + reqMap.get("page");
		return returnPage;
	}
	
	public List<HashMap<String, Object>> getGridColDatas (MultiValueMap<String, Object> reqMap) throws Exception {
		String jsonString = (String.valueOf(reqMap.get("data[]"))).replaceAll("&guot;", "\"");
		Gson gson = new Gson();
		List<HashMap<String, Object>> grid_col_datas = null;
		grid_col_datas = gson.fromJson(jsonString, new TypeToken<List<HashMap<String, Object>>>() {}.getType());
		return grid_col_datas;
	}
}
 