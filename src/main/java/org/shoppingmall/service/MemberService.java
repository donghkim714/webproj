package org.shoppingmall.service;

import javax.servlet.http.HttpSession;

import org.shoppingmall.domain.MemberVO;
import org.springframework.stereotype.Service;

@Service
public interface MemberService {
	public void signup(MemberVO vo) throws Exception;
	public MemberVO signin(MemberVO vo);
	public void signout(HttpSession session);
}
