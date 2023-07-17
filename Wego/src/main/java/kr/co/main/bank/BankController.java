package kr.co.main.bank;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/bank")
public class BankController {
	@Autowired
	BankService Service;
	
	List<BankPlanVO> planList;
	
	// test: jsp만 띄우기
	@GetMapping("/index.do")
	public String test() {
		return "bank/index";
	}
	
	@GetMapping("/updatePlanState.do")
	@ResponseBody
	public Map<String, Object> updatePlanState() {
		Map<String, Object> map = new HashMap<>();
		map.put("insertBankPlanChk", Service.insertBankPlanChk());
		
		return map;
	}
	
	@GetMapping("/selectEndPlan.do")
	@ResponseBody
	public List<BankPlanVO> selectEndPlan() {
		planList = Service.selectEndPlan();
		return planList;
	}
	
	@GetMapping("/randomAccount.do")
	@ResponseBody
	public Map<String, Object> randomAccount() {
		Map<String, Object> outputMap = Service.randomAccount(planList);
		return outputMap;
	}
	
	@GetMapping("/insertAccountList.do")
	@ResponseBody
	public boolean insertAccountList() {
		Service.insertAccountList();
		return true;
	}
	
	@GetMapping("/getAccountList.do")
	public String getAccountList() {
		return "bank/getAccountList";
	}
	
	@GetMapping("/selectPlanForInsert.do")
	@ResponseBody
	public List<BankPlanVO> selectPlanForInsert() {
		List<BankPlanVO> list = Service.selectPlanForInsert();
		System.out.println(list);
		return list;
	}
	
	@GetMapping("/selectAccountListForInsert.do")
	@ResponseBody
	public Map<String, Object> selectAccountListForInsert() {
		Service.selectAccountListForInsert();
		return Service.selectPlanDetailForInsert();
	}
	
	@GetMapping("/insertUsage.do")
	@ResponseBody
	public void insertUsage() {
		Service.insertUsage();
	}
}
