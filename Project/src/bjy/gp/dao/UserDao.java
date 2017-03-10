package bjy.gp.dao;

import bjy.gp.entity.User;

public interface UserDao {
	public User findUserByNameAndPwd(String username,String userpwd);
	public void addUser(User user);
	public User findUserById(int userid);
	public void deleteUserById(int userid);
}
