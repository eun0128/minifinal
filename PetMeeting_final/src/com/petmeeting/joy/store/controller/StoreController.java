package com.petmeeting.joy.store.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.login.service.MemberService;
import com.petmeeting.joy.store.model.CartDto;
import com.petmeeting.joy.store.model.OrderBean;
import com.petmeeting.joy.store.model.OrderDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductBean;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.QuestionDto;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewDto;
import com.petmeeting.joy.store.model.ReviewParam;
import com.petmeeting.joy.store.service.OrderService;
import com.petmeeting.joy.store.service.ProductService;
import com.petmeeting.joy.store.service.QnaService;
import com.petmeeting.joy.store.service.ReviewService;
import com.petmeeting.joy.util.FileUtility;

@Controller
public class StoreController {

	@Autowired
	ProductService proService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MemberService memService;
	
	
	@RequestMapping(value = "alert.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String alert() {
		return "store/alert";
	}
	
	@RequestMapping(value = "productlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String productlist(Model model, ProductParam param) {
		
		if(param.getP_sorting() == null) {
			param.setP_sorting("latest");
		}
		
		param.setStart(1);
		param.setEnd(6);

		System.out.println("------------------------------------ productlist parameters : " + param.toString());
		List<ProductDto> plist = proService.getProductListWithQuantity(param);
		
		model.addAttribute("p_param", param);
		model.addAttribute("plist", plist);
		
		List<ProductDto> recommlist = proService.getRecommendProductList();
		model.addAttribute("recommlist", recommlist);
		
		return "store/productlist";
	}
	
	@ResponseBody
	@RequestMapping(value = "productmore.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> productmore(ProductParam param) {
		
		int count = param.getList_count();
		param.setStart(count + 1);
		param.setEnd(count + 6);
		
		List<ProductDto> plist_more = proService.getProductListWithQuantity(param);
		
		System.out.println("------------------------------------ productmore parameters : " + param.toString());
		
		int plist_count = 0;
		if(plist_more != null) {
			plist_count = plist_more.size();
		}
		
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("plist_more", plist_more);
		pMap.put("plist_count", plist_count);
		
		return pMap;
	}
	
