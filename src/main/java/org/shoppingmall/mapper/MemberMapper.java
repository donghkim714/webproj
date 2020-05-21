package org.shoppingmall.mapper;

import org.shoppingmall.domain.MemberVO;

public interface MemberMapper {
	public void signup(MemberVO vo);
	public MemberVO signin(MemberVO vo);
}
