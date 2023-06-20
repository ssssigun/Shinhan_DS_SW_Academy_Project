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
	
	public LocationVO selectLocationByPK(int location_pk) {
		LocationVO vo = mapper.selectLocationByPK(location_pk);
		return vo;
	}
	
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
