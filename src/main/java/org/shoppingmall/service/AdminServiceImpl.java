package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.CategoryVO;
import org.shoppingmall.domain.GoodsVO;
import org.shoppingmall.domain.GoodsViewVO;
import org.shoppingmall.domain.MemberVO;
import org.shoppingmall.domain.OrderListVO;
import org.shoppingmall.domain.OrderVO;
import org.shoppingmall.domain.ReplyListVO;
import org.shoppingmall.domain.TotalVO;
import org.shoppingmall.domain.UserViewVO;
import org.shoppingmall.persistence.AdminDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = {@Autowired})
	private AdminDAO dao;
	
	@Override
	public List<CategoryVO> category() {
		// TODO Auto-generated method stub
		return dao.category();
	}

	@Override
	public void register(GoodsVO vo) {
		// TODO Auto-generated method stub
		dao.register(vo);
	}

	@Override
	public List<GoodsViewVO> goodsList(int displayPost, int end) {
		// TODO Auto-generated method stub
		return dao.goodsList(displayPost, end);
	}
	@Override
	public int count() {
		// TODO Auto-generated method stub
		return dao.count();
	}

	@Override
	public GoodsViewVO goodsView(int gdsNum) {
		// TODO Auto-generated method stub
		return dao.goodsView(gdsNum);
	}

	@Override
	public void goodsUpdate(GoodsVO vo) {
		// TODO Auto-generated method stub
		dao.goodsUpdate(vo);
	}

	@Override
	public int goodsDelete(int gdsNum) {
		// TODO Auto-generated method stub
		return dao.goodsDelete(gdsNum);
	}

	@Override
	public List<OrderVO> orderList(int displayPost, int end) {
		// TODO Auto-generated method stub
		return dao.orderList(displayPost,end);
	}
	@Override
	public int orderCount() {
		// TODO Auto-generated method stub
		return dao.orderCount();
	}

	@Override
	public List<OrderListVO> orderView(OrderVO vo) {
		// TODO Auto-generated method stub
		return dao.orderView(vo);
	}

	@Override
	public void delivery(OrderVO vo) {
		// TODO Auto-generated method stub
		dao.delivery(vo);
	}

	@Override
	public void changeStock(GoodsVO vo) {
		// TODO Auto-generated method stub
		dao.changeStock(vo);
	}

	@Override
	public List<ReplyListVO> allReply(int displayPost, int end) {
		// TODO Auto-generated method stub
		return dao.allReply(displayPost,end);
	}
	@Override
	public int replyCount() {
		// TODO Auto-generated method stub
		return dao.replyCount();
	}
	@Override
	public void deleteReply(int repNum) {
		// TODO Auto-generated method stub
		dao.deleteReply(repNum);
	}

	@Override
	public List<MemberVO> userList(int displayPost, int end) {
		// TODO Auto-generated method stub
		return dao.userList(displayPost, end);
	}

	@Override
	public int userCount() {
		// TODO Auto-generated method stub
		return dao.userCount();
	}

	@Override
	public UserViewVO userView(String userId) {
		// TODO Auto-generated method stub
		return dao.userView(userId);
	}

	@Override
	public int deleteUser(String userId) {
		// TODO Auto-generated method stub
		return dao.deleteUser(userId);
	}

	@Override
	public void userModi(int userWarn, String userId) {
		// TODO Auto-generated method stub
		dao.userModi(userWarn,userId);
	}

	@Override
	public TotalVO adminFirst() {
		// TODO Auto-generated method stub
		return dao.adminFirst();
	}

	@Override
	public List<TotalVO> cateTotal() {
		// TODO Auto-generated method stub
		return dao.cateTotal();
	}
	
}
