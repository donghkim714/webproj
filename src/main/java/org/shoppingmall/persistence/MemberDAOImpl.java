package org.shoppingmall.persistence;

import org.shoppingmall.domain.CategoryVO;
import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.mapper.AdminMapper;
import org.shoppingmall.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	@Override
	public void signup(MemberVO vo) {
		// TODO Auto-generated method stub
		mapper.signup(vo);
	}

	@Override
	public MemberVO signin(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.signin(vo);
	}

	

}
