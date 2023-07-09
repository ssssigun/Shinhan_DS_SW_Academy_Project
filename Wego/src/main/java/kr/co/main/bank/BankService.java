package kr.co.main.bank;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class BankService {

	@Autowired
	BankMapper mapper;
	
	public int updatePlanState() {
		return mapper.updatePlanState();
	}
	
	public int insertBankPlanChk() {
		return mapper.insertBankPlanChk();
	}
	
	public List<BankPlanVO> selectEndPlan() {
		return mapper.selectEndPlan();
	}
	
	public Map<String, Object> randomAccount(List<BankPlanVO> planList) {
		Map<String, Object> map = new HashMap<>();
		
		for (int i = 0; i < planList.size(); i++) {
			List<BankPlanDetailVO> planDetailList = mapper.selectAccountNeedPlanDetail(planList.get(i).getPlan_pk());
			List<BankAccountVO> accountList = new ArrayList<>();
			for (int j = 0; j < planDetailList.size(); j++) {
				BankPlanDetailVO planDetailVO = planDetailList.get(i);
				BankAccountVO accountVO = new BankAccountVO();
				// 90% 확률로 계획된 장소에 방문
				if (Math.random() <= 0.9) {
					accountVO.setAddress(planDetailVO.getAddress());
					// 65% 확률로 예산과 일치한 결제
					if (Math.random() <= 0.65) {
						accountVO.setAmount_payment(planDetailVO.getBudget());
					}
					// 예산과 일치하지 않은 결제: 예산에서 -10% ~ 10%
					else {
						accountVO.setAmount_payment((long)(planDetailVO.getBudget() * ((Math.random() * 1.2) - 0.1)));
					}
				}
				// 계획하지 않은 장소에 방문
				else {
					
				}
			}
		}
		
		return map;
	}
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
