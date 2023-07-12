package kr.co.main.bank;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface BankMapper {
	
	int updatePlanState();
	int insertBankPlanChk();
	List<BankPlanVO> selectEndPlan();
	List<BankPlanDetailVO> selectAccountNeedPlanDetail(int plan_pk);
	String selectCardnum(int plan_pk);
	BankLocationVO selectLocation(Map<String, Object> map);
	void insertAccountList(List<BankAccountVO> accountList);
	void updateBankPlanChk(int plan_pk);
	
	List<BankPlanVO> selectPlanForInsert();
	List<BankAccountVO> selectAccountListForInsert(Map<String, Object> map);
	BankPlanDetailVO selectPlanDetailForInsert(Map<String, Object> map);
	Map<String, Object> selectLocationPk(int account_pk);
	void insertUsage(List<BankAccountVO> accountList);
	void updatePlanStateForInsert(int plan_pk);
	void updateStatistics(Map<String, Object> map);
	
	//=======================
	// review
	//=======================
	
//	int insert(DefaultVO vo); //
//	int update(DefaultVO vo); //업데이트
//	int delete(DefaultVO vo); //삭제
//	int count(DefaultVO vo);
//	List<DefaultVO> list(DefaultVO vo);
//	DefaultVO view(DefaultVO vo);
//	int viewCount(int no); //조회수
}
	