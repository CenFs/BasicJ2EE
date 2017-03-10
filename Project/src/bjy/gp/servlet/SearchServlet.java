package bjy.gp.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjy.gp.dao.SearchDao;
import bjy.gp.dao.impl.SearchDaoImpl;

/**
 * Servlet implementation class SearchServlet
 */
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private SearchDao searchdao = new SearchDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");
		if("imbytime".equals(method)){
			imbytime(request,response);
		}
		if("exbytime".equals(method)){
			exbytime(request,response);
		}
	}
	
	private void imbytime(HttpServletRequest request,
			HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");
		
		String username = request.getParameter("username");
		String time_begin = request.getParameter("time_begin");
		String time_end = request.getParameter("time_end");
//		System.out.println(username);
		String newstr[] = searchdao.addSearch(time_begin, time_end);
		time_begin = newstr[0];
		time_end = newstr[1];
		
		try {
			System.out.println("\n---------" + time_begin + "至" + time_end + "时间段内，入库单查询中！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			session.setAttribute("import_time_begin", time_begin);
			session.setAttribute("import_time_end", time_end);
			request.getRequestDispatcher("import_searchbytime.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	
	private void exbytime(HttpServletRequest request,
			HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");
		
		String username = request.getParameter("username");
		String time_begin = request.getParameter("time_begin");
		String time_end = request.getParameter("time_end");
		
		String newstr[] = searchdao.addSearch(time_begin, time_end);
		time_begin = newstr[0];
		time_end = newstr[1];
		
		try {
			System.out.println("\n---------" + time_begin + "至" + time_end + "时间段内，出库单查询中！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			session.setAttribute("export_time_begin", time_begin);
			session.setAttribute("export_time_end", time_end);
			request.getRequestDispatcher("export_searchbytime.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
