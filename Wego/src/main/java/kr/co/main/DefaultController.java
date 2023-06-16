package kr.co.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DefaultController {
	@Autowired
	DefaultService Service;
	@GetMapping("/index.do")
	public String index(Model model) {
		List<DefaultVO> vo =  Service.test();
		System.out.println("controller" + vo.toString());
		model.addAttribute("vo", vo);
		return "index";
	}
}
