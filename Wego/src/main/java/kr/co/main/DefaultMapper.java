package kr.co.main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface DefaultMapper {
	//로그인 정보 받아오기
	// XML 파일 id이름과 메서드명 똑같이 사용
	List<DefaultVO> test();
	
	
	
	
	
	//=======================
	// review
	//=======================
	
//	int insert(DefaultVO vo); //
//	int update(DefaultVO vo); //업데이트
//	int delete(DefaultVO vo); //삭제
//	int count(DefaultVO vo);
//	List<DefaultVO> list(DefaultVO vo);
//	DefaultVO view(DefaultVO vo);
//	int viewCount(int no); //조회수
}
	