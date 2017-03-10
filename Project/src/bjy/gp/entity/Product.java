package bjy.gp.entity;

public class Product {
	private int pdtid;
	private String pdtname;
	private int pdt_wareroom;
	private String pdt_register_time;
	private String pdt_register_person;
	private String pdt_remark;
	private double pdt_price;
	private int pdt_quantity;
	
	public Product() {
		super();
	}
	
	public Product(int pdtid, String pdtname, int pdt_wareroom, String pdt_register_time, String pdt_register_person, String pdt_remark, double pdt_price, int pdt_quantity) {
		super();
		this.pdtid = pdtid;
		this.pdtname = pdtname;
		this.pdt_wareroom = pdt_wareroom;
		this.pdt_register_time = pdt_register_time;
		this.pdt_register_person = pdt_register_person;
		this.pdt_remark = pdt_remark;
		this.pdt_price = pdt_price;
		this.pdt_quantity = pdt_quantity;
	}
	
	
	public int getPdtid() {
		return pdtid;
	}
	public void setPdtid(int pdtid) {
		this.pdtid = pdtid;
	}
	public String getPdtname() {
		return pdtname;
	}
	public void setPdtname(String pdtname) {
		this.pdtname = pdtname;
	}
	public int getPdt_wareroom() {
		return pdt_wareroom;
	}
	public void setPdt_wareroom(int pdt_wareroom) {
		this.pdt_wareroom = pdt_wareroom;
	}
	public String getPdt_register_time() {
		return pdt_register_time;
	}
	public void setPdt_register_time(String pdt_register_time) {
		this.pdt_register_time = pdt_register_time;
	}
	public String getPdt_register_person() {
		return pdt_register_person;
	}
	public void setPdt_register_person(String pdt_register_person) {
		this.pdt_register_person = pdt_register_person;
	}
	public String getPdt_remark() {
		return pdt_remark;
	}
	public void setPdt_remark(String pdt_remark) {
		this.pdt_remark = pdt_remark;
	}
	public double getPdt_price() {
		return pdt_price;
	}
	public void setPdt_price(double pdt_price) {
		this.pdt_price = pdt_price;
	}
	public int getPdt_quantity() {
		return pdt_quantity;
	}
	public void setPdt_quantity(int pdt_quantity) {
		this.pdt_quantity = pdt_quantity;
	}

	
	@Override
	public String toString() {
		return "Product [pdtid=" + pdtid + ", pdtname=" + pdtname + ", pdt_wareroom=" + pdt_wareroom
				+ ", pdt_register_time=" + pdt_register_time + ", pdt_register_person=" + pdt_register_person + ", pdt_remark=" + pdt_remark
				+ ", pdt_price=" + pdt_price + ", pdt_quantity=" + pdt_quantity + "]";
	}
	
	
}
