package kr.co.main.first;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FirstController {
	@Autowired
	FirstService fService;
	//처음 약관 동의 페이지 이동
	@GetMapping("/firstLogin.do")
	public String firstLogin() {
		return "login/firstLogin";
	}
	//닉네임 중복 확인
	@ResponseBody
	@GetMapping("/check.do")
	public int checkNickName(@RequestParam("nickName")String nickName) {
		return fService.checkNickName(nickName);
	}
	//약관 동의 및 닉네임 유효성 검사 후 닉네임 등록
	@GetMapping("/register.do")
	public String registerName(@RequestParam("nickName")String nickName){
//		fService.register(nickName);
		//임시로 포워딩
		return "main.do";
	}
//	//메인으로 이동(임시로 공용 페이지에 포워딩)
//	 @GetMapping("/main.do")
//	 public String goMain() {
//		 return "common";
//	 }
}
