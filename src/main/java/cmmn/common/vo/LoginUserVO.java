package cmmn.common.vo;

import java.util.HashMap;

public class LoginUserVO {
	
	private long user_seq;
	private String user_id;
	private String user_nm;
	private String auth_cd;
	
	public long getUserSeq() { return user_seq; }
	public String getUserId() { return user_id; }
	public String getUserNm() { return user_nm; }
	public String getAuthCd() { return auth_cd; }
	
	public LoginUserVO() { }

	public LoginUserVO(long user_seq, String user_id, String user_nm, String auth_cd) {
		this.user_seq = user_seq;
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.auth_cd = auth_cd;
	}
	
	public LoginUserVO(HashMap<String, Object> dataObj) {
		this.user_seq = (long) dataObj.get("user_seq");
		this.user_id = (String) dataObj.get("user_id");
		this.user_nm = (String) dataObj.get("user_nm");
		this.auth_cd = (String) dataObj.get("auth_cd");
	}
}
