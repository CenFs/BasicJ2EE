package bjy.gp.dao.test;

import java.util.List;

import org.junit.Test;

import bjy.gp.dao.ProductDao;
import bjy.gp.dao.impl.ProductDaoImpl;
import bjy.gp.entity.Product;

public class ProductDaoImplTest {

	private ProductDao pdtdao = new ProductDaoImpl();
	
	@Test
	public void testGetAll() {
	
		List<Product> products = pdtdao.getAll();
		for(Product product:products){
			System.out.println(product);
		}
	}
	
	@Test
	public void testAddProduct(){
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String now = dateFormat.format(new Date());
//		Product product = new Product(1, "testpdtt", 1, now, "test", "none", 2.00, 3);
//		pdtdao.addProduct(product);
	}

	@Test
	public void testDeleteProdcut(){
		pdtdao.deleteProduct(2);
	}
}
