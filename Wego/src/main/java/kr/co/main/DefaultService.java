package kr.co.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class DefaultService {

	@Autowired
	DefaultMapper mapper;
	//함수 만들어서 사용
	public List<DefaultVO> test(){
		List<DefaultVO> m = mapper.test();
		System.out.println("service" + m.toString());
		return m;
	}
	
	
//	///====
//	public DefaultVO view(DefaultVO vo) {
//		mapper.viewCount(vo.getReview_pk());
//		
//		return mapper.view(vo);
//	}
	
}
