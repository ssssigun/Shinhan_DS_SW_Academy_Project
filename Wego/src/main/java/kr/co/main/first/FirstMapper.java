package kr.co.main.first;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper
public interface FirstMapper {
	int checkNickName(String nickName);
	UserVO findUser(String id);
	int insertUser(UserVO vo);
	int insertStatistics(UserVO vo);
	int insertInfo(UserVO vo);
}
