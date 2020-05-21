package org.shoppingmall.persistence;

import java.util.HashMap;
import java.util.List;

import org.shoppingmall.domain.CartListVO;
import org.shoppingmall.domain.CartVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.OrderDetailsVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.ReplyVO;

public interface ShopDAO {
	public List<GoodsViewVO> list(int cateCode, int cateCodeRef, int firstCateCode,int displayPost, int end);
	
	public List<GoodsViewVO> list(int cateCode,int displayPost, int end);
	public int count(int cateCode, int cateCodeRef, int firstCateCode);
	public int count(int cateCode);
	
	public GoodsViewVO shopView(int gdsNum);
	
	public void registReply(ReplyVO vo);
	
	public List<ReplyListVO> replyList(int gdsNum);
	
	public void deleteReply(ReplyVO vo);
	public String idCheck(int repNum);
	
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
