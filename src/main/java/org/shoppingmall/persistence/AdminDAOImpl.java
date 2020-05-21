package org.shoppingmall.persistence;

import java.util.HashMap;
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
import org.shoppingmall.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class AdminDAOImpl implements AdminDAO {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminMapper mapper;

	@Override
	public List<CategoryVO> category() {
		// TODO Auto-generated method stub
		
		return mapper.category();
	}

	@Override
	public void register(GoodsVO vo) {
		// TODO Auto-generated method stub
		log.info("GoodsVO : " + vo);
		mapper.register(vo);
		}

	@Override
	public List<GoodsViewVO> goodsList(int displayPost, int end) {
		// TODO Auto-generated method stub
		Map<String,  Integer> map = new HashMap<String, Integer>();
		map.put("displayPost", displayPost);
		map.put("end", end);
		
		return mapper.goodsList(map);
	}
	
	@Override
	public int count() {
		// TODO Auto-generated method stub
		return mapper.count();
	}

	@Override
	public GoodsViewVO goodsView(int gdsNum) {
		// TODO Auto-generated method stub
		return mapper.goodsView(gdsNum);
	}

	@Override
	public void goodsUpdate(GoodsVO vo) {
		// TODO Auto-generated method stub
		 mapper.goodsUpdate(vo);
	}

	@Override
	public int goodsDelete(int gdsNum) {
		// TODO Auto-generated method stub
		return mapper.goodsDelete(gdsNum);
	}

	@Override
	public List<OrderVO> orderList(int displayPost, int end) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("displayPost", displayPost);
		map.put("end", end);
		
		return mapper.orderList(map);
	}
	@Override
	public int orderCount() {
		// TODO Auto-generated method stub
		return mapper.orderCount();
	}

	@Override
	public List<OrderListVO> orderView(OrderVO vo) {
		// TODO Auto-generated method stub
		return mapper.orderView(vo);
	}

	@Override
	public void delivery(OrderVO vo) {
		// TODO Auto-generated method stub
		mapper.delivery(vo);
	}

	@Override
	public void changeStock(GoodsVO vo) {
		// TODO Auto-generated method stub
		mapper.changeStock(vo);
	}

	@Override
	public List<ReplyListVO> allReply(int displayPost, int end) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("displayPost", displayPost);
		map.put("end", end);
		
		return mapper.allReply(map);
	}
	@Override
	public int replyCount() {
		// TODO Auto-generated method stub
		return mapper.replyCount();
	}

	@Override
	public void deleteReply(int repNum) {
		// TODO Auto-generated method stub
		mapper.deleteReply(repNum);
	}

	@Override
	public List<MemberVO> userList(int displayPost, int end) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("displayPost",displayPost );
		map.put("end",end );
		return mapper.userList(map);
	}

	@Override
	public int userCount() {
		// TODO Auto-generated method stub
		return mapper.userCount();
	}

	@Override
	public UserViewVO userView(String userId) {
		// TODO Auto-generated method stub
		return mapper.userView(userId);
	}

	@Override
	public int deleteUser(String userId) {
		// TODO Auto-generated method stub
		return mapper.deleteUser(userId);
	}

	@Override
	public void userModi(int userWarn, String userId) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userWarn", userWarn);
		map.put("userId", userId);
		mapper.userModi(map);
	}

	@Override
	public TotalVO adminFirst() {
		// TODO Auto-generated method stub
		return mapper.adminFirst();
	}

	@Override
	public List<TotalVO> cateTotal() {
		// TODO Auto-generated method stub
		return mapper.cateTotal();
	}


}
