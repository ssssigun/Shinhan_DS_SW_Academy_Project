
package kr.co.main.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.main.myRecord.plan.MyRecordPlanVO;


@Mapper
public interface ReviewMapper {
	//로그인 정보 받아오기
	// XML 파일 id이름과 메서드명 똑같이 사용
	List<ReviewVO> test();
	
	void insertReviewComment(Map<String,Object> map);
	
	

	//=======================
	// review
	//=======================

	List<ReviewVO> list(ReviewVO vo);

	int count(ReviewVO vo);

	ReviewVO view(ReviewVO vo);
	List<ReviewVO> getReviewComments(int review_pk);

	void increaseViews(int review_pk);

//	int updateViewcount(int user_pk);
	
//	int insert(DefaultVO vo); //
//	int update(DefaultVO vo); //업데이트
//	int delete(DefaultVO vo); //삭제
//	int count(DefaultVO vo);
//	List<DefaultVO> list(DefaultVO vo);
//	DefaultVO view(DefaultVO vo);
//	int viewCount(int no); //조회수
}
	