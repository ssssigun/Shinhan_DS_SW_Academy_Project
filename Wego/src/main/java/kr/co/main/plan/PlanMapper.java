package kr.co.main.plan;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlanMapper {
	//로그인 정보 받아오기
	// XML 파일 id이름과 메서드명 똑같이 사용
	List<LocationVO> selectLocationPer5(LocationVO vo);
	List<LocationVO> selectLocationByPK(int location_pk);
	int count(LocationVO vo);
	void insertPlan(PlanVO planVO);
	void insertPlanDetail(PlanDetailVO planDetailVO);
	void deletePlan(int plan_pk);
	void deletePlanDetail(int plan_pk);
	void updatePlan(PlanVO planVO);
	void updateStat(StatisticsVO statisticsVO);
	void subtractStat(StatisticsVO statisticsVO);
	PlanVO selectPlanByPK(int plan_pk);
	List<PlanDetailVO> selectPlanDetailByPK(int plan_pk);
}
	