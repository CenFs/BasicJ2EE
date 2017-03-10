package bjy.gp.entity;

public class Export {
//	export (exportid, exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity)
	private int exportid;
	private String exportname;
	private String export_person;
	private String export_time;
	private String export_remark;
	private int export_pdtid;
	private int export_wrid;
	private int export_reasonid;
	private int export_quantity;
	
	public Export() {
		super();
	}
	
	public Export(int exportid, String exportname, String export_person, String export_time, String export_remark, int export_pdtid, int export_wrid, int export_reasonid, int export_quantity) {
		super();
		this.exportid = exportid;
		this.exportname = exportname;
		this.export_person = export_person;
		this.export_time = export_time;
		this.export_remark = export_remark;
		this.export_pdtid = export_pdtid;
		this.export_wrid = export_wrid;
		this.export_reasonid = export_reasonid;
		this.export_quantity = export_quantity;
	}
	
	
	public int getExportid() {
		return exportid;
	}
	public void setExportid(int exportid) {
		this.exportid = exportid;
	}
	public String getExportname() {
		return exportname;
	}
	public void setExportname(String exportname) {
		this.exportname = exportname;
	}
	public String getExport_person() {
		return export_person;
	}
	public void setExport_person(String export_person) {
		this.export_person = export_person;
	}
	public String getExport_time() {
		return export_time;
	}
	public void setExport_time(String export_time) {
		this.export_time = export_time;
	}
	public String getExport_remark() {
		return export_remark;
	}
	public void setExport_remark(String export_remark) {
		this.export_remark = export_remark;
	}
	public int getExport_pdtid() {
		return export_pdtid;
	}
	public void setExport_pdtid(int export_pdtid) {
		this.export_pdtid = export_pdtid;
	}
	public int getExport_wrid() {
		return export_wrid;
	}
	public void setExport_wrid(int export_wrid) {
		this.export_wrid = export_wrid;
	}
	public int getExport_reasonid() {
		return export_reasonid;
	}
	public void setExport_reasonid(int export_reasonid) {
		this.export_reasonid = export_reasonid;
	}
	public int getExport_quantity() {
		return export_quantity;
	}
	public void setExport_quantity(int export_quantity) {
		this.export_quantity = export_quantity;
	}
	
//	export (exportid, exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity)
	@Override
	public String toString() {
		return "export [exportid=" + exportid + ", exportname=" + exportname + ", export_person=" + export_person
				+ ", export_time=" + export_time + ", export_remark=" + export_remark + ", export_pdtid=" + export_pdtid
				+ ", export_wrid=" + export_wrid + ", export_reasonid=" + export_reasonid + ", export_quantity=" + export_quantity + "]";
	}
	
	
}
