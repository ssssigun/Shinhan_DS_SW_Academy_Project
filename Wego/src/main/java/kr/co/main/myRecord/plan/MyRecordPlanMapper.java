package kr.co.main.myRecord.plan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyRecordPlanMapper {
	List<MyRecordPlanVO> list(MyRecordPlanVO vo);
	int count();
	
	List<MyRecordPlanVO> list2(MyRecordPlanVO vo);
	int count2();
	
	List<MyRecordPlanVO> list3(MyRecordPlanVO vo);
	int count3();
}