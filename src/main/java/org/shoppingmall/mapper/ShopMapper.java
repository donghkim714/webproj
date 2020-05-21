package org.shoppingmall.mapper;

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

public interface ShopMapper {
	public List<GoodsViewVO> list_2(Map<String,Integer> map);
	public List<GoodsViewVO> list_1(HashMap<String, Object> map);
	public int count_1(HashMap<String, Object> map);
	public int count_2(int cateCode);
	public GoodsViewVO shopView(int gdsNum);
	public void registReply(ReplyVO vo);
	public List<ReplyListVO> replyList(int gdsNum);
	public void deleteReply(ReplyVO vo);
	public String replyUserIdCheck(int repNum);
	public void modifyReply(ReplyVO vo);
	public void addCart(CartVO vo);
	public List<CartListVO> cartList(String userId);
	public void deleteCart(CartVO vo);
	public void orderInfo(OrderVO vo);
	public void orderInfoDetails(OrderDetailsVO vo);
	public void cartAllDelete(String userId);
	public List<OrderVO> orderList(OrderVO vo);
	public List<OrderListVO> orderView(OrderVO vo);
	public int WarnCheck(String userId);
	}
