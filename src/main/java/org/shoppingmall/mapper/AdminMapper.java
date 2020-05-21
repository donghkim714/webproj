package org.shoppingmall.mapper;

import java.util.List;
import java.util.Map;

import org.shoppingmall.domain.CategoryVO;
import org.shoppingmall.domain.GoodsVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.TotalVO;
import org.shoppingmall.domain.UserViewVO;

public interface AdminMapper {
	public List<CategoryVO> category();
	public void register(GoodsVO vo);
						//#에 들어갈 것들
	public List<GoodsViewVO> goodsList(Map<String,Integer> map);
	public int count();
	public int replyCount();
	public int orderCount();
	public GoodsViewVO goodsView(int gdsNum);
	public void goodsUpdate(GoodsVO vo);
	public int goodsDelete(int gdsNum);
	public List<OrderVO> orderList(Map<String, Integer> map);
	public List<OrderListVO> orderView(OrderVO vo);
	public void delivery(OrderVO vo);
	public void changeStock(GoodsVO vo);
	public List<ReplyListVO> allReply(Map<String, Integer> map);
	public void deleteReply(int repNum);
	public List<MemberVO> userList(Map<String, Integer> map);
	public int userCount();
	
	public UserViewVO userView(String userId);
	public int deleteUser(String userId);
	public void userModi(Map<String, Object> map);
	
	public TotalVO adminFirst();
	public List<TotalVO> cateTotal();
}
