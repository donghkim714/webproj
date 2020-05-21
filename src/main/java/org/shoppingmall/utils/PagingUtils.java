package org.shoppingmall.utils;

import org.shoppingmall.domain.PagingVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class PagingUtils {
	public int displayPost;
	public int end;
	public PagingVO vo;

	public PagingUtils(int num, int count, PagingVO paging, int postNum) {
		// 들어가는 게시물 개수

		// 표시되는 마지막 번호
		int pageNum = (int) Math.ceil((double) count / postNum);
		displayPost = 0;
		log.info("pageNum : " + pageNum);

		// 표시되는 페이지 번호 첫번째
		displayPost = (num - 1) * postNum;
		end = num * postNum;

		// 한번에 표시할 페이징 번호의 갯수

		int pageNum_cnt = 10;
		// 표시되는 페이지 번호 중 마지막 번호

		int endPageNum = (int) (Math.ceil((double) num / (double) pageNum_cnt) * pageNum_cnt);
		// 표시되는 페이지 번호 중 첫번째 번호

		int startPageNum = endPageNum - (pageNum_cnt - 1);
		// 마지막 번호 재계산
		int endPageNum_tmp = 0;
		
			if (count <= postNum) {
				endPageNum_tmp =  (int) (Math.ceil((double) count / (double) pageNum_cnt));
				System.out.println("endPageNum_tmp 1: " + endPageNum_tmp);
			}
			else {
				endPageNum_tmp = (int) (Math.ceil((double) count / (double) pageNum_cnt)+1);
				System.out.println("endPageNum_tmp 2: " + endPageNum_tmp);
			}

			if (endPageNum > endPageNum_tmp) {
				endPageNum = endPageNum_tmp;
			}
			boolean prev = startPageNum == 1 ? false : true;
			boolean next = endPageNum * pageNum_cnt >= count ? false : true;
			System.out.println("endPageNum : " + endPageNum);
			paging.setNum(num);
			paging.setPageNum(pageNum);
			paging.setEndPageNum(endPageNum);
			paging.setStartPageNum(startPageNum);
			paging.setPrev(prev);
			paging.setNext(next);
			this.vo = paging;
		}
	}
