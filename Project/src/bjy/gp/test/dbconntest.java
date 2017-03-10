package bjy.gp.test;

import java.sql.*;

public class dbconntest {
	static String name = "root";
	static String pwd = "199444";
	static String url = "jdbc:mysql://localhost:3306/mysql";
    static Connection conn = null;
	static Statement stmt = null;
	static Connection conn1 = null;
	static Statement stmt1 = null;
	static ResultSet rs = null;
	
    public static void main(String[] args){
    	
        try{
            // 调用Class.forName()方法加载驱动程序
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("成功加载MySQL驱动！");
        }catch(ClassNotFoundException e1){
            System.out.println("找不到MySQL驱动!");
            e1.printStackTrace();
        }
        
        try {
            conn = DriverManager.getConnection(url, name, pwd);
            Statement stmt = conn.createStatement(); // 创建Statement对象
            System.out.print("成功连接到数据库！");
            rs = stmt.executeQuery("SELECT count(*) FROM bjy2016gp.wareroom");
            System.out.println(rs);
            
            stmt.close();
            conn.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        
    }
    
	public static ResultSet executeQuery(String sql) throws SQLException {
		conn = DriverManager.getConnection(url, name, pwd);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		return rs;
	}

	public static boolean executeUpdate(String sql) throws SQLException {
		try {
			conn1 = DriverManager.getConnection(url, name, pwd);
			stmt1 = conn1.createStatement();
			stmt1.executeUpdate(sql);
			return true;
		} catch (SQLException ex) {
			System.err.println("closeConn: " + ex.getMessage());
			return false;
		}
	}
	
	public boolean closeConn() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
			if (stmt1 != null)
				stmt1.close();
			if (conn1 != null)
				conn1.close();
			return true;
		} catch (SQLException ex) {
			System.err.println("closeConn: " + ex.getMessage());
			return false;
		}
	}
	
	public static Connection createDBConn(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(url, name, pwd);
			return conn;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	public static void closeDBConn(Connection conn){
		try{
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public static void create(){
		conn = createDBConn();
	}
	public static void close(){
		closeDBConn(conn);
	}
	

}