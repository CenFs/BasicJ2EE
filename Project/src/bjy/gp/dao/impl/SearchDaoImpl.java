package bjy.gp.dao.impl;

import org.apache.commons.dbutils.QueryRunner;

import bjy.gp.dao.SearchDao;
import bjy.gp.util.C3P0Util;

public class SearchDaoImpl implements SearchDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	

	public String[] addSearch(String time_begin, String time_end) {
		
		time_begin += ":00";
		time_end +=":00";
//		System.out.println(time_begin);
//		System.out.println(time_end);
		String[] time = {time_begin, time_end};
		return time;
	}
	
}
