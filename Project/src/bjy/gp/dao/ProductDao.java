package bjy.gp.dao;

import java.sql.SQLException;
import java.util.List;

import bjy.gp.entity.Product;
import bjy.gp.entity.Wareroom;

public interface ProductDao {
	List<Product> getAll();
	void deleteProduct(int id);
	public void updateProduct(String pdtname, int pdt_wareroom, String pdt_register_time, String pdt_register_person, String pdt_remark, double pdt_price, int pdt_quantity, int pdtid);
	public Wareroom getWareroomMargin(int wrid);
	public void setWareroomMargin(int curwrmargin, int wrid);
	public void addProduct(String pdtname, int pdt_wareroom, String pdt_register_time, String pdt_register_person, String pdt_remark, double pdt_price, int pdt_quantity);
	public Product findProductbyPdtnameAndPdtwareroom(String pdtname, int pdt_wareroom);
	public boolean isExist(String pdtname, int pdt_wareroom) throws SQLException;
	public void updateProductQuantity(int pdtid, int pdt_quantity);
	public Product copypdt(String copy);
	public Product findProductbyPdtname(String pdtname);
	public void updatepdt(String changewridandpdtquantity);
	public Product findProductbyPdtid(int pdtid);
}
