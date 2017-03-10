package bjy.gp.util;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Util {
	//定义数据库连接池对象
	private static DataSource dataSource = new  ComboPooledDataSource();
	
	/**
	 * 
	 * @return 返回连接池对象
	 */
	public static DataSource getDataSource(){
		return dataSource;
	}
	
}
