package kr.co.main.myPage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myPage")
public class MyPageController {
	//비밀번호 입력 폼 
	@GetMapping("/check.do")
	public String check() {
		return "myPage/mypagePwd";
	}
	//비밀 번호가 맞는지 확인
	
	//내 정보 확인 폼
	@GetMapping("/myInfo.do")
	public String info() {
		return "myPage/mypageInfo";
	}
	//닉네임 변경시 중복확인
	/*
		firstController에 /check.do (checkNickName 함수)로 처리
		처리 하는 작업이 같으므로 똑같이 처리
	*/
	
	//닉네임 변경
}
