package org.shoppingmall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {
	
	@Inject
	private MemberService service;
	
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	@GetMapping("/signup")
	public void getSignup() throws Exception{
		log.info("get signup.,.....");
	}
	
	@PostMapping("/signup")
	public String postSignup(MemberVO vo) {
		log.info("post signup.........");
		
		String inputPass = vo.getUserPass();
		String pass = passEncoder.encode(inputPass);
		vo.setUserPass(pass);
		
		try {
			service.signup(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/";
	}
	@PostMapping("/signin")
	public String postSignin(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) {
		log.info("post signin");
		
		MemberVO login = service.signin(vo);
		HttpSession session = req.getSession();
		log.info("login : " + login);
		
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/signin";
			}
		//--------------------------아이디 실패시---------------
		
		boolean passMatch = passEncoder.matches(vo.getUserPass(), login.getUserPass());
		
		if(passMatch) {
			session.setAttribute("member", login);
		}
		else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			//redirect 시 같이 전달해줌.
			return "redirect:/member/signin";
		}
		return "redirect:/";
				//내부적으로 response.sendRedirect()를 처리해줌.
	}
	
	@GetMapping("/signin")
	public void getSignin() {
		log.info("get signin........");
	}
	
	@GetMapping("/signout")
	public String getSignout(HttpSession session) {
		log.info("signout.........");
		try {
			service.signout(session);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/";

	}
}
