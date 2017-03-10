package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bjy.gp.dao.WareroomDao;
import bjy.gp.entity.Wareroom;
import bjy.gp.util.C3P0Util;

public class WareroomDaoImpl implements WareroomDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	
	public Wareroom findWareroombyWrid(int wrid) {
		
		String sql = "select * from bjy2016gp.wareroom where wrid=" + wrid;
		
		try {
			return qr.query(sql, new BeanHandler<Wareroom>(Wareroom.class));
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
	public void addWareroom(String wrname, String wr_person_in_charge, int wr_capacity, int wr_margin, String wr_remark) {
		
		String sql = "insert into bjy2016gp.wareroom(wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark) values(?,?,?,?,?)";
		Object [] params = new Object[]{wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void deleteWareroom(int wrid) {

		String sql = "delete from bjy2016gp.wareroom where wrid=?";
		
		try {
			qr.update(sql, wrid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateWareroom(int wrid, String wrname, String wr_person_in_charge, int wr_capacity, String wr_remark) {
		
		Wareroom wareroom = findWareroombyWrid(wrid);
		int or_wr_margin = wareroom.getWr_margin(); // 原来的剩余量
		int or_wr_capacity = wareroom.getWr_capacity(); // 原来的容量
		int or_wr_savepdt = or_wr_capacity - or_wr_margin; // 原来存储的产品数
		int wr_margin = wr_capacity - or_wr_savepdt; // 现在的剩余量 = 现容量 - 存储的产品数
		
		String sql = "update bjy2016gp.wareroom set wrname=?, wr_person_in_charge=?, wr_capacity=?, wr_margin=?, wr_remark=? where wrid=?";
		Object [] params = new Object[]{wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark, wrid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	@Override
	public void addImport(String importname, String import_person,
			String import_time, String import_remark, int import_pdti,
			int import_wrid, int import_reasonid, int import_quantity) {
		// TODO Auto-generated method stub
		
	}
}
