package com.petmeeting.joy.store.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.store.dao.OrderDao;
import com.petmeeting.joy.store.model.OrderBean;
import com.petmeeting.joy.store.model.OrderDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.SalesDto;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	SqlSession sqlSession;
	String ns = "Order.";
	
	@Override
	public int getProductOptionSeq(OrderBean oBean) {
		return sqlSession.selectOne(ns + "getProductOptionSeq", oBean);
	}
	@Override
	public void addOrder(OrderDto oDto) {
		sqlSession.insert(ns + "addOrder", oDto);
	}
	
	@Override
	public int getProductOptionQuantity(ProductOptionDto poDto) {
		return sqlSession.selectOne(ns + "getProductOptionQuantity", poDto);
	}
	
	@Override
	public boolean minusPQuantity(ProductOptionDto poDto) {
		int n = sqlSession.update(ns + "minusPQuantity", poDto);
		return n>0?true:false;
	}
	
	@Override
	public void addOrderDetail(OrderInfoDto oiDto) {
		sqlSession.insert(ns + "addOrderDetail", oiDto);
	}
	
	@Override
	public List<OrderInfoDto> getOrderDetailList(OrderInfoDto oiDto) {
		return sqlSession.selectList(ns + "getOrderDetailList", oiDto);
	}

	@Override
	public int getMyorderReadyCount(String email) {
		return sqlSession.selectOne(ns + "getMyorderReadyCount", email);
	}
	@Override
	public int getMyorderDeliveryCount(String email) {
		return sqlSession.selectOne(ns + "getMyorderDeliveryCount", email);
	}
	@Override
	public int getMyorderCompleteCount(String email) {
		return sqlSession.selectOne(ns + "getMyorderCompleteCount", email);
	}
	
	@Override
	public int getTotalPrice(OrderDto oDto) {
		return sqlSession.selectOne(ns + "getTotalPrice", oDto);
	}
	
	@Override
	public int getOrderPoint(OrderInfoDto oiDto) {
		return sqlSession.selectOne(ns + "getOrderPoint", oiDto);
	}
	@Override
	public boolean savePoint(MemberDto mDto) {
		int n = sqlSession.update(ns + "savePoint", mDto);
		return n>0?true:false;
	}
	
	@Override
	public List<OrderInfoDto> getMyorderListLatest(String email) {
		return sqlSession.selectList(ns + "getMyorderListLatest", email);
	}

	@Override
	public List<OrderInfoDto> orderRefernce(OrderParam param) {
		return sqlSession.selectList(ns + "orderRefernce", param);
	}
	@Override
	public int getOrderCount(OrderParam param) {
		return sqlSession.selectOne(ns + "getOrderCount", param);
	}
	
	@Override
	public List<OrderInfoDto> getMyorderListReview(String email) {
		return sqlSession.selectList(ns + "getMyorderListReview", email);
	}
	
	@Override
	public boolean orderCancel(OrderInfoDto oiDto) {
		int n = sqlSession.update(ns + "orderCancel", oiDto);
		return n>0?true:false;
	}
	@Override
	public boolean cancelPoint(MemberDto mem) {
		int n = sqlSession.update(ns + "cancelPoint", mem);
		return n>0?true:false;
	}
	@Override
	public int getUse_Point(OrderInfoDto oiDto) {
		return sqlSession.selectOne(ns + "getUse_Point", oiDto);
	}
	
	@Override
	public List<OrderInfoDto> getRefundList(OrderInfoDto oiDto) {
		return sqlSession.selectList(ns + "getRefundList", oiDto);
	}
	@Override
	public List<OrderInfoDto> getOrderRefundList(OrderInfoDto oiDto) {
		return sqlSession.selectList(ns + "getOrderRefundList", oiDto);
	}
	@Override
	public void addRefund(RefundDto rDto) {
		sqlSession.insert(ns + "addRefund", rDto);
	}
	@Override
	public boolean updateStatus(OrderDto oDto) {
		int n = sqlSession.update(ns + "updateStatus", oDto);
		return n>0?true:false;
	}
	@Override
	public List<OrderInfoDto> getRefundBreakdown(OrderParam param) {
		return sqlSession.selectList(ns + "getRefundBreakdown", param);
	}
	@Override
	public int getRefundCount(OrderParam param) {
		return sqlSession.selectOne(ns + "getRefundCount", param);
	}
	
	@Override
	public boolean updateRefundSeq(OrderDto oDto) {
		int n = sqlSession.update(ns+ "updateRefundSeq", oDto);
		return n>0?true:false;
	}
	
	
	
	/* 관리자 */
	
	
	@Override
	public List<OrderInfoDto> getAdminOrderList(OrderParam param) {
		return sqlSession.selectList(ns + "getAdminOrderList", param);
	}
	@Override
	public int getAdminOrderListCount(OrderParam param) {
		return sqlSession.selectOne(ns + "getAdminOrderListCount", param);
	}
	
	@Override
	public List<RefundDto> getAdminOrderDetailList(int rseq) {
		return sqlSession.selectList(ns + "getAdminOrderDetailList", rseq);
	}
	@Override
	public boolean updateOrderStatus(String ordernumber) {
		int n = sqlSession.update(ns + "updateOrderStatus", ordernumber);
		return n>0?true:false;
	}

	@Override
	public List<RefundDto> getAdminRefundList(OrderParam param) {
		return sqlSession.selectList(ns + "getAdminRefundList", param);
	}
	@Override
	public int getAdminRefundCount(OrderParam param) {
		return sqlSession.selectOne(ns + "getAdminRefundCount", param);
	}
	@Override
	public List<OrderInfoDto> getRefundProductList(int seq) {
		return sqlSession.selectList(ns + "getRefundProductList", seq);
	}
	@Override
	public List<SalesDto> getMonthlySales(SalesDto param) {
		return sqlSession.selectList(ns + "getMonthlySales", param);
	}
	@Override
	public int getTodaySales() {
		return sqlSession.selectOne(ns + "getTodaySales");
	}
	@Override
	public List<SalesDto> getProductSales() {
		return sqlSession.selectList(ns + "getProductSales");
	}
	@Override
	public void updateRefundComplete(int refund_seq) {
		sqlSession.update(ns + "updateRefundComplete", refund_seq);
	}
	@Override
	public OrderInfoDto getOrderDetail(String ordernumber) {
		return sqlSession.selectOne(ns + "getOrderDetail", ordernumber);
	}
	
	@Override
	public void updateChangeComplete(int refund_seq) {
		sqlSession.update(ns + "updateChangeComplete", refund_seq);
	}
	@Override
	public int getTodayOrder() {
		return sqlSession.selectOne(ns + "getTodayOrder");
	}
	@Override
	public int getDeliveryWait() {
		return sqlSession.selectOne(ns + "getDeliveryWait");
	}
	@Override
	public int getDeliveryIng() {
		return sqlSession.selectOne(ns + "getDeliveryIng");
	}
	@Override
	public int getCancel() {
		return sqlSession.selectOne(ns + "getCancel");
	}
	@Override
	public int getREreqCount(int status) {
		return sqlSession.selectOne(ns + "getREreqCount", status);
	}
	
	@Override
	public void updateDeliveryComplete(String ordernumber) {
		sqlSession.update(ns + "updateDeliveryComplete", ordernumber);
	}
	
	
}
