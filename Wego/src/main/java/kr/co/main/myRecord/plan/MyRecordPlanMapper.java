package kr.co.main.myRecord.plan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyRecordPlanMapper {
	List<MyRecordPlanVO> list(MyRecordPlanVO vo);
	int count(int user_pk);
	
	List<MyRecordPlanVO> list2(MyRecordPlanVO vo);
	List<MyRecordPlanVO> dragingImage(int oh);
	int count2(int user_pk);
	
	List<MyRecordPlanVO> list3(MyRecordPlanVO vo);
	int  count3(int user_pk);
	
	void deletion(int x);
	
	
	List<MyRecordPlanVO> list4(int x);
	
	int reviewing1(MyRecordPlanVO vo);
	
	void setReviewed(int ppk);
	
	void savingReviews(MyRecordPlanVO vo);
	
	void savingReview_image(MyRecordPlanVO vo);
	
	List<MyRecordPlanVO> viewingOLR(int x);
	
	MyRecordPlanVO viewingTR(int x);
	
	void setReviewed2(int ppk);
	
	List<MyRecordPlanVO> savedImages(int x);
}