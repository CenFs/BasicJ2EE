package bjy.gp.entity;


public class Wareroom {
	private int wrid;
	private String wrname;
	private String wr_person_in_charge;
	private int wr_capacity;
	private int wr_margin;
	private String wr_remark;
	
	public Wareroom() {
		super();
	}
	
	public Wareroom(int wrid, String wrname, String wr_person_in_charge, int wr_capacity, int wr_margin, String wr_remark) {
		super();
		this.wrid = wrid;
		this.wrname = wrname;
		this.wr_person_in_charge = wr_person_in_charge;
		this.wr_capacity = wr_capacity;
		this.wr_margin = wr_margin;
		this.wr_remark = wr_remark;
	}
	
	
	public int getWrid() {
		return wrid;
	}
	public void setWrid(int wrid) {
		this.wrid = wrid;
	}
	public String getWrname() {
		return wrname;
	}
	public void setWrname(String wrname) {
		this.wrname = wrname;
	}
	public String getWr_person_in_charge() {
		return wr_person_in_charge;
	}
	public void setWr_person_in_charge(String wr_person_in_charge) {
		this.wr_person_in_charge = wr_person_in_charge;
	}
	public int getWr_capacity() {
		return wr_capacity;
	}
	public void setWr_capacity(int wr_capacity) {
		this.wr_capacity = wr_capacity;
	}
	public int getWr_margin() {
		return wr_margin;
	}
	public void setWr_margin(int wr_margin) {
		this.wr_margin = wr_margin;
	}
	public String getWr_remark() {
		return wr_remark;
	}
	public void setWr_remark(String wr_remark) {
		this.wr_remark = wr_remark;
	}


	
	@Override
	public String toString() {
		return "Wareroom [wrid=" + wrid + ", wrname=" + wrname + ", wr_person_in_charge=" + wr_person_in_charge
				+ ", wr_capacity=" + wr_capacity + ", wr_margin=" + wr_margin + ", wr_remark=" + wr_remark + "]";
	}
	
	
}
