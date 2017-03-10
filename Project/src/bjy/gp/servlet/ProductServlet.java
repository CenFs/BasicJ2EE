package bjy.gp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import bjy.gp.dao.ProductDao;
import bjy.gp.dao.impl.ProductDaoImpl;
import bjy.gp.entity.Product;

/**
 * Servlet implementation class ProductServlet
 */
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private ProductDao pdtdao = new ProductDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");
		if("findAll".equals(method)){
			findAll(request,response);
		}
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

	private void findAll(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		List<Product> products = pdtdao.getAll();
		
		//将集合以JSON格式显示
		JSONArray jsonArray = JSONArray.fromObject(products);
		out.println(jsonArray);
		
	}
	
	private void update(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int pdtid = Integer.parseInt(request.getParameter("pdtid"));
		String pdtname = request.getParameter("pdtname");
		double pdt_price = Double.valueOf(request.getParameter("pdt_price"));
		int pdt_quantity = Integer.parseInt(request.getParameter("pdt_quantity"));
		String pdt_register_person = request.getParameter("username");
		String pdt_register_time = request.getParameter("pdt_register_time");
		String pdt_remark = request.getParameter("pdt_remark");
		int pdt_wareroom = Integer.parseInt(request.getParameter("pdt_wareroom"));
		
		/*Product product = new Product();
		product.setPdtname(pdtname);
		product.setPdt_price(pdt_price);
		product.setPdt_quantity(pdt_quantity);
		product.setPdt_register_person(pdt_register_person);
		product.setPdt_register_time(pdt_register_time);
		product.setPdt_remark(pdt_remark);
		product.setPdt_wareroom(pdt_wareroom);*/
		
		pdtdao.updateProduct(pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity, pdtid);
		
		try {
			System.out.println("\n---------产品信息更新成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", pdt_register_person);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("product.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	

	private void delete(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		int pdtid = Integer.parseInt(request.getParameter("pdtid"));
		String username = request.getParameter("username");
		
		pdtdao.deleteProduct(pdtid);
		
		try {
			System.out.println("\n---------产品删除成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", username);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("product.jsp").forward(request, response);
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	
	private void add(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");

		String pdtname = request.getParameter("pdtname");
		double pdt_price = Double.valueOf(request.getParameter("pdt_price"));
		int pdt_quantity = Integer.parseInt(request.getParameter("pdt_quantity"));
		String pdt_register_person = request.getParameter("username");
		String pdt_register_time = request.getParameter("pdt_register_time");
		String pdt_remark = request.getParameter("pdt_remark");
		int pdt_wareroom = Integer.parseInt(request.getParameter("pdt_wareroom"));
		
		pdtdao.addProduct(pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity);
		
		try {
			System.out.println("\n---------产品信息添加成功！");
			HttpSession session = request.getSession();
			session.setAttribute("username", pdt_register_person);
			session.setAttribute("islogin", "Y");
			
			request.getRequestDispatcher("product.jsp").forward(request, response);
			
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
