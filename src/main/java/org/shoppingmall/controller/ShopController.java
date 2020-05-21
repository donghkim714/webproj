package org.shoppingmall.controller;

import java.io.File;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.shoppingmall.domain.CartListVO;
import org.shoppingmall.domain.CartVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.domain.OrderDetailsVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.PagingVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.ReplyVO;
import org.shoppingmall.service.ShopService;
import org.shoppingmall.utils.PagingUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/shop/*")
public class ShopController {
	
	@Setter(onMethod_ = {@Autowired})
	private ShopService service;
	
	@GetMapping("/list")
	public void getList(@RequestParam("c") int cateCode,
						@RequestParam("l") int level,
						@RequestParam("num") int num,
						Model model) {
						//url에 있던 값들을 변수로 가져와 저장.
		
		log.info("get shop list");
		int firstCateCode = cateCode;
		int count = service.count(cateCode, level, firstCateCode);
		log.info("count : " + count);
		
		int postNum=6;
		PagingVO paging = new PagingVO();
		
		PagingUtils pu = new PagingUtils(num, count, paging,postNum);
		log.info("pu.end : " + pu.end);
		List<GoodsViewVO> list = service.list(cateCode, level,firstCateCode,pu.displayPost,pu.end);
		
		model.addAttribute("list", list);
		model.addAttribute("paging",paging);
		model.addAttribute("cateCode", cateCode);
		model.addAttribute("level", level);
		
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : " + fileName);
		
		File file = new File("c:\\imgUpload\\" + fileName);
		
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);			
					} catch (Exception e) {
			// TODO: handle exception
						e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/view")
	public void getView(@RequestParam("n") int gdsNum, Model model, HttpSession session) {
		log.info("get view");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		if(member != null) {
			String userId = member.getUserId();
			
			int userWarn = service.WarnCheck(userId);
			model.addAttribute("userWarn", userWarn);
		}
		
		GoodsViewVO vo = service.shopView(gdsNum);
		
		model.addAttribute("vo", vo);
		
		
	}
	

	
	@ResponseBody
	@PostMapping("/view/registReply")
	public void registReply(ReplyVO reply, HttpSession session) {
		log.info("regist reply");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		reply.setUserId(member.getUserId());
		
		service.registReply(reply);
	}
	
	@ResponseBody
	//ResponseBody를 설정하는 이유 : 뷰에서 컨트롤러에 전달한 데이터와 컨트롤러가 받으려는 매개변수의 데이터 형이 일치하지 않거나 다수 일경우 넣어줘야함.
	@GetMapping("/view/replyList")
	public List<ReplyListVO> getReplyList(@RequestParam("n") int gdsNum){
		log.info("get reply list");
		
		List<ReplyListVO> reply = service.replyList(gdsNum);
	
		return reply;
	}
	
	@ResponseBody
	@PostMapping("/view/deleteReply")
	public int getReplyList(ReplyVO vo, HttpSession session	) {
		log.info("post delete reply");
		int result =0;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = service.idCheck(vo.getRepNum());
		
		if(member.getUserId().equals(userId)) {
			vo.setUserId(member.getUserId());
			service.deleteReply(vo);
			
			result = 1;
		}
		return result;
	}
	
	@ResponseBody
	@PostMapping("/view/modifyReply")
	public int postModifyReply(ReplyVO vo ,HttpSession session) {
		int result= 0;
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = service.idCheck(vo.getRepNum());
		
		if(member.getUserId().equals(userId)) {
			
			vo.setUserId(member.getUserId());
			service.modifyReply(vo);
			result=1;		
			}
		return result;
	}
	
	@ResponseBody
	@PostMapping("/view/addCart")
	public int addCart(CartVO vo, HttpSession session) {
		
		int result = 0;
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member !=null) {
			vo.setUserId(member.getUserId());
			service.addCart(vo);
			result=1;
		}
		
		return result;
	}
	
	@GetMapping("/cartList")
	public void getCartList(HttpSession session, Model model) {
		log.info("get cart list");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		List<CartListVO> cartList = service.cartList(userId);
		
		model.addAttribute("cartList", cartList);
	}
	
	@ResponseBody
	@PostMapping("/deleteCart")
	public int postDeleteCart(@RequestParam(value="chBox[]") List<String> chArr ,CartVO vo, HttpSession session) {
		
		log.info("post delete cart");
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		int cartNum= 0 ;
		if(member != null) {
			vo.setUserId(userId);
			
			for(String i : chArr) {
				cartNum = Integer.parseInt(i);
				vo.setCartNum(cartNum);
				
				service.deleteCart(vo);
		
			}
			result=1;
		}
		return result;
	}
	//주문
	@PostMapping("/cartList")
	public String order(HttpSession session, OrderVO order, OrderDetailsVO orderDetail) {
		log.info("order");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		
		for(int i=1; i<= 6; i++) {
			subNum += (int)(Math.random() * 10);
		}
		
		String orderId = ymd + "_" + subNum;
		
		order.setOrderId(orderId);
		order.setUserId(userId);
		
		service.orderInfo(order);
		
		orderDetail.setOrderId(orderId);
		service.orderInfoDetails(orderDetail);
		
		service.cartAllDelete(userId);
		return "redirect:/shop/orderList";
	}
	
	@GetMapping("/orderList")
	public void getOrderList(HttpSession session, OrderVO vo, Model model) {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		vo.setUserId(userId);
		
		List<OrderVO> list = service.orderList(vo);
		
		model.addAttribute("list", list);
	}
	
	@GetMapping("/orderView")
	public void getOrderView(@RequestParam("n") String orderId, HttpSession session, Model model, OrderVO vo) {
		log.info("get orderView");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		if(member != null) {
			vo.setUserId(userId);
			vo.setOrderId(orderId);
			List<OrderListVO> list = service.orderView(vo);
			model.addAttribute("list", list);
		}
	}
}
