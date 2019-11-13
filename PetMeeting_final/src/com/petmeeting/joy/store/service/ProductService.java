package com.petmeeting.joy.store.service;

import java.util.List;
import java.util.Map;

import com.petmeeting.joy.store.model.CartDto;
import com.petmeeting.joy.store.model.ProductBean;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;

public interface ProductService {

	public void addProduct(ProductDto pro);
	
	public List<ProductDto> getProductList();
	
	public List<ProductDto> getProductListWithQuantity(ProductParam param);
	
	public void addProductOption(ProductOptionDto poption);
	
	public ProductDto getProduct(String pcode);
	
	// 띄워줄 상품 정보 가져오기
	public ProductBean getProductInfo(String pcode);
	
	// 상품 코드, 사이즈, 컬러로 수량 가져오기
	public boolean isSoldout(ProductOptionDto poption);
	
	public boolean isSoldout(String pcode);
	
	public int getProductOptionQuantity(ProductOptionDto poption);
	
	public int getProductOptionSeq(CartDto cart);
	
	public List<ProductOptionDto> getProductOption(String productcode);
	
	public void updateProductOption(ProductOptionDto poption);
	
	public int getProductCount(ProductParam param);
	
	public void updateProduct(ProductDto pro);
	
	public void deleteProductOption(int seq);
	
	public void deleteProduct(String productcode);
	
	public ProductDto duplicationCheck(String productcode);
	
	public void updateRecommend(ProductDto pro);
	
	public int getRecommendCount();
	
	public List<ProductDto> getRecommendProductList();
	
}
