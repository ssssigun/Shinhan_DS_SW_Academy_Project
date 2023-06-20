package kr.co.main.myRecord.accountBook;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/myRecord/accountBook")
public class AccountBookController {
	@Autowired
	AccountService Service;
	
	@GetMapping("/index.do")
	public String index(@RequestParam(value="user_pk") int user_pk, Model model) {
		// 비교 통계
		model.addAttribute("totalRate", Service.totalRate(user_pk));
		model.addAttribute("totalRateRadar", Service.getTotalRateForRadar(user_pk));
		
		// 리스트
		model.addAttribute("reportList", Service.getReportList(user_pk));
		
		return "myRecord/accountBook/index";
	}
	
	
	// test: jsp만 띄우기
	@GetMapping("/test.do")
	public String test() {
		return "myRecord/accountBook/index";
	}
}
