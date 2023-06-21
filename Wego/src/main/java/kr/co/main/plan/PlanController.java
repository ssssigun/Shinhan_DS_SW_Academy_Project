package kr.co.main.plan;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/plan")
public class PlanController {
	@Autowired
	PlanService Service;
	
	@GetMapping("/index.do")
	public String index() {
		return "plan/index";
	}
	
	@GetMapping("/filter.do")
	@ResponseBody
	public Map filter(LocationVO vo) {
		Map map =  Service.selectLocationPer5(vo);
		return map;
	}
	
	@GetMapping("/spotDetail.do")
	@ResponseBody
	public LocationVO spotDetail(Integer location_pk) {
		LocationVO locationVO = Service.selectLocationByPK(location_pk);
		return locationVO;
	}
}
