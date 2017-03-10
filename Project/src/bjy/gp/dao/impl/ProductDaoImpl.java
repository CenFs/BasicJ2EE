package bjy.gp.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import bjy.gp.dao.ProductDao;
import bjy.gp.entity.Product;
import bjy.gp.entity.Wareroom;
import bjy.gp.test.dbconntest;
import bjy.gp.util.C3P0Util;

public class ProductDaoImpl implements ProductDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	@Override
	public List<Product> getAll() {

		String sql = "select * from bjy2016gp.product";
		
		try {
			return qr.query(sql, new BeanListHandler<Product>(Product.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean isExist(String pdtname, int pdt_wareroom) throws SQLException {
		
//		System.out.println("IsExist1111");
		String sql = "select COUNT(*) from bjy2016gp.product where pdtname='" + pdtname + "' and pdt_wareroom=" + pdt_wareroom;
		int pdtisexist = 0;
		ResultSet rspdtexist = dbconntest.executeQuery(sql);
//		System.out.println("IsExist2222");
		if (rspdtexist.next()) {
			pdtisexist = rspdtexist.getInt("COUNT(*)");
		}
		if (pdtisexist == 0){
			return false;
		} else {
			return true;
		}
	}
	
	public void updateProductQuantity(int pdtid, int pdt_quantity) {
		
		String sql = "update bjy2016gp.product set pdt_quantity=? where pdtid=?";
		Object [] params = new Object[]{pdt_quantity, pdtid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Product copypdt(String copy) {
		
		try {
			qr.update(copy);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String sql = "select * from bjy2016gp.product where pdtid=(select MAX(pdtid) from bjy2016gp.product)";
		
		try {
			return qr.query(sql, new BeanHandler<Product>(Product.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void updatepdt(String changewridandpdtquantity) {
		
		try {
			qr.update(changewridandpdtquantity);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Product findProductbyPdtnameAndPdtwareroom(String pdtname, int pdt_wareroom) {

		String sql = "select * from bjy2016gp.product where pdtname=? and pdt_wareroom=?";
		Object [] params = new Object[]{pdtname, pdt_wareroom};
		
		try {
			return qr.query(sql, new BeanHandler<Product>(Product.class), params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public Product findProductbyPdtname(String pdtname) {

		String sql = "select * from bjy2016gp.product where pdtname=?";
		Object [] params = new Object[]{pdtname};
		
		try {
			return qr.query(sql, new BeanHandler<Product>(Product.class), params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public Product findProductbyPdtid(int pdtid) {
		
		String sql = "select * from bjy2016gp.product where pdtid=" + pdtid;
		
		try {
			return qr.query(sql, new BeanHandler<Product>(Product.class));
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
	public void addProduct(String pdtname, int pdt_wareroom, String pdt_register_time, String pdt_register_person, String pdt_remark, double pdt_price, int pdt_quantity) {
		
		Wareroom rm = getWareroomMargin(pdt_wareroom);
		int wrmargin = rm.getWr_margin();
		int curwrmargin = wrmargin - pdt_quantity; // 仓库现剩余量=原剩余-产品
		setWareroomMargin(curwrmargin, pdt_wareroom);
		
		String sql = "insert into bjy2016gp.product(pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity) values(?,?,?,?,?,?,?)";
		Object [] params = new Object[]{pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteProduct(int pdtid) {

		Product pdt = findProductbyPdtid(pdtid);
		int pdtqtt = pdt.getPdt_quantity(); // 产品数量
		int pdtwr = pdt.getPdt_wareroom(); // 产品所在仓库
		
		Wareroom rm = getWareroomMargin(pdtwr);
		int wrmargin = rm.getWr_margin(); // 仓库原剩余量
		int curwrmargin = wrmargin + pdtqtt; // 仓库现剩余量=原剩余+产品
		setWareroomMargin(curwrmargin, pdtwr);
		
		String sql = "delete from bjy2016gp.product where pdtid=?";
		
		try {
			qr.update(sql, pdtid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateProduct(String pdtname, int pdt_wareroom, String pdt_register_time, String pdt_register_person, String pdt_remark, double pdt_price, int pdt_quantity, int pdtid) {
		
		Product pdt = findProductbyPdtid(pdtid);
		int pdtqtt = pdt.getPdt_quantity(); // 原产品数量
		int pdtwr = pdt.getPdt_wareroom(); // 原产品所在仓库
		
		if (pdtwr != pdt_wareroom){ // 换了仓库
			Wareroom rm = getWareroomMargin(pdtwr); // 原仓库
			Wareroom rm2 = getWareroomMargin(pdt_wareroom); // 新仓库
			
			// 原仓库剩余量=原仓库+原产品
			int curwrmargin = rm.getWr_margin() + pdtqtt;
			setWareroomMargin(curwrmargin, pdtwr);
			// 现仓库剩余量=现仓库-现产品
			int curwrmargin2 = rm2.getWr_margin() - pdt_quantity;
			setWareroomMargin(curwrmargin2, pdt_wareroom);
			
		} else { // 没换仓库
			Wareroom rm = getWareroomMargin(pdt_wareroom);
			int wrmargin = rm.getWr_margin(); // 仓库原剩余量
			int curwrmargin = wrmargin + pdtqtt - pdt_quantity; // 仓库现剩余量=原剩余+原产品-现产品
			setWareroomMargin(curwrmargin, pdt_wareroom);
		}
		
		String sql = "update bjy2016gp.product set pdtname=?, pdt_wareroom=?, pdt_register_time=?, pdt_register_person=?, pdt_remark=?, pdt_price=?, pdt_quantity=? where pdtid=?";
		Object [] params = new Object[]{pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity, pdtid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
