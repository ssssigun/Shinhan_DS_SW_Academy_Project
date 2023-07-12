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
	int  count3();
	
	void deletion(int x);
	
	
	List<MyRecordPlanVO> list4(int x);
	
	int reviewing1(MyRecordPlanVO vo);
	
	void setReviewed(int ppk);
	
	void savingReviews(MyRecordPlanVO vo);
	
	void savingReview_image(MyRecordPlanVO vo);
	
	List<MyRecordPlanVO> viewingOLR(int x);
	
	MyRecordPlanVO viewingTR(int x);
	
	void setReviewed2(int ppk);
}