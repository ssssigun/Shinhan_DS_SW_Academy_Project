package kr.co.main.myRecord.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
}