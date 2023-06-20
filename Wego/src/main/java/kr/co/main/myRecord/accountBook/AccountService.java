package kr.co.main.myRecord.accountBook;

import java.util.List;

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
	
	public List<ReportVO> getReportList(int user_pk){
		List<ReportVO> list = mapper.getReportList(user_pk);
		System.out.println("report_num: " + list.size());
		return list;
	}
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
