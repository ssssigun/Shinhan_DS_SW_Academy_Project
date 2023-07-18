package kr.co.main.myPage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.main.first.UserVO;

@Service
public class MyPageService {
	@Autowired
	MyPageMapper mMapper;
	public int updateNickname(UserVO vo) {
		return mMapper.updateNickname(vo);
	}
}
