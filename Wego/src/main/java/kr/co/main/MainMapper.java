package kr.co.main;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {
	List<ReviewVO> selectFourReview();
	List<PlanVO> selectPlan(Map<String, Object> map);
	int countPlan(int user_pk);
}
