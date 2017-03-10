package bjy.gp.dao;

import java.sql.SQLException;

import bjy.gp.entity.Import;
import bjy.gp.entity.Wareroom;

public interface ImportDao {
	public void addImport(String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity) throws SQLException;
	public Import findImportbyImportid(int importid);
	public void deleteImport(int importid);
	public void updateImport(int importid, String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity);
	public Wareroom getWareroomMargin(int wrid);
	public void setWareroomMargin(int curwrmargin, int wrid);
}
