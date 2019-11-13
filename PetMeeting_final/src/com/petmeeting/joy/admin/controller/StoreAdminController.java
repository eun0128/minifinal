package com.petmeeting.joy.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.petmeeting.joy.login.model.MemberDto;
import com.petmeeting.joy.store.model.AnswerDto;
import com.petmeeting.joy.store.model.OrderInfoDto;
import com.petmeeting.joy.store.model.OrderParam;
import com.petmeeting.joy.store.model.ProductBean;
import com.petmeeting.joy.store.model.ProductDto;
import com.petmeeting.joy.store.model.ProductOptionDto;
import com.petmeeting.joy.store.model.ProductParam;
import com.petmeeting.joy.store.model.QnaBean;
import com.petmeeting.joy.store.model.QnaParam;
import com.petmeeting.joy.store.model.RefundDto;
import com.petmeeting.joy.store.model.ReviewBean;
import com.petmeeting.joy.store.model.ReviewParam;
import com.petmeeting.joy.store.model.SalesDto;
import com.petmeeting.joy.store.service.OrderService;
import com.petmeeting.joy.store.service.ProductService;
import com.petmeeting.joy.store.service.QnaService;
import com.petmeeting.joy.store.service.ReviewService;
import com.petmeeting.joy.util.FileUtility;
import com.petmeeting.joy.util.URLConn;

@Controller
public class StoreAdminController {

	@Autowired
	ProductService proService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping(value = "adstore.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adstore(Model model) {
		// 오늘 매출액
		model.addAttribute("todaySales", orderService.getTodaySales());
		
		// 월별 매출 통계
		SalesDto param = new SalesDto();
		String jsonTotal = orderService.getMonthlySalesJson(param);
		System.out.println("jsonTotal : " + jsonTotal);
		model.addAttribute("jsonTotal", jsonTotal);
		
		param.setCategory("의류");
		String jsonCloth = orderService.getMonthlySalesJson(param);
		System.out.println("jsonCloth : " + jsonCloth);
		model.addAttribute("jsonCloth", jsonCloth);
		
		param.setCategory("악세사리");
		String jsonAcce = orderService.getMonthlySalesJson(param);
		System.out.println("jsonAcce : " + jsonAcce);
		model.addAttribute("jsonAcce", jsonAcce);
		
		param.setCategory("반려용품");
		String jsonPet = orderService.getMonthlySalesJson(param);
		System.out.println("jsonPet : " + jsonPet);
		model.addAttribute("jsonPet", jsonPet);
		
		param.setCategory("기타");
		String jsonEtc = orderService.getMonthlySalesJson(param);
		System.out.println("jsonEtc : " + jsonEtc);
		model.addAttribute("jsonEtc", jsonEtc);
		
		// 상위 5개 매출 제품
		String json = orderService.getProductSalesJson();
		System.out.println("json : " + json);
		model.addAttribute("json", json);
		
		return "admin/store/adstore";
	}
	
	@RequestMapping(value = "adproductadd.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductadd() {
		return "admin/store/adproductadd";
	}
	
