package org.shoppingmall.domain;

import lombok.Data;

@Data
public class UserViewVO {
	private int totalAmount;
	private int totalStock;
	private int userWarn;
	private String userId;
}
