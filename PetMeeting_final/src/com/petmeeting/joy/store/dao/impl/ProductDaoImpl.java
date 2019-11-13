package com.petmeeting.joy.store.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.store.dao.ProductDao;
import com.petmeeting.joy.store.model.CartDto;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	SqlSession sqlSession;
	String ns = "Product.";
	
	@Override
	public void addProduct(ProductDto pro) {
		sqlSession.insert(ns + "addProduct", pro);
	}

	@Override
	public List<ProductDto> getProductList() {
		return sqlSession.selectList(ns + "getProductList");
	}

	@Override
	public void addProductOption(ProductOptionDto poption) {
		sqlSession.insert(ns + "addProductOption", poption);
	}

	@Override
	public ProductDto getProduct(String pcode) {
		return sqlSession.selectOne(ns + "getProduct", pcode);
	}

	@Override
	public List<String> getSize(String pcode) {
		return sqlSession.selectList(ns + "getProductSize", pcode);
	}

	@Override
	public List<String> getColor(String pcode) {
		return sqlSession.selectList(ns + "getProductColor", pcode);
	}
	
	@Override
	public int getProductQuantity(String pcode) {
		return sqlSession.selectOne(ns + "getProductQuantity", pcode);
	}
	
	@Override
	public int getProductOptionQuantity(ProductOptionDto poption) {
		return sqlSession.selectOne(ns + "getProductOptionQuantity", poption);
	}
	
	@Override
	public int getProductOptionSeq(CartDto cart) {
		return sqlSession.selectOne(ns + "getProductOptionSeq", cart);
	}

	@Override
	public List<ProductDto> getProductListWithQuantity(ProductParam param) {
		return sqlSession.selectList(ns + "getProductListWithQuantity", param);
	}

	@Override
	public List<ProductOptionDto> getProductOption(String productcode) {
		return sqlSession.selectList(ns + "getProductOption", productcode);
	}

	@Override
	public void updateProductOption(ProductOptionDto poption) {
		sqlSession.update(ns + "updateProductOption", poption);
	}

	@Override
	public int getProductCount(ProductParam param) {
		return sqlSession.selectOne(ns + "getProductCount", param);
	}

	@Override
	public void updateProduct(ProductDto pro) {
		sqlSession.update(ns + "updateProduct", pro);
	}

	@Override
	public void deleteProductOption(int seq) {
		sqlSession.delete(ns + "deleteProductOption", seq);
	}

	@Override
	public void deleteProduct(String productcode) {
		sqlSession.delete(ns + "deleteProduct", productcode);
	}

	@Override
	public ProductDto duplicationCheck(String productcode) {
		return sqlSession.selectOne(ns + "duplicationCheck", productcode);
	}

	@Override
	public void updateRecommend(ProductDto pro) {
		sqlSession.update(ns + "updateRecommend", pro);
	}

	@Override
	public int getRecommendCount() {
		return sqlSession.selectOne(ns + "getRecommendCount");
	}

	@Override
	public List<ProductDto> getRecommendProductList() {
		return sqlSession.selectList(ns + "getRecommendProductList");
	}
	
}
