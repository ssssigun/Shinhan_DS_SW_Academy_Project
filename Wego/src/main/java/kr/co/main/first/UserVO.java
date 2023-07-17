package kr.co.main.first;

import java.sql.Date;

import lombok.Data;

@Data
public class UserVO {
	private int user_pk;
	private String userName;
	private String email;
	private String nickName;
	private Date regdate;
	private int role;
	private int BanPost;
	private String secretKey;
}