	@RequestMapping(value = "adproductaddAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductaddAf(ProductDto pro,
			@RequestParam(value = "fileload", required = false)MultipartFile fileload,	// required : 캐시저장 여부
			// RequestParam을 이용해서 servlet-context에 미리 설정해둔 MultipartResolver가 작동됨
			HttpServletRequest req) {
		
		// 파일명 충돌을 방지해주어야함, time을 이용해서 파일명 변경 후 업로드
		// DB <- 파일명을 변경 abc.txt -> 123456.txt -> abc, 123456 둘다 저장
		
		// filename을 취득
		String oldfilename = fileload.getOriginalFilename();

		// upload 경로 설정
		String fupload = req.getServletContext().getRealPath("/upload");
		System.out.println("업로드 경로 : " + fupload);
		
		// filename 변경(util method 이용)
		String newfilename = FileUtility.getNewFileName(oldfilename);
		
		// 업로드 파일명 설정
		pro.setFilename(newfilename);
		
		// 업로드할 파일 생성
		File file = new File(fupload + "/" + newfilename);
		
		try {
			// 실제 파일 업로드가 이루어짐
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("------------------------------------ adproductaddAf ProductDto : " + pro.toString());
		proService.addProduct(pro);
		
		return "redirect:/adproductoption.do";
	}
	
	@RequestMapping(value = "adproductoption.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductoption(Model model) {
		List<ProductDto> plist = proService.getProductList();
		model.addAttribute("plist", plist);
		
		return "admin/store/adproductoption";
	}
	
	@RequestMapping(value = "adproductoptionAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductoptionAf(ProductBean pbean) {
		System.out.println("------------------------------------ adproductoptionAf ProductOptionDto : " + pbean.toString());
		
		String[] psize_arr = pbean.getPsize();
		String[] pcolor_arr = pbean.getPcolor();
		
		for (int i = 0; i < psize_arr.length; i++) {
			for (int j = 0; j < pcolor_arr.length; j++) {
				proService.addProductOption(new ProductOptionDto(0, pbean.getProductcode(), psize_arr[i], pcolor_arr[j], pbean.getQuantity()));
			}
		}
		
		return "redirect:/adproductlist.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "editorimgupload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String editorimgupload(@RequestParam(value = "file", required = false)MultipartFile fileload,
			HttpServletRequest req) {
		
		String oldfilename = fileload.getOriginalFilename();
		String fupload = req.getServletContext().getRealPath("/upload");
	
		System.out.println("------------------------------------ editorimgupload path: " + fupload);

		String newfilename = FileUtility.getNewFileName(oldfilename);
		
		File file = new File(fupload + "/" + newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("------------------------------------ adproductaddAf ProductDto upload complete");
		return newfilename;
	}
	
	@RequestMapping(value = "adquestionlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adquestionlist(Model model, QnaParam param) {
		int pageNumber = param.getQ_pageNumber();
		int totalRecordCount = qnaService.getQnaAllCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 10;
		
		int start = (pageNumber+1) * recordCountPerPage - 9;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		System.out.println("------------------------------------ adproductlist param : " + param.toString());
		
		List<QnaBean> qlist = qnaService.getQnalistAll(param);
				
		model.addAttribute("param", param);
		model.addAttribute("qlist", qlist);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		return "admin/store/adquestionlist";
	}

	@RequestMapping(value = "adanswerwriteAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adanswerwriteAf(AnswerDto ans) {
		System.out.println("------------------------------------ adanswerwriteAf answer : " + ans.toString());
		
		qnaService.answerwrite(ans);
		
		return "redirect:/adquestionlist.do";
	}
	
	@RequestMapping(value = "adproductlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductlist(Model model, ProductParam param) {
		int pageNumber = param.getP_pageNumber();
		int totalRecordCount = proService.getProductCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 10;
		
		int start = (pageNumber+1) * recordCountPerPage - 9;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		System.out.println("------------------------------------ adproductlist param : " + param.toString());
		
		List<ProductDto> plist = proService.getProductListWithQuantity(param);
		
		model.addAttribute("param", param);
		model.addAttribute("plist", plist);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		return "admin/store/adproductlist";
	}
	
	@ResponseBody
	@RequestMapping(value = "adproductoptionlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> adproductoptionlist(String productcode) {
		List<ProductOptionDto> polist = proService.getProductOption(productcode);
		
		Map<String, Object> poMap = new HashMap<>();
		int pocount = 0;
		
		if(polist != null) {
			pocount = polist.size();
		}
		
		poMap.put("count", pocount);
		poMap.put("polist", polist);
		
		return poMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "quantityupdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void quantityupdate(ProductOptionDto poption) {
		System.out.println("------------------------------------ quantityupdate poption : " + poption.toString());
		
		proService.updateProductOption(poption);
	}
	
	@RequestMapping(value = "adproductupdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductupdate(String pcode, Model model) {
		
		ProductDto pro = proService.getProduct(pcode);
		
		model.addAttribute("pro", pro);
		
		return "admin/store/adproductupdate";
	}
	
	@RequestMapping(value = "adproductupdateAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductupdateAf(ProductDto pro, 
				@RequestParam(value = "fileload", required = false)MultipartFile fileload, HttpServletRequest req) {
		
		String oldfilename = fileload.getOriginalFilename();
		String newfilename = "";
		
		if(!oldfilename.equals("")) {
			String fupload = req.getServletContext().getRealPath("/upload");
			System.out.println("업로드 경로 : " + fupload);
			
			newfilename = FileUtility.getNewFileName(oldfilename);
			
			File file = new File(fupload + "/" + newfilename);
			
			try {
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		pro.setFilename(newfilename);
		System.out.println("------------------------------------ adproductaddAf ProductDto : " + pro.toString());
		
		proService.updateProduct(pro);
		
		return "redirect:/adproductdetail.do?pcode=" + pro.getProductcode();
	}
	
	@RequestMapping(value = "adreviewlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adreviewlist(Model model, ReviewParam param) {
		int pageNumber = param.getR_pageNumber();
		int totalRecordCount = reviewService.getReviewCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 10;
		
		int start = (pageNumber+1) * recordCountPerPage - 9;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		System.out.println("------------------------------------ adreviewlist param : " + param.toString());
		
		List<ReviewBean> rlist = reviewService.getReviewList(param);

		model.addAttribute("param", param);
		model.addAttribute("rlist", rlist);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		return "admin/store/adreviewlist";
	}
	
	@RequestMapping(value = "adreviewdelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adreviewdelete(int[] delete_seq) {
		
		for (int i = 0; i < delete_seq.length; i++) {
			reviewService.deleteReview(delete_seq[i]);
		}
		
		return "redirect:/adreviewlist.do";
	}
	
	@RequestMapping(value = "adqnadelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adqnadelete(int[] delete_seq) {

		for (int i = 0; i < delete_seq.length; i++) {
			qnaService.deleteQna(delete_seq[i]);
		}
		return "redirect:/adquestionlist.do";
	}
	
	@RequestMapping(value = "adanswerupdateAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adanswerupdateAf(AnswerDto ans) {
		System.out.println("------------------------------------ adanswerupdateAf answer : " + ans.toString());
		
		qnaService.updateAnswer(ans);
		
		return "redirect:/adquestionlist.do";
	}
	
	
	@RequestMapping(value = "adorderlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adorderlist(Model model, OrderParam param, String ordernumber, String deliveryOrdernumber) {
		System.out.println("------------------------------------ adorderlist 들왔다! ");
		System.out.println("adorder" + param.toString());
		
		int pageNumber = param.getPageNumber();
		int totalRecordCount = orderService.getAdminOrderListCount(param);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 10;
		
		int start = (pageNumber+1) * recordCountPerPage - 9;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);
		
		List<OrderInfoDto> olist = orderService.getAdminOrderList(param);
		System.out.println("olist : " + olist.toString());	
		
		model.addAttribute("param", param);
		model.addAttribute("olist", olist);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		
		if(ordernumber != null) {
//			System.out.println("if od : " +ordernumber);
			orderService.updateOrderStatus(ordernumber);
		}else if(deliveryOrdernumber != null) {
//			System.out.println("else if od : " + deliveryOrdernumber);
			orderService.updateDeliveryComplete(deliveryOrdernumber);
		}
		
		
		return "admin/store/adorderlist";
	}
	
	@RequestMapping(value = "adorderdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adorderdetail(Model model, OrderInfoDto oiDto) {
		
		List<OrderInfoDto> mylist = orderService.getOrderDetailList(oiDto);
		System.out.println(mylist.toString());
		int usepoint = orderService.getUse_Point(oiDto);
		
		model.addAttribute("mylist", mylist);
		model.addAttribute("usepoint", usepoint);
				
	
		return "admin/store/adorderdetail";
	}
	
	
	@RequestMapping(value = "adrefundlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adrefundlist(Model model, OrderParam param) {
		System.out.println("------------------------------------ adrefundlist 들왔다! ");

		
		int pageNumber = param.getPageNumber();
		int totalRecordCount = orderService.getAdminRefundCount(param);
		System.out.println("adrefundcount : " + totalRecordCount);
		int pageCountPerScreen = 10;
		int recordCountPerPage = 10;
		
		int start = (pageNumber+1) * recordCountPerPage - 9;
		int end = (pageNumber+1) * recordCountPerPage;
		
		param.setStart(start);
		param.setEnd(end);

		System.out.println(param.toString());
		System.out.println("trc " + totalRecordCount);
		System.out.println("pn " + pageNumber);
		
		List<RefundDto> rlist = orderService.getAdminRefundList(param);
		System.out.println("RLIST : " + rlist.toString());		
		
		
		model.addAttribute("param", param);
		model.addAttribute("rlist", rlist);
		
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pageCountPerScreen", pageCountPerScreen);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("pageNumber", pageNumber);
		
		
		return "admin/store/adrefundlist";
	}
	
	@ResponseBody
	@RequestMapping(value = "adrefundproduct.do", method = {RequestMethod.GET, RequestMethod.POST})
	public List<OrderInfoDto> adrefundproduct(int seq) {
		System.out.println("------------------------------------ adrefundproduct 들왔다! ");
		
		System.out.println("adrefundproduct seq " + seq);
		
		List<OrderInfoDto> olist = orderService.getRefundProductList(seq);
		System.out.println("adrefundproduct olist "+ olist.toString());
		
		return olist;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "adcancelpay.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adcancelpay(RefundDto refund, int amount) {
		System.out.println("------------------------------------ adcancelpay 들왔다! ");
		System.out.println("------------------------------------ adcancelpay RefundDto : " + refund.toString());
		System.out.println("------------------------------------ adcancelpay amount : " + amount);
		
		OrderInfoDto oi = orderService.getOrderDetail(refund.getOrdernumber());
		int pay_amount = oi.getTotalprice() - oi.getUse_point();	// 결제금액
		System.out.println("------------------------------------ adcancelpay 결제금액 : " + pay_amount);
		
		int refund_amount = 0;	// 환불될 금액
		int refund_point = 0;	// 환불될 포인트
		
		if(amount > pay_amount) {
			refund_amount = pay_amount;
			refund_point = amount - pay_amount;
		}else {
			refund_amount = amount;
		}
		
		refund_point = (int) (refund_point - amount * 0.05);
		
		System.out.println("------------------------------------ adcancelpay 최종 환불금액 : " + refund_amount);
		System.out.println("------------------------------------ adcancelpay 최종 환불포인트 : " + refund_point);
		
		JSONObject json = new JSONObject();
		
		json.put("merchant_uid", refund.getOrdernumber());
		json.put("reason", refund.getReason());
		json.put("amount", refund_amount);
		
		URLConn conn = new URLConn("http://192.168.0.7", 9050);
		String result = conn.urlPost(json);
		
		if(result.equals("refund complete")) {
			orderService.updateRefundComplete(refund.getRefund_seq());
			
			MemberDto mem = new MemberDto();
			mem.setEmail(oi.getEmail());
			mem.setSavepoint(refund_point);
			orderService.savePoint(mem);
			
			System.out.println("환불완료!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
		
		return result;
		
	}
	
		
	@RequestMapping(value = "adproductdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductdetail(Model model, String pcode) {
		System.out.println("------------------------------------ adproductdetail productcode : " + pcode);

		ProductBean pbean = proService.getProductInfo(pcode);
		
		ReviewParam param = new ReviewParam();
		param.setProductcode(pcode);
		
		if(reviewService.getReviewCount(param) > 0) {
			pbean.setScore(reviewService.getReviewScoreAvg(pcode));
		}
		
		model.addAttribute("pbean", pbean);
		
		return "admin/store/adproductdetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "adproductinfo_ajax.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ProductBean adproductdetail(String pcode) {
		
		ProductBean pbean = proService.getProductInfo(pcode);
		
		return pbean;
	}
	
	@ResponseBody
	@RequestMapping(value = "duplicationCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String duplicationCheck(String productcode) {
		
		ProductDto pro = proService.duplicationCheck(productcode);
		String result = "";
		
		if(pro == null) {
			result = "false";
		}else {
			result = "true";
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "productrecommend.do", method = {RequestMethod.GET, RequestMethod.POST}
			, produces = "application/json; charset=utf8")
	public Map<String, Object> productrecommend(ProductDto pro) {
		String msg = "";
		boolean update = false;
		Map<String, Object> jsonMap = new HashMap<>();
		
		int count = proService.getRecommendCount();
		
		if(pro.getRecommend() == 1) {	// 추천 도전!
			// 추천상품 6개 미만일 경우에만 추천이 되도록 제어
			System.out.println("------------------------------------ productrecommend try recommendation");
			if(count < 6) {
				System.out.println("------------------------------------ productrecommend recommending");
				proService.updateRecommend(pro);
				msg = "성공적으로 추천상품에 등록되었습니다.";
				update = true;
			} else {
				System.out.println("------------------------------------ productrecommend cannot recommend");
				msg = "상품추천은 6개까지만 가능합니다.";
			}
			
		}else if(pro.getRecommend() == 0) {	// 추천 취소!
			System.out.println("------------------------------------ productrecommend cancle recommendation");
			proService.updateRecommend(pro);
			msg = "상품추천을 취소하였습니다.";
			update = true;
		}
		
		jsonMap.put("msg", msg);
		jsonMap.put("update", update);
		
		return jsonMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "adproductchange.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adproductchange(int refund_seq) {
		
		orderService.updateChangeComplete(refund_seq);
		
		return "admin/store/adrefundlist";
	}
}
