package kr.co.main.myRecord.accountBook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AccountService {

	@Autowired
	AccountMapper mapper;
	
	//함수 만들어서 사용
	public TotalRateVO totalRate(int user_pk){
		TotalRateVO m = mapper.totalRate(user_pk);
		System.out.println("service" + m.toString());
		return m;
	}
	
	public TotalRateVO getTotalRateForRadar(int user_pk) {
		TotalRateVO m = mapper.getTotalRateForRadar(user_pk);
		System.out.println("service" + m.toString());
		return m;
	}
	
	public Map<String, Object> getReportList(ReportVO vo){
		Map<String, Object> map = new HashMap<>();
		List<ReportVO> list = mapper.getReportList(vo);
		System.out.println("report_num: " + list.size());
		
		map.put("list", list);
		
		int count = mapper.getCountReportList(vo.user_pk);
		map.put("totalPage", count / 4);
		return map;
	}
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