	@RequestMapping(value = "productdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String productdetail(Model model, String pcode, ReviewParam r_param, QnaParam q_param) {
		System.out.println("------------------------------------ productdetail pcode : " + pcode);
		
		ProductBean pbean = proService.getProductInfo(pcode);
		
		if(r_param.getR_sorting() == null) {
			r_param.setR_sorting("latest");
		}
		
		r_param.setProductcode(pcode);
				
		int r_pageNumber = r_param.getR_pageNumber();
		int r_totalRecordCount = reviewService.getReviewCount(r_param);
		int r_pageCountPerScreen = 10;
		int r_recordCountPerPage = 5;
		
		int r_start = (r_pageNumber+1) * r_recordCountPerPage - 4;
		int r_end = (r_pageNumber+1) * r_recordCountPerPage;
		
		r_param.setStart(r_start);
		r_param.setEnd(r_end);
		
		System.out.println("------------------------------------ myreview review parameters : " + r_param.toString());
		model.addAttribute("r_param", r_param);
		
		List<ReviewBean> rlist = reviewService.getReviewList(r_param);
		
		if(rlist != null && rlist.size() != 0) {
			pbean.setScore(reviewService.getReviewScoreAvg(pcode));
		}
		
		model.addAttribute("pbean", pbean);
		model.addAttribute("rlist", rlist);
		
		System.out.println("------------------------------------ productdetail pbean : " + pbean.toString());
		
		model.addAttribute("r_totalRecordCount", r_totalRecordCount);
		model.addAttribute("r_pageCountPerScreen", r_pageCountPerScreen);
		model.addAttribute("r_recordCountPerPage", r_recordCountPerPage);
		model.addAttribute("r_pageNumber", r_pageNumber);
		
		q_param.setProductcode(pcode);
		
		int q_pageNumber = q_param.getQ_pageNumber();
		int q_totalRecordCount = qnaService.getQnaCount(q_param);
		int q_pageCountPerScreen = 10;
		int q_recordCountPerPage = 5;
		
		int q_start = (q_pageNumber+1) * q_recordCountPerPage - 4;
		int q_end = (q_pageNumber+1) * q_recordCountPerPage;
		
		q_param.setStart(q_start);
		q_param.setEnd(q_end);
		
		System.out.println("------------------------------------ myreview qna parameters : " + q_param.toString());
		model.addAttribute("q_param", q_param);
		
		List<QnaBean> qlist = qnaService.getQnalist(q_param);
		
		for (int i = 0; i < qlist.size(); i++) {
			System.out.println("------------------------------------ productdetail QnaBean" + qlist.get(i).toString());
		}
		
		model.addAttribute("qlist", qlist);

		model.addAttribute("q_totalRecordCount", q_totalRecordCount);
		model.addAttribute("q_pageCountPerScreen", q_pageCountPerScreen);
		model.addAttribute("q_recordCountPerPage", q_recordCountPerPage);
		model.addAttribute("q_pageNumber", q_pageNumber);
		
		return "store/productdetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "productquantity.do", method = {RequestMethod.GET, RequestMethod.POST}) 
	public String productquantity(ProductOptionDto poption) {
		System.out.println("------------------------------------ productquantity poption : " + poption.toString());
		
		boolean soldout = proService.isSoldout(poption);
		
		return soldout + "";
	}
	
	@RequestMapping(value = "cart.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cart(Model model, HttpServletRequest req) {
		System.out.println("------------------------------------ cart.do");
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		List<CartDto> clist = (List<CartDto>)req.getSession().getAttribute(user.getEmail());
		
		// 이전에 장바구니에 추가해놓은 상품의 품절여부 판단
		if(clist != null) {	// 장바구니가 비어있지 않을 경우에 판단
			for (CartDto cart : clist) {
				boolean soldout = proService.isSoldout(cart.getProductcode());
				cart.setSoldout(soldout);
			}
		}
		model.addAttribute("clist", clist);
		
		return "store/cart";
	}
	
	@ResponseBody
	@RequestMapping(value = "cartadd.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cartadd(CartDto cart, HttpServletRequest req) {
		
		int seq = proService.getProductOptionSeq(cart);
		cart.setProduct_option_seq(seq);
		System.out.println("------------------------------------ cartadd CartDto : " + cart.toString());
		
		HttpSession session = req.getSession();
	
		MemberDto user = (MemberDto)session.getAttribute("login");
		
		System.out.println("------------------------------------ cartadd login user : " + user.toString());
		List<CartDto> clist = (List<CartDto>)session.getAttribute(user.getEmail());
		
		if(clist == null || clist.size() == 0) {	// 카트세션이 없을 경우
			System.out.println("------------------------------------ cartadd session not exist");
			List<CartDto> newlist = new ArrayList<CartDto>();
			newlist.add(cart);
			
			session.setAttribute(user.getEmail(), newlist);
			session.setMaxInactiveInterval(60 * 60 * 24 * 7);
			System.out.println("------------------------------------ cartadd session create");
		}else {		// 카트세션이 있을 경우
			System.out.println("------------------------------------ cartadd session already exist");
			int findindex = -1;
			
			for(int i = 0; i < clist.size(); i++) {	
				// 추가할 상품의 product_option_seq와 기존의 list의 dto 중 product_option_seq가 같은 것이 있다면
				if(clist.get(i).getProduct_option_seq() == cart.getProduct_option_seq()) {
					findindex = i;
					break;
				}
			}

			if(findindex != -1) {	// 이미 동일한 상품이 추가되어있을 경우
				System.out.println("------------------------------------ cartadd session same product already exist");
				
				return "true";
			}else if(findindex == -1) {	// 동일한 상품이 없을 경우
				System.out.println("------------------------------------ cartadd session same product not exist");
				clist.add(cart);	// 그냥 카트에 추가
			}
		
		}
		
		return "false";
	}
	
	@ResponseBody
	@RequestMapping(value = "cartupdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void cartupdate(CartDto cart, HttpServletRequest req) {
		int seq = proService.getProductOptionSeq(cart);
		cart.setProduct_option_seq(seq);
		
		HttpSession session = req.getSession();
		
		MemberDto user = (MemberDto)session.getAttribute("login");
		List<CartDto> clist = (List<CartDto>)session.getAttribute(user.getEmail());
		
		int quantity = cart.getQuantity();
		
		for(int i = 0; i < clist.size(); i++) {	
			// 추가할 상품의 product_option_seq와 기존의 list의 dto 중 product_option_seq가 같은 것이 있다면
			if(clist.get(i).getProduct_option_seq() == cart.getProduct_option_seq()) {
				CartDto original = clist.get(i);
				int ori_quantity = original.getQuantity();

				original.setQuantity(ori_quantity + quantity);
				
				break;
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "cartupdate2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void cartupdate2(int index, int quantity, HttpServletRequest req) {
		System.out.println("------------------------------------ cartupdate2 index : " + index + ", quantity : " + quantity);
		
		HttpSession session = req.getSession();
		MemberDto user = (MemberDto)session.getAttribute("login");
		List<CartDto> clist = (List<CartDto>)session.getAttribute(user.getEmail());
		
		clist.get(index).setQuantity(quantity);
		
	}
	
	@RequestMapping(value = "cartdelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cartdelete(HttpServletRequest req) {
		// index를 이용하여 삭제 시 앞서 지워진 dto로 인해서 index가 하나씩 당겨지게됨.. --> IndexOutOfBoundsException...
		// Object를 이용하여 삭제해주어야한다!
		String[] s_index = req.getParameterValues("index");
		
		HttpSession session = req.getSession();
		MemberDto user = (MemberDto)session.getAttribute("login");
		
		List<CartDto> mylist = (List<CartDto>)session.getAttribute(user.getEmail());	// 현재 나의 장바구니
		
		List<CartDto> dlist = new ArrayList<CartDto>();		// 지워야할 object를 담아두기 위함
		
		// 삭제할 object를 index를 이용하여 하나하나 찾아낸다...
		for (int i = 0; i < s_index.length; i++) {
			int index = Integer.parseInt(s_index[i]);
			dlist.add(mylist.get(index));
		}
		
		// 찾아낸 object를 이용하여 장바구니리스트에서 제거한다.
		for (int i = 0; i < dlist.size(); i++) {
			CartDto delcart = dlist.get(i);
			
			System.out.println("------------------------------------ cartdelete delete CartDto : " + delcart.toString());
			mylist.remove(delcart);
		}
		
		return "redirect:/cart.do";
	}
	
	@RequestMapping(value = "qnawrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String qnawrite(QuestionDto que) {
		System.out.println("------------------------------------ qnawrite QuestionDto : " + que.toString());
		
		qnaService.qnawrite(que);
		
		return "redirect:/productdetail.do?pcode=" + que.getProductcode() + "#product-qnas";
	}
	
	
	@RequestMapping(value = "productorder.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String productorder(Model model, OrderBean oBean, String type) {
		System.out.println("------------------------------------ productorder : " + oBean.toString());
		
		model.addAttribute("oBean", oBean);
		model.addAttribute("type", type);
//		System.out.println("------------------------------------ productorder Type: " + type);
		
		return "store/productorder";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "productorderAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void productorderAf(OrderBean oBean, OrderDto dto, OrderInfoDto oiDto, ProductOptionDto poDto, MemberDto mDto, Model model, HttpServletRequest req){
		System.out.println("------------------------------------ productorderAf 들왔다! ");

		
		if(oiDto.getRequire() == "" || oiDto.getRequire() == null) {
			oiDto.setRequire("부재시 문 앞에 부탁드립니다");
			orderService.addOrderDetail(oiDto);
		}else {
			orderService.addOrderDetail(oiDto);
		}
		
		int seq = orderService.getProductOptionSeq(oBean);
		dto.setProduct_option_seq(seq);
		
		int quantity = orderService.getProductOptionQuantity(poDto);
		poDto.setPquantity(quantity);
		System.out.println("Af podto : " + poDto.toString());

		System.out.println("------------------------------------ productorderAf dto : " + dto.toString());
		
		orderService.addOrder(dto);		
		
		int orderP = orderService.getOrderPoint(oiDto);
		
		mDto.setSavepoint(orderP);
		orderService.savePoint(mDto);
	
		orderService.minusPQuantity(poDto);

//		return "store/productorder";
	}
	
	@RequestMapping(value = "cartorder.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String cartorder(OrderDto odto, OrderBean obean, ProductOptionDto poDto, HttpServletRequest req, Model model) {
		System.out.println("------------------------------------ cartorder 들왔다! ");

		String[] indexArr = req.getParameterValues("index");

		HttpSession session = req.getSession();
		MemberDto user = (MemberDto)session.getAttribute("login");
		
		List<CartDto> clist = (List<CartDto>) session.getAttribute(user.getEmail());	// 장바구니에 담긴 상품리스트
		List<CartDto> olist = new ArrayList<CartDto>();		// 선택한 상품만 담아줄 빈 리스트

		
		for (int i = 0; i < indexArr.length; i++) {
			int indexA = Integer.parseInt(indexArr[i]);
			olist.add(clist.get(indexA));
			System.out.println("cartorder for문 안의 olist : " + olist.get(i));
			
		}
		
		model.addAttribute("index", indexArr);
		model.addAttribute("olist", olist);
		
		return "store/productorder";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "cartorderAf.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public void cartorderAf(OrderDto odto, OrderBean obean, ProductOptionDto poDto, HttpServletRequest req) {
		System.out.println("------------------------------------ cartorderAf 들왔다! ");
		System.out.println("po : " + poDto.toString());
		
		System.out.println("------------------------------------ cartorderAf odto " + odto.toString());

		orderService.addOrder(odto);
		
		orderService.minusPQuantity(poDto);
	}
	
	@ResponseBody
	@RequestMapping(value = "cartorderdelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void cartorderdelete(HttpServletRequest req, OrderInfoDto oiDto, MemberDto mDto, Model model) {
		System.out.println("------------------------------------ cartorderdelete 들왔다 ");

		String[] strIndex = req.getParameterValues("index");
		System.out.println("cartorderdelete index : " +  strIndex.length);
		
		String usep = req.getParameter("use_point");
		System.out.println("del use_p : " + usep);
		
		if(oiDto.getRequire() == "" || oiDto.getRequire() == null) {
			oiDto.setRequire("부재시 문 앞에 부탁드립니다");
			orderService.addOrderDetail(oiDto);
			
			System.out.println("if문 :" + oiDto.toString());
		}else {
			orderService.addOrderDetail(oiDto);
			
			System.out.println("else문 :" + oiDto.toString());
		}
		
		int orderP = orderService.getOrderPoint(oiDto);
		
		mDto.setSavepoint(orderP);
		orderService.savePoint(mDto);

		HttpSession session = req.getSession();
		MemberDto user = (MemberDto)session.getAttribute("login");
		List<CartDto> mylist = (List<CartDto>)session.getAttribute(user.getEmail());	// 현재 나의 장바구니
		
		List<CartDto> dlist = new ArrayList<CartDto>();		// 지워야할 object를 담아두기 위함
		
		// 삭제할 object를 index를 이용하여 하나하나 찾아낸다...
		for (int i = 0; i < strIndex.length; i++) {
			int index = Integer.parseInt(strIndex[i]);
			dlist.add(mylist.get(index));
		}
		
		// 찾아낸 object를 이용하여 장바구니리스트에서 제거한다.
		for (int i = 0; i < dlist.size(); i++) {
			CartDto delcart = dlist.get(i);
			
			System.out.println("------------------------------------ cartdelete delete CartDto : " + delcart.toString());
			mylist.remove(delcart);
		}
		
	}
	
	@RequestMapping(value = "ordercomplete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String orderlist(HttpServletRequest req, Model model, OrderInfoDto oiDto, OrderDto oDto) {
		System.out.println("------------------------------------ ordercomplete 들왔다! ");

		MemberDto mem = (MemberDto) req.getSession().getAttribute("login");
		mem = memService.loginCheck(mem);		// 세션 갱신
		
		req.getSession().setAttribute("login", mem);	
		
		List<OrderInfoDto> olist = orderService.getOrderDetailList(oiDto);

		String usep = req.getParameter("use_point");
		System.out.println("usep : " + usep);
		
		
		model.addAttribute("usepoint", usep);
		model.addAttribute("olist", olist);
		
		
		return "store/ordercomplete";
	}

	
	@RequestMapping(value = "mystore.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String mystore(Model model, HttpServletRequest req){
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		String email = user.getEmail();
		
		int readyCount = orderService.getMyorderReadyCount(email);
		int deliveryCount = orderService.getMyorderDeliveryCount(email);
		int completeCount = orderService.getMyorderCompleteCount(email);
		
		model.addAttribute("rcount", readyCount);
		model.addAttribute("dcount", deliveryCount);
		model.addAttribute("ccount", completeCount);
		
		List<OrderInfoDto> olist = orderService.getMyorderListLatest(email);
		model.addAttribute("olist", olist);
		
		List<QnaBean> qlist = qnaService.getMyqnalistLatest(email);
		model.addAttribute("qlist", qlist);
		
		List<ReviewBean> rlist = reviewService.getMyReviewListLatest(email);
		model.addAttribute("rlist", rlist);
		
		return "store/mystore/main";
	}
	
	@RequestMapping(value = "myorder.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String myorder(HttpServletRequest req, Model model, MemberDto mem, OrderInfoDto oiDto, OrderParam param){
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		System.out.println("------------------------------------ myorder 들왔다!" );
		
		String email = user.getEmail();
		param.setEmail(email);
		param.setStatus(0);
		
		// 주문 취소 버튼을 누르면 주문번호가 들어옴
		String on = req.getParameter("ordernumber");	
		
		if(on != null) {
			orderService.orderCancel(oiDto);				// 주문을 취소상태로 변경
			int point = orderService.getOrderPoint(oiDto);	// 취소한 상품들의 적립금을 가져온다
			int usePoint = orderService.getUse_Point(oiDto);	// 주문 시 사용한 적립금 가져옴

			mem.setEmail(email);
			mem.setSavepoint(point);
			mem.setUse_point(usePoint);
			
			orderService.cancelPoint(mem);					// 가져온 적립금을 빼줌 사용한 적립금이 있다면 사용한 적립금은 돌려줌

			MemberDto mem_ = (MemberDto) req.getSession().getAttribute("login");
			mem_ = memService.loginCheck(mem_);		// 세션 갱신
			
			req.getSession().setAttribute("login", mem_);
			
		}
		
		
		String startdate = req.getParameter("startdate");
		String enddate = req.getParameter("enddate");
		
		// 페이징 
		int pn = param.getPageNumber();
		int start = pn * param.getRecordCountPerPage() + 1;
		int end = (pn + 1) * param.getRecordCountPerPage();

		param.setStart(start);
		param.setEnd(end);
		
		int totalRecordCount = orderService.getOrderCount(param);
		
		List<OrderInfoDto> olist = orderService.orderRefernce(param);
		
		
		model.addAttribute("olist", olist);
		model.addAttribute("pageNumber", pn);
		model.addAttribute("pageCountPerScreen", 10);	// 스크린당 페이지 수
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("start", startdate);
		model.addAttribute("end", enddate);
		

		return "store/mystore/myorder";
	}
	
	@RequestMapping(value = "orderdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String orderdetail(HttpServletRequest req, Model model, OrderInfoDto oiDto, MemberDto mem) {
		System.out.println("------------------------------------ orderdetail 들왔다!" );
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		List<OrderInfoDto> mylist = orderService.getOrderDetailList(oiDto);

		int usepoint = orderService.getUse_Point(oiDto);
		
		model.addAttribute("mylist", mylist);
		model.addAttribute("usepoint", usepoint);
				
		return "store/mystore/orderdetail";
	}
	
	@RequestMapping(value = "mycancel.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String mycancel(HttpServletRequest req, Model model, OrderInfoDto oiDto, OrderParam param){
		System.out.println("------------------------------------ mycancel 들왔다!" );
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		String email = user.getEmail();
		param.setEmail(email);
		
		param.setStatus(3);
		
		String startdate = req.getParameter("startdate");
		String enddate = req.getParameter("enddate");
		
		
		
		// 페이징 
		int pn = param.getPageNumber();
		int totalRecordCount = orderService.getOrderCount(param);
		
		int start = pn * param.getRecordCountPerPage() + 1;
		int end = (pn + 1) * param.getRecordCountPerPage();
		
		param.setStart(start);
		param.setEnd(end);
		
		List<OrderInfoDto> olist = orderService.orderRefernce(param);
		
		model.addAttribute("olist", olist);
		model.addAttribute("pageNumber", pn);
		model.addAttribute("pageCountPerScreen", 10);	// 스크린당 페이지 수
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("start", startdate);
		model.addAttribute("end", enddate);
		
		
		return "store/mystore/mycancel";
	}
	
	@RequestMapping(value = "myrefundapplication.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String myrefundapplication(HttpServletRequest req, Model model, OrderInfoDto oiDto, RefundDto rDto) {
		System.out.println("------------------------------------ myrefundapplication 들왔다!" );
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		oiDto.setEmail(user.getEmail());
		List<OrderInfoDto> rlist = orderService.getRefundList(oiDto);
		
		model.addAttribute("rlist", rlist);
		
	
		return "store/mystore/myrefundapplication";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "refundlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public List<OrderInfoDto> refundlist(HttpServletRequest req, Model model, OrderInfoDto oiDto) {
		System.out.println("------------------------------------ refundlist 들왔다!" );
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		
		String ordernumber = req.getParameter("ordernumber");
		 
		oiDto.setOrdernumber(ordernumber);
		List<OrderInfoDto> olist = orderService.getOrderRefundList(oiDto);
		System.out.println("------------------------------------ refundlist olist" + olist.toString());
		
		return olist;
		
	}
	
	@RequestMapping(value = "refundwrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String refundwrite(MultipartHttpServletRequest mtfReq, HttpServletRequest req, RefundDto rDto) {
		System.out.println("------------------------------------ refundwrite 들왔다!" );
		
		String filenames = "";
		
		List<MultipartFile> fileList = mtfReq.getFiles("fileload");
//		System.out.println(fileList.size());
		
		String path = req.getServletContext().getRealPath("/upload");

		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			long fileSize = mf.getSize(); // 파일 사이즈
			
			System.out.println("originFileName : " + originFileName);
			System.out.println("fileSize : " + fileSize);
			
			if(!originFileName.equals("")) {
				
				String newfilename = FileUtility.getNewFileName(originFileName);
				
				try {
					mf.transferTo(new File(path + "/" + newfilename));
			    } catch (IllegalStateException e) {
			        e.printStackTrace();
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    
			    filenames = filenames + "-" + newfilename;
			}
		}
		
		if(!filenames.equals("")) {
			filenames = filenames.substring(1);
		}
		
		System.out.println("------------------------------------ reviewwrite filenames : " + filenames);
		rDto.setFilename(filenames);
	
		// 선택 된 주문 상품만 업데이트 해줌 
		String[] indexArr = req.getParameterValues("order_seq");
		String select = req.getParameter("refund_select");
		
		orderService.addRefund(rDto);
		
		for (int i = 0; i < indexArr.length; i++) {
			OrderDto oDto = new OrderDto();
			
			int order_seq = Integer.parseInt(indexArr[i]);
			System.out.println("indexArr : " + indexArr[i]);
			
			oDto.setSeq(order_seq);
			
			orderService.updateRefundSeq(oDto);
			oDto.setRefund_select(select);

			orderService.updateStatus(oDto);
			
		}
		
		return "redirect:/myrefund.do";
	}
	
	@RequestMapping(value = "myrefund.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String myrefund(HttpServletRequest req, Model model, OrderInfoDto oiDto, RefundDto rDto, OrderParam param) {
		System.out.println("------------------------------------ myrefund 들왔다!" );
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		String email = user.getEmail();
		param.setEmail(email);
		
		// 조회한 날짜
		String startdate = req.getParameter("startdate");
		String enddate = req.getParameter("enddate");
		
		// 페이징 
		int pn = param.getPageNumber();
		int start = pn * param.getRecordCountPerPage() + 1;
		int end = (pn + 1) * param.getRecordCountPerPage();
		param.setStart(start);
		param.setEnd(end);
		
		int totalRecordCount = orderService.getRefundCount(param);
		List<OrderInfoDto> olist = orderService.getRefundBreakdown(param);
		
		model.addAttribute("olist", olist);
		model.addAttribute("pageNumber", pn);
		model.addAttribute("pageCountPerScreen", 10);	// 스크린당 페이지 수
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("start", startdate);
		model.addAttribute("end", enddate);
		
		return "store/mystore/myrefund";
	}
	
	
	@RequestMapping(value = "myreview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String myreview(Model model, HttpServletRequest req, ReviewParam param) {
		
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		param.setEmail(user.getEmail());
		
		int pageNumber = param.getR_pageNumber();
		int totalRecordCount = reviewService.getMyReviewCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 5;
		
		int start = (pageNumber+1) * recordCountPerPage - 4;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		
		System.out.println("------------------------------------ myreview parameters : " + param.toString());
		model.addAttribute("param", param);
		
		List<ReviewBean> rlist = reviewService.getMyReviewList(param);
		model.addAttribute("rlist", rlist);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		return "store/mystore/myreview";
	}
	
	@RequestMapping(value = "mywritablereview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String mywritablereview(Model model, HttpServletRequest req) {
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		List<OrderInfoDto> olist = orderService.getMyorderListReview(user.getEmail());
		
		model.addAttribute("olist", olist);
		
		return "store/mystore/mywritablereview";
	}
	
	@RequestMapping(value = "reviewwrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewwrite(ReviewDto review,
			MultipartHttpServletRequest mtfReq, HttpServletRequest req) {
		System.out.println("------------------------------------ reviewwrite StoreReviewDto : " + review.toString());
		
		String filenames = "";
		
		List<MultipartFile> fileList = mtfReq.getFiles("fileload");
		System.out.println(fileList.size());
		
		String path = req.getServletContext().getRealPath("/upload");
		
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			long fileSize = mf.getSize(); // 파일 사이즈
			
			System.out.println("originFileName : " + originFileName);
			System.out.println("fileSize : " + fileSize);
			
			if(!originFileName.equals("")) {
				
				String newfilename = FileUtility.getNewFileName(originFileName);
				
				try {
					mf.transferTo(new File(path + "/" + newfilename));
			    } catch (IllegalStateException e) {
			        e.printStackTrace();
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    
			    filenames = filenames + "-" + newfilename;
			}
		}
		
		if(!filenames.equals("")) {
			filenames = filenames.substring(1);
		}
		
		System.out.println("------------------------------------ reviewwrite filenames : " + filenames);
		review.setFilename(filenames);
		
		reviewService.writeReview(review);
		
		return "redirect:/mywritablereview.do";
	}
	
	@RequestMapping(value = "delreview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String delreview(int seq) {

		reviewService.deleteReview(seq);
		
		return "redirect:/myreview.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "updatereview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ReviewBean updatereview(int seq) {
		
		return reviewService.getReview(seq);
	}
	
	@RequestMapping(value = "updatereviewAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String updatereviewAf(ReviewDto review, MultipartHttpServletRequest mtfReq, HttpServletRequest req) {
		
		System.out.println("------------------------------------ updatereviewAf ReviewDto : " + review.toString());
		
		String filenames = "";
		
		List<MultipartFile> fileList = mtfReq.getFiles("fileload");
//		System.out.println(fileList.size());
		
		String path = req.getServletContext().getRealPath("/upload");
		
		if(fileList.size() > 1) {
			for (MultipartFile mf : fileList) {
			    String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			    long fileSize = mf.getSize(); // 파일 사이즈
			
			    System.out.println("originFileName : " + originFileName);
			    System.out.println("fileSize : " + fileSize);
			
			    String newfilename = FileUtility.getNewFileName(originFileName);
			    
			    try {
			        mf.transferTo(new File(path + "/" + newfilename));
			    } catch (IllegalStateException e) {
			        e.printStackTrace();
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    
			    filenames = filenames + "-" + newfilename;
			}
		}
		
		if(!filenames.equals("")) {
			filenames = filenames.substring(1);
		}
		
		System.out.println("------------------------------------ reviewwrite filenames : " + filenames);
		review.setFilename(filenames);
		
		reviewService.updateReview(review);
		
		return "redirect:/myreview.do";
	}
	

	@RequestMapping(value = "myquestion.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String myquestion(Model model, HttpServletRequest req, QnaParam param) {
		MemberDto user = (MemberDto)req.getSession().getAttribute("login");
		if(user == null) {
			return "store/alert";
		}
		
		param.setEmail(user.getEmail());
		
		int pageNumber = param.getQ_pageNumber();
		int totalRecordCount = qnaService.getMyqnaCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 5;
		
		int start = (pageNumber+1) * recordCountPerPage - 4;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		
		System.out.println("------------------------------------ myquestion parameters : " + param.toString());
		model.addAttribute("param", param);
		
		List<QnaBean> qlist = qnaService.getMyqnaList(param);
		model.addAttribute("qlist", qlist);
		
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		return "store/mystore/myquestion";
	}

	@RequestMapping(value = "mytracking.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String mytracking() {
		
		
		return "store/mystore/mytracking";
	}
	
	

}
