
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
	
	
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}