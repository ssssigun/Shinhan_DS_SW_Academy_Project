package kr.co.main;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.main.first.UserVO;

@Controller
public class MainController {
	@Autowired
	MainService service;
	
	 @GetMapping("/index.do")
	 public String goMain(Model model, HttpSession sess) {
		 UserVO user = (UserVO)sess.getAttribute("loginSession");
		 
		 model.addAttribute("reviewList", service.selectFourReview());
		 model.addAttribute("planCount", service.countPlan(user.getUser_pk()));
		 model.addAttribute("user_pk", user.getUser_pk());
		 
		 return "index";
	 }
	 
	 @GetMapping("/selectPlan.do")
	 @ResponseBody
	 public List<PlanVO> selectPlan(int user_pk, int page_num) {
		 return service.selectPlan(user_pk, page_num);
	 }
}
