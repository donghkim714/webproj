package org.shoppingmall.domain;

import lombok.Data;

@Data
public class PagingVO {
	private int pageNum;
	private int num;
	
	private int startPageNum;
	private int endPageNum;
	private boolean prev;
	private boolean next;
	
}
