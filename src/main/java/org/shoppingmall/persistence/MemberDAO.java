package org.shoppingmall.persistence;

import org.shoppingmall.domain.CategoryVO;
import org.shoppingmall.domain.MemberVO;

public interface MemberDAO {
	public void signup(MemberVO vo);
	public MemberVO signin(MemberVO vo);
}
