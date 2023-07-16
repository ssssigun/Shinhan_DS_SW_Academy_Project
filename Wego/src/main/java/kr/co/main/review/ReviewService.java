
package kr.co.main.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

	@Autowired
	ReviewMapper mapper;
	//함수 만들어서 사용
	public List<ReviewVO> test(){
		List<ReviewVO> m = mapper.test();
		System.out.println("service" + m.toString());
		return m;
	}
	
	/*public void insertReviewComment(Map<String,Object> map) {
		//mapper.insertReviewComment(map);
	}*/
	
	
	//댓글 등록
	public boolean insertReviewComment(ReviewVO vo) {
		int n = mapper.insertReviewComment(vo);
		
		System.out.println("service update: " + vo);

		return n > 0 ? true : false;
		
	}
	
	
	
	//목록 이 젤 크리티컬 기능들 많음 (검색, 페이징) 
	public Map index(ReviewVO vo) {
// 총개수 구하기
			int totalCount = mapper.count(vo);
			// 총페이지수 구하기
			int totalPage = totalCount / vo.getRowPerPage();
			if (totalCount % vo.getRowPerPage() > 0) totalPage++;
			//startIdx 구하기
			int startIdx = (vo.getPage()-1) * vo.getRowPerPage(); //0번인덱스부터 10번까지
			vo.setStartIdx(startIdx); //명시적으로 구해온느형태로 셋
			//목록 조회
			List<ReviewVO> list = mapper.list(vo);
			//페이지관련 처리
			int endPage = (int)Math.ceil(vo.getPage() / 10.0) *10;
			int startPage = endPage - 9;
			if(endPage > totalPage) endPage = totalPage;
			boolean prev = startPage > 1 ? true : false;
			boolean next = totalPage > endPage ? true : false;
			
			
			//map 저장
			
			Map map = new HashMap();
			map.put("totalCount", totalCount);
			map.put("totalPage", totalPage);
			map.put("list", list); //객체 그안에 배열 배열안에 객체
			//그럼 한방에 넘겨줄수잇음
			map.put("startPage", startPage);		
			map.put("endPage", endPage);	
			map.put("prev", prev);	//이전 얘가 트루면
			map.put("next", next);	//다음 10개
			System.out.println(list);
			return map;
	}

	public ReviewVO view(ReviewVO vo) {
	    return mapper.view(vo);
	}

	public List<ReviewVO> getReviewComments(int review_pk) {
	    return mapper.getReviewComments(review_pk);
	}

	public void increaseViews(int review_pk) {
	    mapper.increaseViews(review_pk);
	}

	public ReviewVO edit(ReviewVO vo) { //수정폼
		return mapper.view(vo);
	}
	
	public boolean update(ReviewVO vo) { //업데이트치는거
		int n = mapper.update(vo);
		
		System.out.println("service update: " + vo);

		return n > 0 ? true : false;
//		return mapper.update(vo) > 0 ? true : false;
	}

	//리뷰 조회수
	public ReviewVO reviewWatch(ReviewVO vo) {
		return mapper.reviewWatch(vo);
		
	}
	
	//리뷰 추천수
	public ReviewVO reviewRecommend(ReviewVO vo) {
		return mapper.reviewRecommend(vo);
		
	}
	
	//추천수 추가
	public int reviewRecommendPlus(ReviewVO vo) {
		int temp = mapper.reviewRecommendPlus(vo);
		return temp;
	}
	
	//조회수 추가
	public int reviewWatchPlus(ReviewVO vo) {
		int temp = mapper.reviewWatchPlus(vo);
		return temp;
	}

	public boolean deleteReviewComment(ReviewVO vo) {
		
		return mapper.deleteReviewComment(vo) > 0 ? true : false;
	}

	
	
	
	// ReviewService.java
	public boolean insertReviewSue(ReviewVO vo) {
	    boolean success = mapper.insertReviewSue(vo); //인서트반환값 행
	    return success;
	}


	// ReviewService.java
	public int getUpdatedRecommendCount(String review_pk) {
	  int updatedRecommendCount = mapper.getUpdatedRecommendCount(review_pk);
	  return updatedRecommendCount;
	}

	public boolean commentUpdate(ReviewVO vo) {
		int n = mapper.commentUpdate(vo);
		
		System.out.println("service update: " + vo);

		return n > 0 ? true : false;
	}


	
//	mapper.updateViewcount(vo.getUser_pk());
	
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//댓글 보기
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*public ReviewVO getReviewById(Long id) {
        return mapper.getReviewById(id);
    }

    public List<ReviewVO> getAllReviews() {
        return mapper.getAllReviews();
    }

    public ReviewVO addReview(ReviewVO review) {
        mapper.addReview(review);
        return review;
    }

    public ReviewVO updateReview(Long id, ReviewVO review) {
        ReviewVO existingReview = mapper.getReviewById(id);
        if (existingReview != null) {
            review.setId(id);
            mapper.updateReview(review);
            return review;
        } else {
            return null;
        }
    }

    public boolean deleteReview(Long id) {
        ReviewVO existingReview = mapper.getReviewById(id);
        if (existingReview != null) {
            mapper.deleteReview(id);
            return true;
        } else {
            return false;
        }
    }*/
	
	
	//복붙
	public void setReviewed2(int ppk) {
		mapper.setReviewed2(ppk);
	}
	public void savingReviews(MyRecordPlanVO vo) {
		mapper.savingReviews(vo);
	}
	public void savingReview_image(MyRecordPlanVO vo) {
		mapper.savingReview_image(vo);
	}
	
}