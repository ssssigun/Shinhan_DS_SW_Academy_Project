package kr.co.main.bank;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface BankMapper {
	
	int updatePlanState();
	int insertBankPlanChk();
	List<BankPlanVO> selectEndPlan();
	List<BankPlanDetailVO> selectAccountNeedPlanDetail(int plan_pk);
	
	
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
	