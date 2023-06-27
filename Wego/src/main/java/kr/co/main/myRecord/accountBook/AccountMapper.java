package kr.co.main.myRecord.accountBook;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface AccountMapper {
	//로그인 정보 받아오기
	// XML 파일 id이름과 메서드명 똑같이 사용
	TotalRateVO totalRate(int user_pk);
	TotalRateVO getTotalRateForRadar(int user_pk);
	List<ReportVO> getReportList(ReportVO vo);
	int getCountReportList(int user_pk);
	List<AccountBookVO> getUsageForUsageList(Map<String, Object> map);
	List<AccountBookVO> getCompareForUsageListForDay(Map<String, Object> map);
	AccountBookVO getTotalForDay(Map<String, Object> map);
	
	
	
	
	
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
	