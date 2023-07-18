package kr.co.main.myPage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.main.first.UserVO;

@Controller
@RequestMapping("/myPage")
public class MyPageController {
	@Autowired
	MyPageService mService;
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
//	닉네임 변경
	@ResponseBody
	@GetMapping("/updateNickname.do")
	public String updateNickname(@RequestParam String nickName, HttpSession sess) {
		UserVO vo= (UserVO)sess.getAttribute("loginSession");
		vo.setNickName(nickName);
		mService.updateNickname(vo);
		
		return "완료";
	}
//	비밀번호 확인하기 (임시)
	@PostMapping("/checkPwd.do")
	public boolean checkPwd() {
		
		return false;
	}
}
