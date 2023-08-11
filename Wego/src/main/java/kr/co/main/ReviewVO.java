
package kr.co.main;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;

@Data	
public class ReviewVO {
	int review_pk;
	String nickname;
	String title;
	Date regdate;
	int state;
	
	String filename_save;
	String imagename;
}