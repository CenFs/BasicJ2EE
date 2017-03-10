package bjy.gp.dao;

import bjy.gp.entity.Wareroom;

public interface WareroomDao {
	
	public void addImport(String importname, String import_person, String import_time, String import_remark, int import_pdti, int import_wrid, int import_reasonid, int import_quantity);
	
	public Wareroom getWareroomMargin(int wrid);
	public void setWareroomMargin(int curwrmargin, int wrid);

	void deleteWareroom(int wrid);

	void addWareroom(String wrname, String wr_person_in_charge,
			int wr_capacity, int wr_margin, String wr_remark);

	void updateWareroom(int wrid, String wrname, String wr_person_in_charge,
			int wr_capacity, String wr_remark);
}
