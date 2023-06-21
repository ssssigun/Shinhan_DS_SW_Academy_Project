package kr.co.main.myRecord.plan;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.main.myRecord.plan.MyRecordPlanVO;

@Service
public class MyRecordPlanService {
	@Autowired
	MyRecordPlanMapper mapper;
	
	public List<MyRecordPlanVO> willdo(){
		List<MyRecordPlanVO> result = mapper.willdo();
		return result;
	}
	
	
}