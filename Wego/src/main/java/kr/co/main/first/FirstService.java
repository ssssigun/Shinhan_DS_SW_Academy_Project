package kr.co.main.first;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FirstService {
	@Autowired
	FirstMapper fMapper;
	public String checkNickName(String nickName) {
		int num = fMapper.checkNickName(nickName);
		System.out.println(num);
		if(num>0) {
			return "존재하는 닉네임입니다.";
		}
		return "사용 가능한 닉네임입니다!";
	}
}
