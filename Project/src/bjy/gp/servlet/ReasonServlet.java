package bjy.gp.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjy.gp.dao.ReasonDao;
import bjy.gp.dao.impl.ReasonDaoImpl;

/**
 * Servlet implementation class ReasonServlet
 */
public class ReasonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private ReasonDao reasondao = new ReasonDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReasonServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");
		if("delete".equals(method)){
			delete(request,response);
		}
		if("add".equals(method)){
			add(request,response);
		}
	}

	private void delete(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int reasonid = Integer.parseInt(request.getParameter("reasonid"));
		String username = request.getParameter("username");
		
		reasondao.deleteReason(reasonid);
		
		try {
			System.out.println("\n---------出入库理由删除成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("reason.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	
	private void add(HttpServletRequest request,
			HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");

		String reasonname = request.getParameter("reasonname");
		String username = request.getParameter("username");
		String reason_remark = request.getParameter("reason_remark");
		
		reasondao.addReason(reasonname, reason_remark);
		
		try {
			System.out.println("\n---------出入库理由添加成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("reason.jsp").forward(request, response);
			
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
