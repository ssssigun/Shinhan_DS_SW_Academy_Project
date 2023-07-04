package kr.co.main.plan;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/plan")
public class PlanController {
	@Autowired
	PlanService Service;
	
	// 기본 페이지 반환
	@GetMapping("/index.do")
	public String index() {
		return "plan/index";
	}
	
	// ajax를 위해서 지역, 카테고리, 검색어, 지도 중심 위치를 받아와서 장소 정보를 json으로 반환하는 api 
	@GetMapping("/filter.do")
	@ResponseBody
	public Map filter(LocationVO vo) {
		Map map =  Service.selectLocationPer5(vo);
		return map;
	}
	
	// location_pk를 사용해서 해당 장소의 세부 사항을 json으로 반환하는 api
	@GetMapping("/spotDetail.do")
	@ResponseBody
	public List<LocationVO> spotDetail(Integer location_pk) {
		List<LocationVO> locationVO = Service.selectLocationByPK(location_pk);
		return locationVO;
	}
	
	// 일자별 담아 놓은 장소의 정보(예산 포함)를 사용하여 예산의 총합 구하고, 포인트 누적 계산해서 json으로 반환하는 api
	// 로그인 기능 완성되고, 카드 테이블 생기면 해당 회원이 갖고 있는 카드 조회해서 포인트 계산(미정)
	@PostMapping("/calculate.do")
	@ResponseBody
	public void calculate(DetailsDTO details) {
		System.out.println(details);
	}
}
