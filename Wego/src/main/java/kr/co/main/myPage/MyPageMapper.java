package kr.co.main.myPage;

import org.apache.ibatis.annotations.Mapper;

import kr.co.main.first.UserVO;

@Mapper
public interface MyPageMapper {
	int updateNickname(UserVO vo);
}
