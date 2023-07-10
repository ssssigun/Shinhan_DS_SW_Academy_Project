package kr.co.main.myRecord.plan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
		model.addAttribute("plan_pk",plan_pk);
		return "/myRecord/plan/review_comment_write";
	}
	
	@GetMapping("reviewUpdating.do")
	public String reviewUpdating(MyRecordPlanVO vo, Model model, @RequestParam("plan_pk")String plan_pk) {
		model.addAttribute("plan_pk",plan_pk);
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
	
	@PostMapping("reviewing1.do")
	public String savingReviews(HttpServletRequest request ,MyRecordPlanVO vo, HttpSession sess) {
		String[] scores = request.getParameterValues("scores");
		String[] reviews = request.getParameterValues("oneLineReviews");
		String[] idx = request.getParameterValues("pks");
		String[] plan_pk = request.getParameterValues("plan_pk");
		int ppk = Integer.parseInt(plan_pk[0]);
		service.setReviewed(ppk);
		for(int i = 0; i<idx.length; i++) {
			vo.setLocation_content(reviews[i]);
			vo.setLocation_pk(Integer.parseInt(idx[i]));
			vo.setStar(Integer.parseInt(scores[i]));
			service.reviewing1(vo);
		}
		return "redirect:/myRecord/plan/reviewing.do";
	}
	
	@PostMapping("reviewing2.do")
	public String savingReiews2(HttpServletRequest request, MyRecordPlanVO vo, HttpSession sess) {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String ppk = request.getParameter("plan_pk");
		int plan_pk = Integer.parseInt(ppk);
		vo.setPlan_pk(plan_pk);
		vo.setTitle(title);
		vo.setContent(contents);
		vo.setState(0);
		service.savingReviews(vo);
		return "redirect:/myRecord/plan/reviewing.do";
	}
}