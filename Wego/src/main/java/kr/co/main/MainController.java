package kr.co.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
	@Autowired
	MainService service;
	
	 @GetMapping("/index.do")
	 public String goMain(Model model, int user_pk) {
		 model.addAttribute("reviewList", service.selectFourReview());
		 model.addAttribute("planCount", service.countPlan(user_pk));
		 model.addAttribute("user_pk", user_pk);
		 
		 return "index";
	 }
	 
	 @GetMapping("/selectPlan.do")
	 @ResponseBody
	 public List<PlanVO> selectPlan(int user_pk, int page_num) {
		 return service.selectPlan(user_pk, page_num);
	 }
}
