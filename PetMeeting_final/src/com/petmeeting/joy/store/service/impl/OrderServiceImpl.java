package com.petmeeting.joy.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.store.dao.OrderDao;
import com.petmeeting.joy.store.model.OrderBean;
import com.petmeeting.joy.store.model.OrderDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.SalesDto;
import com.petmeeting.joy.store.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDao orderDao;

	@Override
	public int getProductOptionSeq(OrderBean oBean) {
		return orderDao.getProductOptionSeq(oBean);
	}
	
	@Override
	public void addOrder(OrderDto oDto) {
		orderDao.addOrder(oDto);
	}

	@Override
	public int getProductOptionQuantity(ProductOptionDto poDto) {
		return orderDao.getProductOptionQuantity(poDto);
	}

	@Override
	public boolean minusPQuantity(ProductOptionDto poDto) {
		return orderDao.minusPQuantity(poDto);
	}

	@Override
	public void addOrderDetail(OrderInfoDto oiDto) {
		orderDao.addOrderDetail(oiDto);
	}

	@Override
	public List<OrderInfoDto> getOrderDetailList(OrderInfoDto oiDto) {
		return orderDao.getOrderDetailList(oiDto);
	}

	@Override
	public int getMyorderReadyCount(String email) {
		return orderDao.getMyorderReadyCount(email);
	}

	@Override
	public int getMyorderDeliveryCount(String email) {
		return orderDao.getMyorderDeliveryCount(email);
	}

	@Override
	public int getMyorderCompleteCount(String email) {
		return orderDao.getMyorderCompleteCount(email);
	}
	
	@Override
	public int getTotalPrice(OrderDto oDto) {
		return orderDao.getTotalPrice(oDto);
	}

	@Override
	public int getOrderPoint(OrderInfoDto oiDto) {
		return orderDao.getOrderPoint(oiDto);
	}

	@Override
	public boolean savePoint(MemberDto mDto) {
		return orderDao.savePoint(mDto);
	}
	
	public List<OrderInfoDto> getMyorderListLatest(String email) {
		List<OrderInfoDto> olist = orderDao.getMyorderListLatest(email);
		
		if(olist != null) {
			for (int i = 0; i < olist.size(); i++) {
				OrderInfoDto oiDto = olist.get(i);
				List<OrderInfoDto> details = orderDao.getOrderDetailList(oiDto);
				
				if(details.size() == 1) {
					oiDto.setOrdername(details.get(0).getProductname());
				}else if(details.size() > 1) {
					oiDto.setOrdername(details.get(0).getProductname() + " 외 " + (details.size()-1) + "개");
				}
				
			}
		}
		
		return olist;
	}
	
	
	@Override
	public List<OrderInfoDto> orderRefernce(OrderParam param) {
		List<OrderInfoDto> olist = orderDao.orderRefernce(param);
		
		if(olist != null) {
			for (int i = 0; i < olist.size(); i++) {
				OrderInfoDto oiDto = olist.get(i);
				List<OrderInfoDto> details = orderDao.getOrderDetailList(oiDto);
				
				if(details.size() == 1) {
					oiDto.setOrdername(details.get(0).getProductname());
				}else if(details.size() > 1) {
					oiDto.setOrdername(details.get(0).getProductname() + " 외 " + (details.size()-1) + "개");
				}
				
			}
		}
		
		return olist;
	}

	@Override
	public int getOrderCount(OrderParam param) {
		return orderDao.getOrderCount(param);
	}
	
	
	@Override
	public boolean orderCancel(OrderInfoDto oiDto) {
		return orderDao.orderCancel(oiDto);
	}

	@Override
	public boolean cancelPoint(MemberDto mem) {
		return orderDao.cancelPoint(mem);
	}

	
	@Override
	public int getUse_Point(OrderInfoDto oiDto) {
		return orderDao.getUse_Point(oiDto);
	}

	
	@Override
	public List<OrderInfoDto> getRefundList(OrderInfoDto oiDto) {
		return orderDao.getRefundList(oiDto);
	}

	
	@Override
	public List<OrderInfoDto> getOrderRefundList(OrderInfoDto oiDto) {
		return orderDao.getOrderRefundList(oiDto);
	}

	
	@Override
	public void addRefund(RefundDto rDto) {
		orderDao.addRefund(rDto);
	}
	
	@Override
	public boolean updateStatus(OrderDto oDto) {
		return orderDao.updateStatus(oDto);
	}
	

	@Override
	public List<OrderInfoDto> getRefundBreakdown(OrderParam param) {
		return orderDao.getRefundBreakdown(param);
	}

	@Override
	public int getRefundCount(OrderParam param) {
		return orderDao.getRefundCount(param);
	}
	
	@Override
	public boolean updateRefundSeq(OrderDto oDto) {
		return orderDao.updateRefundSeq(oDto);
	}

	public List<OrderInfoDto> getMyorderListReview(String email) {
		return orderDao.getMyorderListReview(email);
	}

	
	
	/* 관리자 */
	
	@Override
	public List<OrderInfoDto> getAdminOrderList(OrderParam param) {
		List<OrderInfoDto> olist = orderDao.getAdminOrderList(param);
		
		if(olist != null) {
			for (int i = 0; i < olist.size(); i++) {
				OrderInfoDto oiDto = olist.get(i);
				List<OrderInfoDto> details = orderDao.getOrderDetailList(oiDto);
				
				if(details.size() == 1) {
					oiDto.setOrdername(details.get(0).getProductname());
				}else if(details.size() > 1) {
					oiDto.setOrdername(details.get(0).getProductname() + " 외 " + (details.size()-1) + "개");
				}
			}
		}
		
		return olist;
	}

	@Override
	public int getAdminOrderListCount(OrderParam param) {
		return orderDao.getAdminOrderListCount(param);
	}
	

	@Override
	public List<RefundDto> getAdminOrderDetailList(int rseq) {
		return orderDao.getAdminOrderDetailList(rseq);
	}

	@Override
	public boolean updateOrderStatus(String ordernumber) {
		return orderDao.updateOrderStatus(ordernumber);
	}

	@Override
	public List<RefundDto> getAdminRefundList(OrderParam param) {
		List<RefundDto> rlist = orderDao.getAdminRefundList(param);
		
		if(rlist != null) {
			for (int i = 0; i < rlist.size(); i++) {
				RefundDto rDto = new RefundDto();
				rDto = rlist.get(i);
				int rseq = rDto.getRefund_seq();
				
				List<RefundDto> details = orderDao.getAdminOrderDetailList(rseq);
				
				if(details.size() == 1) {
					rDto.setOrdername(details.get(0).getProductname());
				}else if(details.size() > 1) {
					rDto.setOrdername(details.get(0).getProductname() + " 외 " + (details.size()-1) + "개");
				}
			}
		}    
		
		return rlist;
		
	}

	@Override
	public int getAdminRefundCount(OrderParam param) {
		return orderDao.getAdminRefundCount(param);
	}

	@Override
	public List<OrderInfoDto> getRefundProductList(int seq) {
		return orderDao.getRefundProductList(seq);
		
	}

	@Override
	public String getMonthlySalesJson(SalesDto param) {
		List<SalesDto> list = orderDao.getMonthlySales(param);
		
		String json = "[";
		for (int i = 0; i < list.size(); i++) {
			SalesDto sales = list.get(i);
			json += sales.getSales() + ", ";
		}
		json = json.substring(0, json.lastIndexOf(","));
		
		json += "]";
		
		return json;
	}

	@Override
	public int getTodaySales() {
		return orderDao.getTodaySales();
	}

	@Override
	public String getProductSalesJson() {
		List<SalesDto> list = orderDao.getProductSales();
		String json = "[";
		for (int i = 0; i < list.size(); i++) {
			SalesDto sales = list.get(i);
			json += "{name:\"" + sales.getProductname() + "\",y:" + sales.getSales() + "},";
		}
		json = json.substring(0, json.lastIndexOf(","));
		
		json += "]";
		
		return json;
	}

	@Override
	public void updateRefundComplete(int refund_seq) {
		orderDao.updateRefundComplete(refund_seq);
	}

	@Override
	public void updateChangeComplete(int refund_seq) {
		orderDao.updateChangeComplete(refund_seq);
	}
	
	public OrderInfoDto getOrderDetail(String ordernumber) {
		return orderDao.getOrderDetail(ordernumber);
	}

	@Override
	public int getTodayOrder() {
		return orderDao.getTodayOrder();
	}

	@Override
	public int getDeliveryWait() {
		return orderDao.getDeliveryWait();
	}

	@Override
	public int getDeliveryIng() {
		return orderDao.getDeliveryIng();
	}

	@Override
	public int getCancel() {
		return orderDao.getCancel();
	}

	@Override
	public int getREreqCount(int status) {
		return orderDao.getREreqCount(status);
	}

	@Override
	public void updateDeliveryComplete(String ordernumber) {
		orderDao.updateDeliveryComplete(ordernumber);
	}
}	
