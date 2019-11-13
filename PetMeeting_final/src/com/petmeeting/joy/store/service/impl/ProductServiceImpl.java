package com.petmeeting.joy.store.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.store.dao.ProductDao;
import com.petmeeting.joy.store.model.CartDto;
import com.petmeeting.joy.store.model.ProductBean;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;
import com.petmeeting.joy.store.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDao proDao;

	@Override
	public void addProduct(ProductDto pro) {
		proDao.addProduct(pro);
	}

	@Override
	public List<ProductDto> getProductList() {
		return proDao.getProductList();
	}

	@Override
	public void addProductOption(ProductOptionDto poption) {
		proDao.addProductOption(poption);
	}

	@Override
	public ProductDto getProduct(String pcode) {
		return proDao.getProduct(pcode);
	}
	
	@Override
	public ProductBean getProductInfo(String pcode) {
		ProductDto pro = proDao.getProduct(pcode);
	//	System.out.println("------------------------------------ productdetail Service getProductInfo pro" + pro.toString());
		
		List<String> _psize = proDao.getSize(pcode);
		String[] psize = new String[_psize.size()];
		for (int i = 0; i < psize.length; i++) {
			psize[i] = _psize.get(i);
		}
	//	System.out.println("------------------------------------ productdetail Service getProductInfo psize");
		List<String> _pcolor = proDao.getColor(pcode);
		String[] pcolor = new String[_pcolor.size()];
		for (int i = 0; i < pcolor.length; i++) {
			pcolor[i] = _pcolor.get(i);
		}
	//	System.out.println("------------------------------------ productdetail Service getProductInfo pcolor");

		ProductBean pbean = new ProductBean(pcode, pro.getProductname(), pro.getCategory(), pro.getPrice(), pro.getFilename(),
											psize, pcolor, pro.getContent(), pro.getRegdate(), pro.getQuantity(), 0, pro.getRecommend());
		
		return pbean;
	}

	@Override
	public boolean isSoldout(ProductOptionDto poption) {
		int quantity = proDao.getProductOptionQuantity(poption);

		return quantity<=0?true:false;
	}
	
	@Override
	public boolean isSoldout(String pcode) {
		int quantity = proDao.getProductQuantity(pcode);
		
		return quantity<=0?true:false;
	}
	
	@Override
	public int getProductOptionQuantity(ProductOptionDto poption) {
		return proDao.getProductOptionQuantity(poption);
	}

	@Override
	public int getProductOptionSeq(CartDto cart) {
		return proDao.getProductOptionSeq(cart);
	}

	@Override
	public List<ProductDto> getProductListWithQuantity(ProductParam param) {
		return proDao.getProductListWithQuantity(param);
	}

	@Override
	public List<ProductOptionDto> getProductOption(String productcode) {
		return proDao.getProductOption(productcode);
	}

	@Override
	public void updateProductOption(ProductOptionDto poption) {
		proDao.updateProductOption(poption);
	}

	@Override
	public int getProductCount(ProductParam param) {
		return proDao.getProductCount(param);
	}

	@Override
	public void updateProduct(ProductDto pro) {
		proDao.updateProduct(pro);
	}

	@Override
	public void deleteProductOption(int seq) {
		proDao.deleteProductOption(seq);
	}

	@Override
	public void deleteProduct(String productcode) {
		proDao.deleteProduct(productcode);
	}

	@Override
	public ProductDto duplicationCheck(String productcode) {
		return proDao.duplicationCheck(productcode);
	}

	@Override
	public void updateRecommend(ProductDto pro) {
		proDao.updateRecommend(pro);
	}

	@Override
	public int getRecommendCount() {
		return proDao.getRecommendCount();
	}

	@Override
	public List<ProductDto> getRecommendProductList() {
		return proDao.getRecommendProductList();
	}

}
