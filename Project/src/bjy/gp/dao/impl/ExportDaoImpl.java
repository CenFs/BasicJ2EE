package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bjy.gp.dao.ExportDao;
import bjy.gp.dao.ProductDao;
import bjy.gp.dao.WareroomDao;
import bjy.gp.entity.Export;
import bjy.gp.entity.Product;
import bjy.gp.entity.Wareroom;
import bjy.gp.util.C3P0Util;

public class ExportDaoImpl implements ExportDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	
	public Export findExportbyExportid(int exportid) {
		
		String sql = "select * from bjy2016gp.export where exportid=" + exportid;
		
		try {
			return qr.query(sql, new BeanHandler<Export>(Export.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public Wareroom getWareroomMargin(int wrid) {

		String sql = "select * from bjy2016gp.wareroom where wrid=" + wrid;
		
		try {
			return qr.query(sql, new BeanHandler<Wareroom>(Wareroom.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public void setWareroomMargin(int curwrmargin, int wrid) {
		
		String sql = "update bjy2016gp.wareroom set wr_margin=? where wrid=?";
		Object [] params = new Object[]{curwrmargin, wrid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void addExport(String exportname, String export_person, String export_time, String export_remark, String pdtname, int export_wrid, int export_reasonid, int export_quantity) throws SQLException {

		ProductDao pdtdao = new ProductDaoImpl();
		WareroomDao wrdao = new WareroomDaoImpl();
		int export_pdtid = 0;
		
			Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, export_wrid);
			export_pdtid = product.getPdtid(); // 获取了出库产品的id
			int newpdtquantity = product.getPdt_quantity() - export_quantity; // 产品出库后总数量
			pdtdao.updateProductQuantity(export_pdtid, newpdtquantity);
		
		// 仓库余量=当前余量+出库产品数
		Wareroom wareroom = wrdao.getWareroomMargin(export_wrid);
		int orwrmargin = wareroom.getWr_margin();
		int curwrmargin = orwrmargin + export_quantity;
		wrdao.setWareroomMargin(curwrmargin, export_wrid);
		
		String sql = "insert into bjy2016gp.export(exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity) values(?,?,?,?,?,?,?,?)";
		Object [] params = new Object[]{exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void deleteExport(int exportid) {

		String sql = "delete from bjy2016gp.export where exportid=?";
		
		try {
			qr.update(sql, exportid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@Override
	public void updateExport(int exportid, String exportname, String export_person, String export_time, String export_remark, String pdtname, int export_wrid, int export_reasonid, int export_quantity) {
		
		ProductDao pdtdao = new ProductDaoImpl();
		Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, export_wrid);
		int export_pdtid = product.getPdtid();
		
		String sql = "update bjy2016gp.export set exportname=?, export_person=?, export_time=?, export_remark=?, export_pdtid=?, export_wrid=?, export_reasonid=?, export_quantity=? where exportid=?";
		Object [] params = new Object[]{exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity, exportid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
