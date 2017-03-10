package bjy.gp.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bjy.gp.dao.ImportDao;
import bjy.gp.dao.ProductDao;
import bjy.gp.dao.WareroomDao;
import bjy.gp.entity.Import;
import bjy.gp.entity.Product;
import bjy.gp.entity.Wareroom;
import bjy.gp.util.C3P0Util;

public class ImportDaoImpl implements ImportDao {

	QueryRunner qr = new QueryRunner(C3P0Util.getDataSource());
	
	
	public Import findImportbyImportid(int importid) {
		
		String sql = "select * from bjy2016gp.import where importid=" + importid;
		
		try {
			return qr.query(sql, new BeanHandler<Import>(Import.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public Wareroom getWareroomMargin(int wrid) {

		String sql = "select * from bjy2016gp.wareroom where wrid=" + wrid;
		
		try {
			return qr.query(sql, new BeanHandler<Wareroom>(Wareroom.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public void setWareroomMargin(int curwrmargin, int wrid) {
		
		String sql = "update bjy2016gp.wareroom set wr_margin=? where wrid=?";
		Object [] params = new Object[]{curwrmargin, wrid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void addImport(String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity) throws SQLException {

		ProductDao pdtdao = new ProductDaoImpl();
		WareroomDao wrdao = new WareroomDaoImpl();
		int import_pdtid = 0;
		
		if (pdtdao.isExist(pdtname, import_wrid)) { // ����Ʒ��¼�Ѵ��ڣ���ȡ��Ʒid���޸�����
			
			System.out.println("--------��Ʒ��¼�Ѵ��ڣ�pdtname:" + pdtname + ", import_wrid:" + import_wrid);
			
			Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, import_wrid);
			import_pdtid = product.getPdtid(); // ��ȡ������Ʒ��id
//			System.out.println("--------��Ʒ��¼�Ѵ��ڣ�import_pdtid:" + import_pdtid);
			int newpdtquantity = product.getPdt_quantity() + import_quantity; // ��Ʒ����������
			pdtdao.updateProductQuantity(import_pdtid, newpdtquantity);
			
		} else { // ����Ʒ��¼�����ڣ����Ʋ�Ʒ��һ����¼��update�ֿ�id�Ͳ�Ʒ����
			
			System.out.println("--------��Ʒ��¼�����ڣ�pdtname:" + pdtname + ", import_wrid:" + import_wrid);
			
			Product product = pdtdao.findProductbyPdtname(pdtname);
			import_pdtid = product.getPdtid();
			
			String copy = "INSERT INTO bjy2016gp.product (pdtname, pdt_register_time, pdt_register_person, pdt_remark, pdt_price) (SELECT pdtname, pdt_register_time, pdt_register_person, pdt_remark, pdt_price FROM bjy2016gp.product WHERE pdtid=" + import_pdtid + ")";
			System.out.println(copy);
			product = pdtdao.copypdt(copy);
			import_pdtid = product.getPdtid();
			
			String changewridandpdtquantity = "UPDATE bjy2016gp.product SET pdt_wareroom=" + import_wrid + ", pdt_quantity=" + import_quantity + " WHERE pdtid=" + import_pdtid;
			System.out.println(changewridandpdtquantity);
			pdtdao.updatepdt(changewridandpdtquantity);
			
		}
		
		// �ֿ�����=��ǰ����-����Ʒ��
		Wareroom wareroom = wrdao.getWareroomMargin(import_wrid);
		int orwrmargin = wareroom.getWr_margin();
		int curwrmargin = orwrmargin - import_quantity;
		wrdao.setWareroomMargin(curwrmargin, import_wrid);
		
		String sql = "insert into bjy2016gp.import(importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity) values(?,?,?,?,?,?,?,?)";
		Object [] params = new Object[]{importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void deleteImport(int importid) {

		ProductDao pdtdao = new ProductDaoImpl();
		WareroomDao wrdao = new WareroomDaoImpl();
		ImportDao imdao = new ImportDaoImpl();
		Import ip = imdao.findImportbyImportid(importid);
		int import_pdtid = ip.getImport_pdtid();
		int import_wrid = ip.getImport_wrid();
		int import_quantity = ip.getImport_quantity();
		
		System.out.println("����Ʒid��" + import_pdtid + "�����ⷿid��" + import_wrid + "������Ʒ������" + import_quantity + "������ɾ���У�");
		
		Product product = pdtdao.findProductbyPdtid(import_pdtid);
		int newpdtquantity = product.getPdt_quantity() - import_quantity;
		if(newpdtquantity == 0) {
			System.out.println("��Ʒ��������գ�");
		} else {
			System.out.println("��Ʒʣ��������Ϊ��" + newpdtquantity);
		}
		pdtdao.updateProductQuantity(import_pdtid, newpdtquantity);
		
		Wareroom wareroom = wrdao.getWareroomMargin(import_wrid);
		int orwrmargin = wareroom.getWr_margin();
		int curwrmargin = orwrmargin + import_quantity;
		wrdao.setWareroomMargin(curwrmargin, import_wrid);
		System.out.println("�ֿ���������Ϊ��" + curwrmargin);
		
		String sql = "delete from bjy2016gp.import where importid=?";
		
		try {
			qr.update(sql, importid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@Override
	public void updateImport(int importid, String importname, String import_person, String import_time, String import_remark, String pdtname, int import_wrid, int import_reasonid, int import_quantity) {
		
		// �鷳����... ������˵
		
		ProductDao pdtdao = new ProductDaoImpl();
		Product product = pdtdao.findProductbyPdtnameAndPdtwareroom(pdtname, import_wrid);
		int import_pdtid = product.getPdtid();
		
		String sql = "update bjy2016gp.import set importname=?, import_person=?, import_time=?, import_remark=?, import_pdtid=?, import_wrid=?, import_reasonid=?, import_quantity=? where importid=?";
		Object [] params = new Object[]{importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity, importid};
		
		try {
			qr.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
