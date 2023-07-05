package kr.co.main.plan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlanService {

	@Autowired
	PlanMapper mapper;
	//함수 만들어서 사용
	
	// 지역, 카테고리, 검색어, 지도 위치 기반해서 장소 5개 검색하는 메소드
	public Map selectLocationPer5(LocationVO vo) {
		int totalCount = mapper.count(vo);
		int totalPage = totalCount / vo.getRowPerPage();
		if (totalPage % vo.getRowPerPage() > 0) totalPage++;
		int startIdx = (vo.getPage() - 1) * vo.getRowPerPage();
		vo.setStartIdx(startIdx);
		List<LocationVO> locationList = mapper.selectLocationPer5(vo);
		
		int endPage = (int) Math.ceil(vo.getPage() / 10.0) * 10;
		int startPage = endPage - 9;
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = totalPage > endPage ? true : false;
		
		Map map = new HashMap();
		for (LocationVO nvo: locationList) {
			addCategoryName(nvo);
			System.out.println(nvo);
		}
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("locationList", locationList);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		
		return map;
	}
	
	// PK를 사용해서 장소를 검색하는 메소드
	public List<LocationVO> selectLocationByPK(int location_pk) {
		List<LocationVO> vo = mapper.selectLocationByPK(location_pk);
		for (LocationVO nvo: vo) {
			System.out.println(vo);
		}
		return vo;
	}
	
	// plan, plan_detail에 insert 하는 메소드
	public void insertPlanAndDetail(PlanVO planVO, List<PlanDetailVO> listPlanDetailVO) {
		mapper.insertPlan(planVO);
		for (PlanDetailVO planDetailVO : listPlanDetailVO) {
			planDetailVO.setPlan_pk(planVO.getPlan_pk());
			mapper.insertPlanDetail(planDetailVO);
		}
	}
	
	
	// 카테고리 코드를 한글로 바꾸어 주는 메소드
	public void addCategoryName(LocationVO vo) {
		switch (vo.getCategory()) {
			case 1: vo.setCategory_name("음식점");
					break;
			case 2: vo.setCategory_name("숙박");
					break;
			case 3: vo.setCategory_name("쇼핑");
					break;
			case 4: vo.setCategory_name("문화활동");
					break;
			case 5: vo.setCategory_name("관광지");
					break;
			case 6: vo.setCategory_name("레포츠");
					break;
			default: vo.setCategory_name("미정");
					break;
		}
	}
	
}
