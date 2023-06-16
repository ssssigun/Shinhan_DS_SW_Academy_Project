package kr.co.main.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlanService {

	@Autowired
	PlanMapper mapper;
	//함수 만들어서 사용
	public List<LocationVO> selectLocationPer5(LocationVO vo){
		List<LocationVO> locationList = mapper.selectLocationPer5(vo);
		for (LocationVO nvo: locationList) {
			addCategoryName(nvo);
		}
		return locationList;
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
