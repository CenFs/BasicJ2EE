package bjy.gp.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjy.gp.dao.ImportDao;
import bjy.gp.dao.impl.ImportDaoImpl;

/**
 * Servlet implementation class ImportServlet
 */
public class ImportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private ImportDao impdao = new ImportDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImportServlet() {
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
			try {
				add(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private void update(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int importid = Integer.parseInt(request.getParameter("importid"));
		String importname = request.getParameter("importname");
		String import_person = request.getParameter("username");
		String import_time = request.getParameter("import_time");
		String import_remark = request.getParameter("import_remark");
		String pdtname = request.getParameter("pdtname");
		int import_wrid = Integer.parseInt(request.getParameter("import_wrid"));
		int reasonid = Integer.parseInt(request.getParameter("reasonid"));
		int import_quantity = Integer.parseInt(request.getParameter("import_quantity"));
		
		impdao.updateImport(importid, importname, import_person, import_time, import_remark, pdtname, import_wrid, reasonid, import_quantity);
		
		try {
			System.out.println("\n---------入库单更新成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", import_person);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("import.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	

	private void delete(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int importid = Integer.parseInt(request.getParameter("importid"));
		String username = request.getParameter("username");
		
		impdao.deleteImport(importid);
		
		try {
			System.out.println("\n---------入库单删除成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("import.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	
	private void add(HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException {
		
		response.setContentType("text/html;charset=utf-8");

		String importname = request.getParameter("importname");
		String import_person = request.getParameter("username");
		String import_time = request.getParameter("import_time");
		String import_remark = request.getParameter("import_remark");
		String pdtname = request.getParameter("pdtname");
		int import_quantity = Integer.parseInt(request.getParameter("import_quantity"));
		int import_wrid = Integer.parseInt(request.getParameter("import_wrid"));
		int reasonid = Integer.parseInt(request.getParameter("reasonid"));
		
		impdao.addImport(importname, import_person, import_time, import_remark, pdtname, import_wrid, reasonid, import_quantity);
		
		try {
			System.out.println("\n---------入库单添加成功！");
			HttpSession session = request.getSession();
//			System.out.println("import_person!!!!!" + import_person);
			session.setAttribute("username", import_person);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("import.jsp").forward(request, response);
			
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
