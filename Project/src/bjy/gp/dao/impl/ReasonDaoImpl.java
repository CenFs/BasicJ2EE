package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import bjy.gp.dao.ReasonDao;
import bjy.gp.util.C3P0Util;

public class ReasonDaoImpl implements ReasonDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	

	public void addReason(String reasonname, String reason_remark){
		
		String sql = "insert into bjy2016gp.reason(reasonname, reason_remark) values(?,?)";
		Object [] params = new Object[]{reasonname, reason_remark};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void deleteReason(int reasonid) {

		String sql = "delete from bjy2016gp.reason where reasonid=?";
		
		try {
			qr.update(sql, reasonid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
