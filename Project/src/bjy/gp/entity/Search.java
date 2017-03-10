package bjy.gp.entity;

public class Search {
	
//	search (time_begin, time_end)
	private String time_begin;
	private String time_end;
	
	public Search() {
		super();
	}
	
	public Search(String time_begin, String time_end) {
		super();
		this.time_begin = time_begin;
		this.time_end = time_end;
	}
	
	
	public String getTime_begin() {
		return time_begin;
	}
	public void setTime_begin(String time_begin) {
		this.time_begin = time_begin;
	}
	public String getTime_end() {
		return time_end;
	}
	public void setTime_end(String time_end) {
		this.time_end = time_end;
	}

	
	@Override
	public String toString() {
		return "Search [time_begin=" + time_begin + ", time_end=" + time_end + "]";
	}
	
	
}
