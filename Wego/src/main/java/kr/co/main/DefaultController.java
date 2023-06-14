package kr.co.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DefaultController {
	@Autowired
	DefaultService oService;
	@GetMapping("/login.do")
	public String login() {
		return "";
	}
}
