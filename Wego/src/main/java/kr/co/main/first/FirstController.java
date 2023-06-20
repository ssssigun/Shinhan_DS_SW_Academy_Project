package kr.co.main.first;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FirstController {
	@Autowired
	FirstService fService;
	@GetMapping("/firstLogin.do")
	public String firstLogin() {
		return "login/firstLogin";
	}
	@ResponseBody
	@GetMapping(value="/check.do", produces="application/text;charset=utf8")
	public String checkNick(@RequestParam(value = "nickName", defaultValue = "")String nickName, Model model) {
		return fService.checkNick(nickName);
	}
}
