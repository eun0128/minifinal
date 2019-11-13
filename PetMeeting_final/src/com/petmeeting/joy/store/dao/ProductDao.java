package com.petmeeting.joy.store.dao;

import java.util.List;

import com.petmeeting.joy.store.model.CartDto;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;

public interface ProductDao {
	
	public void addProduct(ProductDto pro);
	
	public List<ProductDto> getProductList();
	
	public List<ProductDto> getProductListWithQuantity(ProductParam param);
	
	public void addProductOption(ProductOptionDto poption);
	
	// 화면에 띄워줄 상품정보 불러오자
	public ProductDto getProduct(String pcode);	// 상품정보
	public List<String> getSize(String pcode);	// 상품사이즈 정보
	public List<String> getColor(String pcode);	// 상품컬러 정보
	
	// 상품 품절여부 확인
	public int getProductQuantity(String pcode);
	
	// ProductOptionDto를 이용해 재고수량 가져오기
	public int getProductOptionQuantity(ProductOptionDto poption);
	
	// CartDto를 이용해 product_option_seq 가져오기
	public int getProductOptionSeq(CartDto cart);
	
	/**
	 * 상품 코드를 이용하여 상품 옵션 리스트 가져오기
	 */
	public List<ProductOptionDto> getProductOption(String productcode);
	
	/**
	 * 상품 재고 업데이트
	 */
	public void updateProductOption(ProductOptionDto poption);
	
	/**
	 * 상품 리스트 카운트
	 */
	public int getProductCount(ProductParam param);
	
	/**
	 * 상품 수정
	 */
	public void updateProduct(ProductDto pro);
	
	/**
	 * 시퀀스로 상품 옵션삭제
	 */
	public void deleteProductOption(int seq);
	
	/**
	 * 상품코드로 상품삭제하기
	 */
	public void deleteProduct(String productcode);
	
	/**
	 * 상품코드 중복확인
	 */
	public ProductDto duplicationCheck(String productcode);
	
	/**
	 * 상품 관리자 추천
	 */
	public void updateRecommend(ProductDto pro);
	
	/**
	 * 추천상품 갯수 가져오기
	 */
	public int getRecommendCount();
	
	/**
	 * 추천상품 리스트 가져오기
	 */
	public List<ProductDto> getRecommendProductList();
}
