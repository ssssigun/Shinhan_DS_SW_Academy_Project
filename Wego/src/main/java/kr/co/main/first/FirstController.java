package kr.co.main.first;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.main.first.jwt.JWTUtil;

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
	//약관 동의 및 닉네임 유효성 검사 후 사용자 정보 등록
	@ResponseBody
	@PostMapping("/register.do")
	public String registerName(UserVO vo, HttpSession sess){
		fService.insertUser(vo);
		UserVO user =fService.findUser(vo.getSecretKey());
		user.setCreditcardnumber(vo.getCreditcardnumber());
		fService.insertInfo(user);
		return "index";
	}
	// 통합 로그인 폼 이동
	@GetMapping("/login.do")
	public String Login() {
		return "login/userLogin";
	}
//	토큰 값 파싱 후  pk 가져오기
	@ResponseBody
	@PostMapping("/tokenCheck.do")
	public String tokenCheck(@RequestParam("accessToken")String accessToken, HttpSession sess, Model model) {
		JWTUtil jwt= new JWTUtil();
		String id = jwt.validateToken(accessToken);
		UserVO user = fService.findUser(id);
				
		if(user==null) {
			model.addAttribute("id", id);
			return "firstLogin";
		}else {
			sess.setAttribute("loginSession", user);
			return "index";
		}
	}
//	로그 아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "login/userLogin";
	}
	
	
}
