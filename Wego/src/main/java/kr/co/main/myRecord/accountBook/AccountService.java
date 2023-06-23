package kr.co.main.myRecord.accountBook;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AccountService {

	@Autowired
	AccountMapper mapper;
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	
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
	
	public Map<String, Object> getUsageForUsageList(int plan_pk, String start_date, String end_date, int nth) throws ParseException{
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("plan_pk", plan_pk);
		inputMap.put("date", addDate(start_date, nth));
		List<AccountBookVO> list = mapper.getUsageForUsageList(inputMap);
		System.out.println("list: " + list.toString());
		
		Map<String, Object> outputMap = new HashMap<String, Object>();
		outputMap.put("list", list);
		outputMap.put("totalDate", totalDate(start_date, end_date) + 1);
		
		for (AccountBookVO vo : list) {
			addCategoryName(vo);
		}
		return outputMap;
	}
	
	public void addCategoryName(AccountBookVO vo) {
		switch (vo.getCategory()) {
			case 1: vo.setCategoryName("음식점");
					break;
			case 2: vo.setCategoryName("숙박");
					break;
			case 3: vo.setCategoryName("쇼핑");
					break;
			case 4: vo.setCategoryName("문화활동");
					break;
			case 5: vo.setCategoryName("관광지");
					break;
			case 6: vo.setCategoryName("레포츠");
					break;
			default: vo.setCategoryName("미정");
					break;
		}
	}
	
	public int totalDate(String start_date, String end_date) throws ParseException {
		Date sd = format.parse(start_date);
		Date ed = format.parse(end_date);
		return (int)((ed.getTime() - sd.getTime()) / (24 * 60 * 60 * 1000));
	}
	
	public String addDate(String start_date, int nth) throws ParseException {
		Date sd = format.parse(start_date);
		long returnTime = sd.getTime() + nth * (24 * 60 * 60 * 1000);
		Date returnDate = new Date(returnTime);
		return format.format(returnDate);
	}
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
