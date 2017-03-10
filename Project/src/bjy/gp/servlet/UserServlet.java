package bjy.gp.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjy.gp.dao.UserDao;
import bjy.gp.dao.impl.UserDaoImpl;
import bjy.gp.entity.User;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private UserDao userdao = new UserDaoImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*PrintWriter out = response.getWriter();
		out.println("say hello from server");*/
		//设置请求参数的字符编码
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");
		if("login".equals(method)){
			login(request, response);
		}
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
			
			response.setContentType("text/html;charset=utf-8");
//			PrintWriter out = response.getWriter();
			//获取用户输入的姓名和密码
//			String name = request.getParameter("username");
//	        byte[] b;
//	        b = name.getBytes("iso8859-1");
//	        String username = new String(b,"UTF-8");
			
			String username = request.getParameter("username");
			String userpwd = request.getParameter("userpwd");
//			System.out.println("---------username:" + username);
//			System.out.println("---------userpwd:" + userpwd);
			User user = userdao.findUserByNameAndPwd(username, userpwd);
//			通过userdao，找到并且set了user！！！

			
			try {
				if(user == null) {
					
					System.out.println("\n---------用户名或密码错误！");
//					out.println("用户名或密码错误！");
					response.sendRedirect("error.jsp");
					
				} else {
					
					System.out.println("---------userid:" + user.getUserid());
					System.out.println("---------username:" + user.getUsername());
					System.out.println("---------userpwd:" + user.getUserpwd());
					System.out.println("\n---------登录成功！");
//					out.println("登录成功！");
//					String url = "index.jsp?username=" + username;
					HttpSession session = request.getSession();
					session.setAttribute("userid", user.getUserid());
		            session.setAttribute("username", username);
		            session.setAttribute("islogin", "Y");
					
					//将需要转发或发送的地址进行转码操作 这样在目标页面更好取值 以免乱码产生
//	                url = new String(url.getBytes("UTF-8"),"ISO8859-1");
					
	                //客户端跳转 只有session范围的属性及url中参数会被传递下去
	                response.sendRedirect("index.jsp");
	                
	                //服务器端跳转 request对象、url中的参数会被传递下去
//	                request.getRequestDispatcher(url).forward(request, response);
	                
	            }
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
