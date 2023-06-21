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
	
	@GetMapping("/plan.do")
	public String plan() {
		return "myRecord/plan";
	}
	
	@GetMapping("/willdo.do")
	public String willdo(Model model) {
		MyRecordPlanVO vo = new MyRecordPlanVO();
		List<MyRecordPlanVO> list = service.willdo();
		model.addAttribute("list",list);
		return "myRecord/plan";
	}
	
	
	
	
}