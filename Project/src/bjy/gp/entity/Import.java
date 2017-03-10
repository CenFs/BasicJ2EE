package bjy.gp.entity;

public class Import {
//	import (importid, importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity)
	private int importid;
	private String importname;
	private String import_person;
	private String import_time;
	private String import_remark;
	private int import_pdtid;
	private int import_wrid;
	private int import_reasonid;
	private int import_quantity;
	
	public Import() {
		super();
	}
	
	public Import(int importid, String importname, String import_person, String import_time, String import_remark, int import_pdtid, int import_wrid, int import_reasonid, int import_quantity) {
		super();
		this.importid = importid;
		this.importname = importname;
		this.import_person = import_person;
		this.import_time = import_time;
		this.import_remark = import_remark;
		this.import_pdtid = import_pdtid;
		this.import_wrid = import_wrid;
		this.import_reasonid = import_reasonid;
		this.import_quantity = import_quantity;
	}
	
	
	public int getImportid() {
		return importid;
	}
	public void setImportid(int importid) {
		this.importid = importid;
	}
	public String getImportname() {
		return importname;
	}
	public void setImportname(String importname) {
		this.importname = importname;
	}
	public String getImport_person() {
		return import_person;
	}
	public void setImport_person(String import_person) {
		this.import_person = import_person;
	}
	public String getImport_time() {
		return import_time;
	}
	public void setImport_time(String import_time) {
		this.import_time = import_time;
	}
	public String getImport_remark() {
		return import_remark;
	}
	public void setImport_remark(String import_remark) {
		this.import_remark = import_remark;
	}
	public int getImport_pdtid() {
		return import_pdtid;
	}
	public void setImport_pdtid(int import_pdtid) {
		this.import_pdtid = import_pdtid;
	}
	public int getImport_wrid() {
		return import_wrid;
	}
	public void setImport_wrid(int import_wrid) {
		this.import_wrid = import_wrid;
	}
	public int getImport_reasonid() {
		return import_reasonid;
	}
	public void setImport_reasonid(int import_reasonid) {
		this.import_reasonid = import_reasonid;
	}
	public int getImport_quantity() {
		return import_quantity;
	}
	public void setImport_quantity(int import_quantity) {
		this.import_quantity = import_quantity;
	}
	
//	import (importid, importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity)
	@Override
	public String toString() {
		return "Import [importid=" + importid + ", importname=" + importname + ", import_person=" + import_person
				+ ", import_time=" + import_time + ", import_remark=" + import_remark + ", import_pdtid=" + import_pdtid
				+ ", import_wrid=" + import_wrid + ", import_reasonid=" + import_reasonid + ", import_quantity=" + import_quantity + "]";
	}
	
	
}
