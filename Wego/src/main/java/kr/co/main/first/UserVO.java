package kr.co.main.first;

import java.sql.Date;

import lombok.Data;

@Data
public class UserVO {
	private int user_pk = 1;
	private String userName;
	private String email;
	private String nickName;
	private Date regdate;
	private int role;
	private int BanPost;
	private String secretKey;
	//移대뱶 �벑濡앹쓣 �쐞�빐�꽌
	private String creditcardnumber;
}
