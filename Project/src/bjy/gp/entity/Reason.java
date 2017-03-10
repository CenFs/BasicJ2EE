package bjy.gp.entity;

public class Reason {
	
//	reason (reasonid, reasonname, reason_remark)
	private int reasonid;
	private String reasonname;
	private String reason_remark;
	
	public Reason() {
		super();
	}
	
	public Reason(int reasonid, String reasonname, String reason_remark) {
		super();
		this.reasonid = reasonid;
		this.reasonname = reasonname;
		this.reason_remark = reason_remark;
	}
	
	
	public int getReasonid() {
		return reasonid;
	}
	public void setReasonid(int reasonid) {
		this.reasonid = reasonid;
	}
	public String getReasonname() {
		return reasonname;
	}
	public void setReasonname(String reasonname) {
		this.reasonname = reasonname;
	}
	public String getReason_remark() {
		return reason_remark;
	}
	public void setReason_remark(String reason_remark) {
		this.reason_remark = reason_remark;
	}

	
	@Override
	public String toString() {
		return "Reason [reasonid=" + reasonid + ", reasonname=" + reasonname + ", reason_remark=" + reason_remark + "]";
	}
	
	
}
