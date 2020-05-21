package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class TotalVO {
	private int totalPrice;
	private int totalStock;
	
	private String cateName;
	private int cateTotalAmount;
	private int cateTotalStock;
	
	private String today;
}
