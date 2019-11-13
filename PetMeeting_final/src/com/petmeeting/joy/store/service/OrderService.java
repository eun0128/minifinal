package com.petmeeting.joy.store.service;

import java.util.List;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.store.model.OrderBean;
import com.petmeeting.joy.store.model.OrderDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.SalesDto;

public interface OrderService {
	
	public int getProductOptionSeq(OrderBean oBean);
	public void addOrder(OrderDto oDto);

	public int getProductOptionQuantity(ProductOptionDto poDto);
	public boolean minusPQuantity(ProductOptionDto poDto);
	
	public void addOrderDetail(OrderInfoDto oiDto);
	public List<OrderInfoDto> getOrderDetailList(OrderInfoDto oiDto);
	
	public int getMyorderReadyCount(String email);
	public int getMyorderDeliveryCount(String email);
	public int getMyorderCompleteCount(String email);

	public int getTotalPrice(OrderDto oDto);
	
	public int getOrderPoint(OrderInfoDto oiDto);
	public boolean savePoint(MemberDto mDto);
	
	public List<OrderInfoDto> getMyorderListLatest(String email);

	public List<OrderInfoDto> orderRefernce(OrderParam param);
	public int getOrderCount(OrderParam param);
	
	public boolean orderCancel(OrderInfoDto oiDto);
	public boolean cancelPoint(MemberDto mem);
	public int getUse_Point(OrderInfoDto oiDto);
	
	public List<OrderInfoDto> getRefundList(OrderInfoDto oiDto);
	public List<OrderInfoDto> getOrderRefundList(OrderInfoDto oiDto);
	public void addRefund(RefundDto rDto);
	public boolean updateStatus(OrderDto oDto);
	public List<OrderInfoDto> getRefundBreakdown(OrderParam param);
	public int getRefundCount(OrderParam param);
	public boolean updateRefundSeq(OrderDto oDto);
	
	
	public List<OrderInfoDto> getMyorderListReview(String email);
	
	
	/* 관리자 */
	public List<OrderInfoDto> getAdminOrderList(OrderParam param);
	public int getAdminOrderListCount(OrderParam param);
	public List<RefundDto> getAdminOrderDetailList(int rseq);
	
	public boolean updateOrderStatus(String ordernumber);
	
	public List<RefundDto> getAdminRefundList(OrderParam param);
	public int getAdminRefundCount(OrderParam param);
	
	public List<OrderInfoDto> getRefundProductList(int seq);
	
	public String getMonthlySalesJson(SalesDto param);
	
	public int getTodaySales();
	
	public String getProductSalesJson();
	
	public void updateRefundComplete(int refund_seq);

	public void updateChangeComplete(int refund_seq);
	
	public OrderInfoDto getOrderDetail(String ordernumber);
	
	public int getTodayOrder();
	
	public int getDeliveryWait();
	
	public int getDeliveryIng();
	
	public int getCancel();
	
	public int getREreqCount(int status);
	
	public void updateDeliveryComplete(String ordernumber);
}
