package org.shoppingmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.shoppingmall.domain.MemberVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//인터셉터는 특정 경로를 요청하여 컨트롤러에 접근하는 도중에 가로채서 그 전/후에 실행되는 기능.
public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override		//컨트롤러 실행 전 실행.
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();		//현재 세션을 불러온다.
		MemberVO member = (MemberVO)session.getAttribute("member");	//그 세션에서 member 세션을 찾아 해당 객체에 저장한다.
		if(member == null || member.getVerify() != 9) {				
			response.sendRedirect("/");
			return false;
		}
		return true;	//반환 값이 true이면 컨트롤러 진행.
	}
	//프로젝트가 실행되는 웹환경과 관련된 설정은 servlet-context에서 설정해야함.
	
}
