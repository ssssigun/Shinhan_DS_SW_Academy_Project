package kr.co.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MainService {
	
	@Autowired
	MainMapper mapper;
	
	public List<ReviewVO> selectFourReview() {
		return mapper.selectFourReview();
	}
	
	public List<PlanVO> selectPlan(int user_pk, int page_num) {
		Map<String, Object> inputMap = new HashMap<>();
		inputMap.put("user_pk", user_pk);
		inputMap.put("page_num", page_num);
		
		return mapper.selectPlan(inputMap);
	}
	
	public int countPlan(int user_pk) {
		return mapper.countPlan(user_pk);
	}
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
