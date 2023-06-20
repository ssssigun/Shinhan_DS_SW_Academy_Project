package kr.co.main.first;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FirstController {
	@Autowired
	FirstService fService;
	@GetMapping("/firstLogin.do")
	public String firstLogin() {
		return "login/firstLogin";
	}
	@GetMapping("/check.do")
	public String nickNameCheck(@RequestParam("nickName") String nickName, Model model) {
		model.addAttribute("msg", fService.checkNickName(nickName));
		return "index";
	}
}
