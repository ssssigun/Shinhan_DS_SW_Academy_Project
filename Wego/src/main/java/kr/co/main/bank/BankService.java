package kr.co.main.bank;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class BankService {

	@Autowired
	BankMapper mapper;
	
	List<BankAccountVO> accountList; 
	
	private ThreadLocal<DateFormat> format = new ThreadLocal<DateFormat> () {
	    @Override 
	    public DateFormat get() { 
	        return super.get(); 
	    } 
	 
	    @Override 
	    protected DateFormat initialValue() { 
	        return new SimpleDateFormat("yyyy-MM-dd"); 
	    } 
	 
	    @Override 
	    public void remove() { 
	        super.remove(); 
	    } 
	 
	    @Override 
	    public void set(DateFormat value) { 
	        super.set(value);
	    }
	};
	
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
		Map<String, Object> outputMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		List<Integer> planPkList = new ArrayList<>();
		for (int i = 0; i < planList.size(); i++) {
			List<BankPlanDetailVO> planDetailList = mapper.selectAccountNeedPlanDetail(planList.get(i).getPlan_pk());
			accountList = new ArrayList<>();
			planPkList.add(planList.get(i).getPlan_pk());
			String cardnum = mapper.selectCardnum(planList.get(i).getPlan_pk());
			
			// 결제 내역 랜덤으로 만들기
			for (int j = 0; j < planDetailList.size(); j++) {
				BankPlanDetailVO planDetailVO = planDetailList.get(j);
				BankAccountVO accountVO = new BankAccountVO();
				accountVO.setCardnum(cardnum);
				// 90% 확률로 계획된 장소에 방문
				boolean chk = false;
				if (Math.random() <= 0.9) {
					chk = true;
					accountVO.setAddress(planDetailVO.getAddress());
					accountVO.setContent(planDetailVO.getLocation_name());
					// 65% 확률로 예산과 일치한 결제
					if (Math.random() <= 0.65) {
						accountVO.setAmount_payment(planDetailVO.getBudget());
					}
					// 예산과 일치하지 않은 결제: 예산에서 -10% ~ 10%
					else {
						accountVO.setAmount_payment((long)(planDetailVO.getBudget() * ((Math.random() * 1.2) + 0.9)));
					}
					
					accountVO.setDate(randomTime(planDetailVO.getStart_time(), planDetailVO.getEnd_time()));
				}
				if (chk) {
					accountList.add(accountVO);
				}
			}
			Map<String, Object> locationInputMap = new HashMap<String, Object>();
			locationInputMap.put("region", planDetailList.get(0).getRegion());
			for (int j = 0; j < 3; j++) {
				// 15% 확률로 계획되지 않은 주변 어딘가
				if (Math.random() <= 0.35) {
					BankAccountVO accountVO = new BankAccountVO();
					// 50% 확률로 갔던 곳 또 방문
					if (Math.random() <= 0.5 && accountList.size() > 0) {
						BankAccountVO clone = accountList.get((int)Math.random() * (accountList.size()));
						accountVO.setAddress(clone.getAddress());
						accountVO.setAmount_payment(clone.getAmount_payment());
						accountVO.setCardnum(clone.getCardnum());
						accountVO.setContent(clone.getContent());
						// 시간만 변경
						accountVO.setDate(addMinute(clone.getDate(), (int)(Math.random() * 60) - 60));
					}
					else {
						accountVO.setCardnum(cardnum);
						locationInputMap.put("num", (int) (Math.random() * 1000) + 1);
						BankLocationVO locationVO = mapper.selectLocation(locationInputMap);
						accountVO.setAddress(locationVO.getAddress());
						accountVO.setContent(locationVO.getLocation_name());
						accountVO.setAmount_payment((int) (Math.random() * 100000) + 1000);
						long diffDays = ((planList.get(i).getEnd_date().getTime() - planList.get(i).getStart_date().getTime()) / (24*60*60*1000)) + 1;
						diffDays *= 24*60;
						int random = (int)(Math.random() * diffDays);
						System.out.println(random);
						accountVO.setDate(addMinute(planList.get(i).getStart_date(), random));
					}
					accountList.add(accountVO);
				}
			}
			
			// 시간 순으로 정렬하기
			Collections.sort(accountList, new Comparator<BankAccountVO>() {

				@Override
				public int compare(BankAccountVO o1, BankAccountVO o2) {
					return o2.getDate().compareTo(o1.getDate());
				}
				
			});
			// map에 key를 plan_pk로 해서 넣기
			map.put(Integer.toString(planList.get(i).getPlan_pk()), accountList);
		}
		
		outputMap.put("planPkList", planPkList);
		outputMap.put("accountMap", map);
		return outputMap;
	}
	
	public Date addMinute(Date date, long minute){
		Date returnDate = null;
		try {
			long returnTime = date.getTime() + minute * 60000;
			returnDate = new Date(returnTime);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return returnDate;
	}
	
	public Date randomTime(Date start_time, Date end_time) {
		long diffMin = ((start_time.getTime() - end_time.getTime())) / 60000;
		int random = (int)(Math.random() * (diffMin - 60));
		return addMinute(start_time, random);
	}
	
	public void insertAccountList(List<BankPlanVO> planList) {
		mapper.insertAccountList(accountList);
		for (int i = 0; i < planList.size(); i++) {
			System.out.println(planList.get(i).getPlan_pk());
			mapper.updateBankPlanChk(planList.get(i).getPlan_pk());
		}
	}
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
