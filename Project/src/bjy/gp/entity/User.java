package bjy.gp.entity;

public class User {
	private String username;
	private String userpwd;
	private int userid;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(int userid, String username, String userpwd) {
		super();
		this.username = username;
		this.userpwd = userpwd;
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	
	
	
}
