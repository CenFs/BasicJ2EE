package bjy.gp.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjy.gp.dao.WareroomDao;
import bjy.gp.dao.impl.WareroomDaoImpl;

/**
 * Servlet implementation class WareroomServlet
 */
public class WareroomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private WareroomDao wrdao = new WareroomDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WareroomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");
		if("update".equals(method)){
			update(request,response);
		}
		if("delete".equals(method)){
			delete(request,response);
		}
		if("add".equals(method)){
			add(request,response);
		}
	}
	
	private void update(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int wrid = Integer.parseInt(request.getParameter("wrid"));
		String wrname = request.getParameter("wrname");
		String wr_person_in_charge = request.getParameter("username");
		int wr_capacity = Integer.parseInt(request.getParameter("wr_capacity"));
		String wr_remark = request.getParameter("wr_remark");
		System.out.println(wrname);
		
		wrdao.updateWareroom(wrid, wrname, wr_person_in_charge, wr_capacity, wr_remark);
		
		try {
			System.out.println("\n---------仓库信息更新成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", wr_person_in_charge);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("wareroom.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	

	private void delete(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int wrid = Integer.parseInt(request.getParameter("wrid"));
		String username = request.getParameter("username");
		
		wrdao.deleteWareroom(wrid);
		
		try {
			System.out.println("\n---------仓库删除成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("wareroom.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	
	private void add(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");

		String wrname = request.getParameter("wrname");
		int wr_capacity = Integer.parseInt(request.getParameter("wr_capacity"));
		String wr_person_in_charge = request.getParameter("username");
		String wr_remark = request.getParameter("wr_remark");
		
		wrdao.addWareroom(wrname, wr_person_in_charge, wr_capacity, wr_capacity, wr_remark);
		
		try {
			System.out.println("\n---------仓库添加成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", wr_person_in_charge);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("wareroom.jsp").forward(request, response);
			
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
