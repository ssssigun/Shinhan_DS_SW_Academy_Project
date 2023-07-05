package kr.co.main.myRecord.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/myRecord/plan")
public class MyRecordPlanController {
	
	@Autowired
	MyRecordPlanService service;
	
	@GetMapping("/index.do")
	public String index(MyRecordPlanVO vo, Model model) {
		model.addAttribute("result",service.index(vo));
		model.addAttribute("flag","1");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("/reviewing.do")
	public String reviewing(MyRecordPlanVO vo, Model model) {
		model.addAttribute("result",service.reviewing(vo));
		model.addAttribute("flag","2");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("/tempSaved.do")
	public String tempSaved(MyRecordPlanVO vo, Model model) {
		model.addAttribute("result",service.tempSaved(vo));
		model.addAttribute("flag","3");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("writingReviews.do")
	public String writingReviews(MyRecordPlanVO vo, Model model, @RequestParam("plan_pk")String plan_pk) {
		int x = Integer.parseInt(plan_pk);
		model.addAttribute("result",service.chopAndReading(x));
		return "/myRecord/plan/review_comment_write";
	}
	
	@GetMapping("reviewUpdating.do")
	public String reviewUpdating(MyRecordPlanVO vo, Model model) {
		return "/myRecord/plan/review_update";
	}
	
	@GetMapping("deleting.do")
	public String deleting(@RequestParam("plan_pk")String plan_pk, @RequestParam("flag")String flag, MyRecordPlanVO vo, Model model) {
		int x = Integer.parseInt(plan_pk);
		model.addAttribute("result",service.deleting(x,vo));
		if(flag.equals("1"))
			return "redirect:/myRecord/plan/index.do";
		else
			return "redirect:/myRecord/plan/tempSaved.do";
	}
	
}