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
	
	public int register(String nickName) {
		return fMapper.register(nickName);
	}
}
