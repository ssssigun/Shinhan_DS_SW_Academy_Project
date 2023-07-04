
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
	
	public void insertReviewComment(Map<String,Object> map) {
		mapper.insertReviewComment(map);
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
			int endPage = (int)Math.ceil(vo.getPage() / 8.0) *8;
			int startPage = endPage - 7;
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

//	mapper.updateViewcount(vo.getUser_pk());
	
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}