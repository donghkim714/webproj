package org.shoppingmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.shoppingmall.domain.CategoryVO;
import org.shoppingmall.domain.GoodsVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.MailVO;
import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.PagingVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.TotalVO;
import org.shoppingmall.domain.UserViewVO;
import org.shoppingmall.service.AdminService;
import org.shoppingmall.utils.PagingUtils;
import org.shoppingmall.utils.UploadFileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminService adminService;
	
	@Setter(onMethod_ = {@Autowired})
	private JavaMailSender mailSender;
	
	@Setter(onMethod_ = {@Autowired})
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Setter(onMethod_ = {@Autowired})
	private OAuth2Parameters googleOAuth2Parameters;

	@Resource(name="uploadPath")
	//servlet-context bean으로 등록 되어있음.
	private String uploadPath;
					//C:
	
	@GetMapping("/index")
	public void getIndex(Model model) throws Exception {
		log.info("get index........");
		List<TotalVO> list = adminService.cateTotal();
		TotalVO vo = adminService.adminFirst();
		
		for(TotalVO to : list) {
			to.setTotalPrice(vo.getTotalPrice());
			to.setTotalStock(vo.getTotalStock());
		}
		model.addAttribute("list", list);
	}
	
	@GetMapping("/goods/register")
	public void getGoodsRegister(Model model) {
		log.info("get goods register...........");
		
		List<CategoryVO> category = null;
		
		category = adminService.category();
		model.addAttribute("category",JSONArray.fromObject(category));
										//JSON형태로 변경
	}
	
	@PostMapping("/goods/register")
	public String postGoodsRegister(GoodsVO vo, MultipartFile file) throws Exception {
		log.info("post goods Register..............");
		
		String imgUploadPath = uploadPath + "/" + "imgUpload";
								//C://imgUpload
		
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if(file.getOriginalFilename() !=null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		}
		else {
			fileName = uploadPath + "/" + "images" + "/" + "none.png";
		}
		
		vo.setGdsImg(ymdPath + "/" + fileName);
		vo.setGdsThumnailImg(ymdPath + "/" + "s" + "/" + "s_" + fileName);
	
		adminService.register(vo);
		
		return "redirect:/admin/index";
	}
	
	@GetMapping("/goods/list")
	public void getGoodsList(Model model, @RequestParam("num") int num) {
		log.info("get goods list...............");
		int postNum = 6;
		int count = adminService.count();
		PagingVO vo = new PagingVO();
		PagingUtils pu = new PagingUtils(num,count, vo,postNum);

		List<GoodsViewVO> list = adminService.goodsList(pu.displayPost, pu.end);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", vo);
		
	}
	
	@GetMapping("/goods/view")
	public void getView(@RequestParam("n") int gdsNum, Model model) {
					//admin/goods/view?n=
		log.info("get goods view");
		
		GoodsViewVO goods = adminService.goodsView(gdsNum);
		
		model.addAttribute("goods", goods);
		
		List<CategoryVO> category = adminService.category();
		
		model.addAttribute("category", JSONArray.fromObject(category));
	}
	
	@GetMapping("/goods/modify")
	public void getModify(@RequestParam("n") int gdsNum, Model model) {
		log.info("get goods modify.......");
		
		GoodsViewVO goods = adminService.goodsView(gdsNum);
		
		model.addAttribute("goods", goods);
		
		List<CategoryVO> category = adminService.category();
		
		model.addAttribute("category", JSONArray.fromObject(category));
	}
	
	@PostMapping("/goods/modify")
	public String postModify(GoodsVO vo, MultipartFile file, HttpServletRequest req) throws Exception {
		log.info("post modify...................");
		
		//새 파일이 등록 되었는지 확인
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			//기존 파일 삭제
			log.info("req : " + req.getParameter("gdsImg"));
			new File(uploadPath + "/imgUpload/" + req.getParameter("gdsImg")).delete();
			new File(uploadPath + "/imgUpload/" + "/s/" + req.getParameter("gdsThumnailImg")).delete();
		
			//새로 첨부한 파일 등록
			
			String imgUploadPath = uploadPath + "/" + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
			vo.setGdsImg(ymdPath + "/" + fileName);
			vo.setGdsThumnailImg(ymdPath + "/" + "s" + "/" + "s_" + fileName);

		}
		else {
			//기존 이미지 사용
//			vo.setGdsImg(req.getParameter("gdsImg"));
//			vo.setGdsImg(req.getParameter("gdsThumnailImg"));
		}
		
		adminService.goodsUpdate(vo);
		
		return "redirect:/admin/index";
	}
	
	@PostMapping("/goods/ckUpload")
	public void postCKEditorImgUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload) throws Exception{
		log.info("post CKEditor img upload");
		
		UUID uid = UUID.randomUUID();
		//중복 방지용 uuid
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		//인코딩
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename();
			log.info("fileName : " + fileName);
			byte[] bytes = upload.getBytes();
			
			String ckUploadPath = uploadPath + "/ckUpload/" + uid + "_/";
			
			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush();       //out에 저장된 데이터를 전송하고 초기화함.
			
			String callback = req.getParameter("CKEditorFuncNum");
			printWriter = res.getWriter();
			String fileUrl = "/ckUpload/" + uid + "_" + fileName;
		
			//업로드시 메시지 출력
			printWriter.println("<script type='text/javascript'>"
							+ "window.parent.CKEDITOR.tools.callFunction("
							+ callback +",'" + fileUrl + "', '이미지를 업로드하였습니다.')"
							+ "</script>");
			
			printWriter.flush();
					
		} catch (IOException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(out != null) { out.close();}
				if(printWriter != null) { printWriter.close();}
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return;
	}
	
	@PostMapping("/goods/delete")
	public String postDelete(int n, RedirectAttributes rttr) {
		log.info("post delete..........");
		
		if(adminService.goodsDelete(n) == 1) {
			rttr.addAttribute("result", "success");
		}
		return "redirect:/admin/index";
	}
	
	@GetMapping("/goods/display")
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
	
		@GetMapping("/shop/orderList")
		public void getOrderList(Model model , @RequestParam("num") int num) {
			log.info("get order list");
			int postNum = 4;
			int count = adminService.orderCount();
			log.info("count : "+ count);
			PagingVO paging = new PagingVO();
			PagingUtils pu = new PagingUtils(num,count, paging, postNum);

			List<OrderVO> orderList = adminService.orderList(pu.displayPost, pu.end);
			
			model.addAttribute("orderList", orderList);
			model.addAttribute("paging", paging);
		}
		
		@GetMapping("/shop/orderView")
		public void getOrderList(@RequestParam("n") String orderId, OrderVO vo, Model model) {
			log.info("get order view");
			
			vo.setOrderId(orderId);
			List<OrderListVO> orderView = adminService.orderView(vo);
			
			model.addAttribute("orderView", orderView);
		}
		@PostMapping("/shop/orderView")
		public String postDelivery(OrderVO vo) {
			log.info("post delivery");
			
			adminService.delivery(vo);
			
			List<OrderListVO> orderView = adminService.orderView(vo);
			GoodsVO goods = new GoodsVO();
			
			for(OrderListVO i : orderView) {
				goods.setGdsNum(Integer.parseInt(i.getGdsNum()));
				goods.setGdsStock(i.getCartStock());
				adminService.changeStock(goods);
			}
			return "redirect:/admin/shop/orderView?n=" + vo.getOrderId();
		}
		
		@GetMapping("/shop/allReply")
		public void getAllReply(Model model, @RequestParam("num") int num) {
			log.info("get allReply");
			
	
			int postNum = 6;
			int count = adminService.replyCount();
			PagingVO paging = new PagingVO();
			PagingUtils pu = new PagingUtils(num,count, paging, postNum);

			List<ReplyListVO> vo = adminService.allReply(pu.displayPost, pu.end);
			
			model.addAttribute("list", vo);
			model.addAttribute("paging", paging);
		}
		
		
		@PostMapping("/shop/allReply")
		public String postDeleteReply(int repNum) {
			log.info("post allReply");
			adminService.deleteReply(repNum);
			
			return "redirect:/admin/mail/sendMail";
		}
		
		@GetMapping("/mail/sendMail")
		public void getSendMail() {
			 
			
		}
		@PostMapping("/mail/mailSending")
		public String postSendMail(MailVO vo, Model model) {
			int result = 0;
			try {
				
				String setfrom = "rlaehdgud714@gmail.com";
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				//보내는 사람 생략시 작동 x
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(vo.getTomail());
				log.info("to : " + vo.getTomail());
				messageHelper.setSubject(vo.getTitle());
				log.info("to : " + vo.getTitle());
				messageHelper.setText(vo.getContent());
				
				mailSender.send(message);
				result=1;
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
			model.addAttribute("result", result);
			return "redirect:/admin/index"; 
		}
		//유저목록
		@GetMapping("/user/userList")
		public void getUserList(MemberVO vo, @RequestParam("num") int num, Model model) {
			log.info("get userList");
			int count = adminService.userCount();
			PagingVO paging = new PagingVO();
			int postNum = 10;
			PagingUtils pu = new PagingUtils(num, count,paging, postNum);
			
			List<MemberVO> list = adminService.userList(pu.displayPost, pu.end);
			
			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			
		}
		
		@GetMapping("/user/userView")
		public void getUserList(@RequestParam("userId") String userId, Model model) {
			
			UserViewVO uv = adminService.userView(userId);
			if(uv != null) {
				uv.setUserId(userId);
			}
			else {
				uv = new UserViewVO();
				uv.setTotalAmount(0);
				uv.setTotalStock(0);
				uv.setUserId(userId);
				uv.setUserWarn(0);
			}
			
			model.addAttribute("uv", uv);
		}
		@PostMapping("/user/userView")
		public String postUserView(String userId, Model model) {
			int result = adminService.deleteUser(userId);
			model.addAttribute("result", result);
			return "redirect:/admin/user/userList?num=1";
		}
		
		@ResponseBody
		@PostMapping("/user/userModi")
		public void postUserModi(int userWarn, String userId) {
			log.info("post userModi");
			
			adminService.userModi(userWarn, userId);
		}
			
}
