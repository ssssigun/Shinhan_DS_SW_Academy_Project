package kr.co.main.first;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FirstService {
	@Autowired
	FirstMapper fMapper;
	public int checkNickName(String nickName) {
		return fMapper.checkNickName(nickName);
	}
	public UserVO findUser(String id) {
		return fMapper.findUser(id);
	}
	public int insertUser(UserVO vo) {
		return fMapper.insertUser(vo);
	}
	public int insertInfo(UserVO vo) {
		return fMapper.insertInfo(vo);
	}
	
}
