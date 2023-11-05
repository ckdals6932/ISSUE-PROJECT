package cmmn.common.vo;

import java.util.HashMap;

public class LoginUserVO {
	
	private long user_seq;
	private String user_id;
	private String user_nm;
	private long auth_seq;
	
	public long getUserSeq() { return user_seq; }
	public String getUserId() { return user_id; }
	public String getUserNm() { return user_nm; }
	public long getAuthSeq() { return auth_seq; }
	
	public LoginUserVO() { }

	public LoginUserVO(long user_seq, String user_id, String user_nm, long auth_seq) {
		this.user_seq = user_seq;
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.auth_seq = auth_seq;
	}
	
	public LoginUserVO(HashMap<String, Object> dataObj) {
		this.user_seq = (long) dataObj.get("user_seq");
		this.user_id = (String) dataObj.get("user_id");
		this.user_nm = (String) dataObj.get("user_nm");
		this.auth_seq = (long) dataObj.get("auth_seq");
	}
}
