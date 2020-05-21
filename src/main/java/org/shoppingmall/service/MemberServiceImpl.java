package org.shoppingmall.service;

import javax.servlet.http.HttpSession;

import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.persistence.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = {@Autowired})
	private MemberDAO dao;
	
	@Override
	public void signup(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.signup(vo);
	}

	@Override
	public MemberVO signin(MemberVO vo) {
		// TODO Auto-generated method stub
		return dao.signin(vo);
	}

	@Override
	public void signout(HttpSession session) {
		// TODO Auto-generated method stub
		session.invalidate();
	}

}
