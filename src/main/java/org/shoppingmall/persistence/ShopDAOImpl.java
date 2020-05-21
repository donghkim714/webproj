package org.shoppingmall.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.shoppingmall.domain.CartListVO;
import org.shoppingmall.domain.CartVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.OrderDetailsVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.ReplyVO;
import org.shoppingmall.mapper.ShopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class ShopDAOImpl implements ShopDAO {

	@Setter(onMethod_ = { @Autowired })
	private ShopMapper mapper;

	@Override
	public List<GoodsViewVO> list(int cateCode, int cateCodeRef, int firstCateCode,int displayPost, int end) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		log.info("dp dao : " + displayPost);
		System.out.println("dp dao : " + displayPost);
		System.out.println("end dao : " + end);

		map.put("cateCode", cateCode);
		map.put("cateCodeRef", cateCodeRef);
		map.put("firstCateCode", firstCateCode);
		map.put("displayPost", displayPost);
		map.put("end", end);
		
		return mapper.list_1(map);
	}

	@Override
	public List<GoodsViewVO> list(int cateCode,int displayPost, int end) {
		// TODO Auto-generated method stub
		Map<String,Integer> map = new HashMap<>();
		log.info("dp dao : " + displayPost);
		System.out.println("dp dao : " + displayPost);
		System.out.println("end dao : " + end);
		map.put("cateCode", cateCode);
		map.put("displayPost", displayPost);
		map.put("end", end);
		return mapper.list_2(map);
	}

	@Override
	public int count(int cateCode, int cateCodeRef, int firstCateCode) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();

		map.put("cateCode", cateCode);
		map.put("cateCodeRef", cateCodeRef);
		map.put("firstCateCode", firstCateCode);
		
		return mapper.count_1(map);
	}
	
	@Override
	public int count(int cateCode) {
		// TODO Auto-generated method stub

		return mapper.count_2(cateCode);
	}
	@Override
	public GoodsViewVO shopView(int gdsNum) {
		// TODO Auto-generated method stub
		return mapper.shopView(gdsNum);
	}

	@Override
	public void registReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.registReply(vo);
	}

	@Override
	public List<ReplyListVO> replyList(int gdsNum) {
		// TODO Auto-generated method stub
		return mapper.replyList(gdsNum);
	}

	@Override
	public void deleteReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.deleteReply(vo);
	}

	@Override
	public String idCheck(int repNum) {
		// TODO Auto-generated method stub
		return mapper.replyUserIdCheck(repNum);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.modifyReply(vo);
	}

	@Override
	public void addCart(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.addCart(vo);
	}

	@Override
	public List<CartListVO> cartList(String userId) {
		// TODO Auto-generated method stub
		return mapper.cartList(userId);
	}

	@Override
	public void deleteCart(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.addCart(vo);
	}

	@Override
	public void orderInfoDetails(OrderDetailsVO vo) {
		// TODO Auto-generated method stub
		mapper.orderInfoDetails(vo);
	}

	@Override
	public void orderInfo(OrderVO vo) {
		// TODO Auto-generated method stub
		mapper.orderInfo(vo);
	}

	@Override
	public void cartAllDelete(String userId) {
		// TODO Auto-generated method stub
		mapper.cartAllDelete(userId);
	}

	@Override
	public List<OrderVO> orderList(OrderVO vo) {
		// TODO Auto-generated method stub
		return mapper.orderList(vo);
	}

	@Override
	public List<OrderListVO> orderView(OrderVO vo) {
		// TODO Auto-generated method stub
		return mapper.orderView(vo);
	}

	@Override
	public int WarnCheck(String userId) {
		// TODO Auto-generated method stub
		return mapper.WarnCheck(userId);
	}

}
