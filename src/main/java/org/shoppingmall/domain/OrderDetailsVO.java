package org.shoppingmall.domain;

import lombok.Data;

@Data
public class OrderDetailsVO {
	private int orderDetailsNum;
	private String gdsNum;
	private int cartStock;
	private String orderId;
}
