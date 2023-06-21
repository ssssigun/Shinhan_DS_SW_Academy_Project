package kr.co.main.myRecord.plan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyRecordPlanMapper {
	List<MyRecordPlanVO> willdo();
	int countWilldo(MyRecordPlanVO vo);
	int countAllDone(MyRecordPlanVO vo);
	int countTempSaved(MyRecordPlanVO vo);
}