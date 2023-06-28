package kr.co.main.myRecord.accountBook;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/myRecord/accountBook")
public class AccountBookController {
	@Autowired
	AccountService Service;
	
	/*
	 * 페이지에 전체 통계들 띄우기
	 */
	@GetMapping("/index.do")
	public String index(int user_pk, Model model) {
		// 비교 통계
		model.addAttribute("totalRate", Service.totalRate(user_pk));
		model.addAttribute("totalRateRadar", Service.getTotalRateForRadar(user_pk));
		
		return "myRecord/accountBook/index";
	}
	
	/*
	 * 하단 리스트 불러오기
	 */
	@RequestMapping("/getReportList.do")
	@ResponseBody
	public Map<String, Object> reportList(int user_pk, int start_page) {
		ReportVO vo = new ReportVO();
		vo.setUser_pk(user_pk);
		vo.setStart_page(start_page);
		
		Map<String, Object> map = Service.getReportList(vo);
		
		return map;
	}
	
	/*
	 * 모달 전체 페이지 수 불러오기
	 */
	@RequestMapping("/getTotalNth.do")
	@ResponseBody
	public int totalNth(String start_date, String end_date) throws ParseException {
		return Service.totalDate(start_date, end_date);
	}
	
	/*
	 * 사용 내역 불러오기
	 */
	@RequestMapping("/getUsageForUsageList.do")
	@ResponseBody
	public Map<String, Object> usageList(int plan_pk, String start_date, String end_date, int nth) throws ParseException {
		return Service.getUsageForUsageList(plan_pk, start_date, end_date, nth);
	}
	
	/*
	 * 비교 불러오기
	 */
	@RequestMapping("/getCompareForUsageList.do")
	@ResponseBody
	public Map<String, Object> compareList(int plan_pk, String start_date, String end_date, int nth) {
		return Service.getCompareForUsageListForDay(plan_pk, start_date, end_date, nth);
	}
	
	/*
	 * 통계 불러오기
	 */
	@RequestMapping("/getGraphForUsageList.do")
	@ResponseBody
	public Map<String, Object> graphList(int plan_pk, String start_date, String end_date, int nth) {
		return Service.getGraphForUsageListForDay(plan_pk, start_date, end_date, nth);
	}
	
	// test: jsp만 띄우기
	@GetMapping("/test.do")
	public String test() {
		return "myRecord/accountBook/index";
	}
}
