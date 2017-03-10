package bjy.gp.dao;

import java.sql.SQLException;

import bjy.gp.entity.Export;
import bjy.gp.entity.Wareroom;

public interface ExportDao {
	public void addExport(String exportname, String export_person, String export_time, String export_remark, String pdtname, int export_wrid, int export_reasonid, int export_quantity) throws SQLException;
	public Export findExportbyExportid(int exportid);
	public void deleteExport(int exportid);
	public void updateExport(int exportid, String exportname, String export_person, String export_time, String export_remark, String pdtname, int export_wrid, int export_reasonid, int export_quantity);
	public Wareroom getWareroomMargin(int wrid);
	public void setWareroomMargin(int curwrmargin, int wrid);
}
