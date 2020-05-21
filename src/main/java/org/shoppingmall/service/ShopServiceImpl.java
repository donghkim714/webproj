package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.CartListVO;
import org.shoppingmall.domain.CartVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.OrderDetailsVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.ReplyVO;
import org.shoppingmall.persistence.ShopDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jdk.internal.jline.internal.Log;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ShopServiceImpl implements ShopService {

	@Setter(onMethod_ = {@Autowired})
	private ShopDAO dao;
	
	@Override
	
	public List<GoodsViewVO> list(int cateCode, int level, int firstCateCode,int displayPost, int end) {
		// TODO Auto-generated method stub
		int cateCodeRef = 0;
		log.info("dp service : " + displayPost);
		System.out.println("dp service : " + displayPost);
		if(level ==1) {
			cateCodeRef = cateCode;
			return dao.list(cateCode , cateCodeRef,firstCateCode,displayPost,end);
		}
		else if(level == 2) {
			cateCodeRef = cateCode;
			return dao.list(cateCode, cateCodeRef, firstCateCode,displayPost,end);
		}
		else  {
			return dao.list(cateCode,displayPost,end);
		}
		
		
	}
	
	@Override
	public int count(int cateCode, int level, int firstCateCode) {
		// TODO Auto-generated method stub
		int cateCodeRef = 0;
		
		if(level ==1) {
			cateCodeRef = cateCode;
			return dao.count(cateCode , cateCodeRef,firstCateCode);
		}
		else if(level == 2) {
			cateCodeRef = cateCode;
			return dao.count(cateCode, cateCodeRef, firstCateCode);
		}
		else  {
			return dao.count(cateCode);
		}
		
		
	}
	
	@Override
	public GoodsViewVO shopView(int gdsNum) {
		return dao.shopView(gdsNum);
	}

	@Override
	public void registReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		dao.registReply(vo);
	}

	@Override
	public List<ReplyListVO> replyList(int gdsNum) {
		// TODO Auto-generated method stub
		return dao.replyList(gdsNum);
	}

	@Override
	public void deleteReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		dao.deleteReply(vo);
	}

	@Override
	public String idCheck(int repNum) {
		// TODO Auto-generated method stub
		return dao.idCheck(repNum);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		dao.modifyReply(vo);
	}

	@Override
	public void addCart(CartVO vo) {
		// TODO Auto-generated method stub
		dao.addCart(vo);
	}

	@Override
	public List<CartListVO> cartList(String userId) {
		// TODO Auto-generated method stub
		return dao.cartList(userId);
	}

	@Override
	public void deleteCart(CartVO vo) {
		// TODO Auto-generated method stub
		dao.addCart(vo);
	}

	@Override
	public void orderInfo(OrderVO vo) {
		// TODO Auto-generated method stub
		dao.orderInfo(vo);
	}

	@Override
	public void orderInfoDetails(OrderDetailsVO vo) {
		// TODO Auto-generated method stub
		dao.orderInfoDetails(vo);
	}

	@Override
	public void cartAllDelete(String userId) {
		// TODO Auto-generated method stub
		dao.cartAllDelete(userId);
	}

	@Override
	public List<OrderVO> orderList(OrderVO vo) {
		// TODO Auto-generated method stub
		return dao.orderList(vo);
	}

	@Override
	public List<OrderListVO> orderView(OrderVO vo) {
		// TODO Auto-generated method stub
		return dao.orderView(vo);
	}

	@Override
	public int WarnCheck(String userId) {
		// TODO Auto-generated method stub
		return dao.WarnCheck(userId);
	}

}
