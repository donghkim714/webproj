package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String userPass;
	private String userName;
	private String userPhon;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private Date regiDate;
	private int verify;
	private String userEmail;
	private int userWarn;
}
