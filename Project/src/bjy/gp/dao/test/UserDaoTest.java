package bjy.gp.dao.test;

import bjy.gp.entity.User;

public class UserDaoTest {

//	private UserDao dao = new UserDaoImpl();
//	@Test
//	public void testFindUserByNameAndPwd() {
//		//�û�����������ȷ��User�ǲ�Ϊ�յ�
//		User userright = dao.findUserByNameAndPwd("test","1234");
//		Assert.assertNotNull(userright);
//		System.out.println("userright:" + userright);
//		//�û��������벻��ȷ��User��Ϊ�յ�
//		User usererror = dao.findUserByNameAndPwd("abcd","123");
//		Assert.assertNull(usererror);
//		System.out.println("usererror:" + usererror);
//	}
	
	public static void main(String[] args) {
		User person = new User();

        person.setUsername("test");
        person.setUserpwd("1234");
        person.setUserid(1);


        System.out.println(person.getUsername());
        System.out.println(person.getUserpwd());
        System.out.println(person.getUserid());
    }

}
