package kr.co.main.plan;

import java.util.List;
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
	public Map filter(String sword, Integer page, Integer region, Integer category) {
		LocationVO vo = new LocationVO();
		vo.setPage(page);
		vo.setRegion(region);
		vo.setCategory(category);
		vo.setSword(sword);
		Map map =  Service.selectLocationPer5(vo);
		System.out.println(map);
		return map;
	}
	
	@GetMapping("/spotDetail.do")
	@ResponseBody
	public LocationVO spotDetail(Integer location_pk) {
		LocationVO locationVO = Service.selectLocationByPK(location_pk);
		return locationVO;
	}
}
