package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bjy.gp.dao.ImportDao;
import bjy.gp.dao.ProductDao;
import bjy.gp.dao.WareroomDao;
import bjy.gp.entity.Import;
import bjy.gp.entity.Product;
import bjy.gp.entity.Wareroom;
import bjy.gp.util.C3P0Util;

public class ImportDaoImpl implements ImportDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	
	public Import findImportbyImportid(int importid) {
		
		String sql = "select * from bjy2016gp.import where importid=" + importid;
		
		try {
			return qr.query(sql, new BeanHandler<Import>(Import.class));
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
	public void addImport(String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity) throws SQLException {

		ProductDao pdtdao = new ProductDaoImpl();
		WareroomDao wrdao = new WareroomDaoImpl();
		int import_pdtid = 0;
		
		if (pdtdao.isExist(pdtname, import_wrid)) { // 若产品记录已存在，获取产品id，修改数量
			
			System.out.println("--------产品记录已存在，pdtname:" + pdtname + ", import_wrid:" + import_wrid);
			
			Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, import_wrid);
			import_pdtid = product.getPdtid(); // 获取了入库产品的id
//			System.out.println("--------产品记录已存在，import_pdtid:" + import_pdtid);
			int newpdtquantity = product.getPdt_quantity() + import_quantity; // 产品入库后总数量
			pdtdao.updateProductQuantity(import_pdtid, newpdtquantity);
			
		} else { // 若产品记录不存在，复制产品另一条记录，update仓库id和产品数量
			
			System.out.println("--------产品记录不存在！pdtname:" + pdtname + ", import_wrid:" + import_wrid);
			
			Product product = pdtdao.findProductbyPdtname(pdtname);
			import_pdtid = product.getPdtid();
			
			String copy = "INSERT INTO bjy2016gp.product (pdtname, pdt_register_time, pdt_register_person, pdt_remark, pdt_price) (SELECT pdtname, pdt_register_time, pdt_register_person, pdt_remark, pdt_price FROM bjy2016gp.product WHERE pdtid=" + import_pdtid + ")";
			System.out.println(copy);
			product = pdtdao.copypdt(copy);
			import_pdtid = product.getPdtid();
			
			String changewridandpdtquantity = "UPDATE bjy2016gp.product SET pdt_wareroom=" + import_wrid + ", pdt_quantity=" + import_quantity + " WHERE pdtid=" + import_pdtid;
			System.out.println(changewridandpdtquantity);
			pdtdao.updatepdt(changewridandpdtquantity);
			
		}
		
		// 仓库余量=当前余量-入库产品数
		Wareroom wareroom = wrdao.getWareroomMargin(import_wrid);
		int orwrmargin = wareroom.getWr_margin();
		int curwrmargin = orwrmargin - import_quantity;
		wrdao.setWareroomMargin(curwrmargin, import_wrid);
		
		String sql = "insert into bjy2016gp.import(importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity) values(?,?,?,?,?,?,?,?)";
		Object [] params = new Object[]{importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void deleteImport(int importid) {

		ProductDao pdtdao = new ProductDaoImpl();
		WareroomDao wrdao = new WareroomDaoImpl();
		ImportDao imdao = new ImportDaoImpl();
		Import ip = imdao.findImportbyImportid(importid);
		int import_pdtid = ip.getImport_pdtid();
		int import_wrid = ip.getImport_wrid();
		int import_quantity = ip.getImport_quantity();
		
		System.out.println("入库产品id：" + import_pdtid + "，入库库房id：" + import_wrid + "，入库产品数量：" + import_quantity + "，正在删除中！");
		
		Product product = pdtdao.findProductbyPdtid(import_pdtid);
		int newpdtquantity = product.getPdt_quantity() - import_quantity;
		if(newpdtquantity == 0) {
			System.out.println("产品数量已清空！");
		} else {
			System.out.println("产品剩余量更新为：" + newpdtquantity);
		}
		pdtdao.updateProductQuantity(import_pdtid, newpdtquantity);
		
		Wareroom wareroom = wrdao.getWareroomMargin(import_wrid);
		int orwrmargin = wareroom.getWr_margin();
		int curwrmargin = orwrmargin + import_quantity;
		wrdao.setWareroomMargin(curwrmargin, import_wrid);
		System.out.println("仓库余量更新为：" + curwrmargin);
		
		String sql = "delete from bjy2016gp.import where importid=?";
		
		try {
			qr.update(sql, importid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@Override
	public void updateImport(int importid, String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity) {
		
		// 麻烦哭了... 改天再说
		
		ProductDao pdtdao = new ProductDaoImpl();
		Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, import_wrid);
		int import_pdtid = product.getPdtid();
		
		String sql = "update bjy2016gp.import set importname=?, import_person=?, import_time=?, import_remark=?, import_pdtid=?, import_wrid=?, import_reasonid=?, import_quantity=? where importid=?";
		Object [] params = new Object[]{importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity, importid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
