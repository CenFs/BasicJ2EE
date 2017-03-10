package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bjy.gp.dao.UserDao;
import bjy.gp.entity.User;
import bjy.gp.util.C3P0Util;

public class UserDaoImpl implements UserDao {

	//声明并实例化QueryRunner对象
	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	public void addUser(User user){
		
		String sql = "insert into bjy2016gp.user(userid,username,userpwd) values(?,?,?)";
		Object []params = {user.getUserid(), user.getUsername(), user.getUserpwd()};
		
		try {
			qr.update(sql, params);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	
	
	@Override
	public User findUserByNameAndPwd(String username, String userpwd) {
		
		String sql = "select * from bjy2016gp.user where username=? and userpwd=?";
		Object params[] = new Object[]{username, userpwd};
		
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public User findUserById(int userid) {
		
		String sql = "select * from bjy2016gp.user where userid=?";
		
		try {
			return qr.query(sql, new BeanHandler<User>(User.class), userid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	
	public void deleteUserById(int userid) {
		
		String sql = "delete from bjy2016gp.user where userid=?";
		
		try {
			qr.update(sql, userid);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
}
