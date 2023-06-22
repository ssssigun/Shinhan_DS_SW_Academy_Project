package kr.co.main.myRecord.plan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyRecordPlanService {
	@Autowired
	MyRecordPlanMapper mapper;
	
	//페이지네이션 해서 목록 가져오는거 : state=0 들
	public Map index(MyRecordPlanVO vo) {
		int totalCount = mapper.count();
		int totalPage = totalCount/vo.getRowPerPage();
		if(totalCount % vo.getRowPerPage() > 0) totalPage++;
		int startIdx = (vo.getPage()-1) * vo.getRowPerPage();
		vo.setStartIdx(startIdx);
		List<MyRecordPlanVO> list = mapper.list(vo);
		
		int endPage = (int)Math.ceil(vo.getPage() / 8.0)*8;
		int startPage = endPage - 7;
		if(endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = totalPage > endPage ? true : false;
		
		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("startPage",startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next",next);
		
		return map;
	}
	
	//페이지네이션 해서 목록 가져오는거 : state=1 들
		public Map reviewing(MyRecordPlanVO vo) {
			int totalCount = mapper.count2();
			int totalPage = totalCount/vo.getRowPerPage();
			if(totalCount % vo.getRowPerPage() > 0) totalPage++;
			int startIdx = (vo.getPage()-1) * vo.getRowPerPage();
			vo.setStartIdx(startIdx);
			List<MyRecordPlanVO> list = mapper.list2(vo);
			
			int endPage = (int)Math.ceil(vo.getPage() / 8.0)*8;
			int startPage = endPage - 7;
			if(endPage > totalPage) endPage = totalPage;
			boolean prev = startPage > 1 ? true : false;
			boolean next = totalPage > endPage ? true : false;
			
			Map map = new HashMap();
			map.put("totalCount", totalCount);
			map.put("totalPage", totalPage);
			map.put("list", list);
			map.put("startPage",startPage);
			map.put("endPage", endPage);
			map.put("prev", prev);
			map.put("next",next);
			
			return map;
		}
		
		//페이지네이션 해서 목록 가져오는거 : state=2 들
				public Map tempSaved(MyRecordPlanVO vo) {
					int totalCount = mapper.count3();
					int totalPage = totalCount/vo.getRowPerPage();
					if(totalCount % vo.getRowPerPage() > 0) totalPage++;
					int startIdx = (vo.getPage()-1) * vo.getRowPerPage();
					vo.setStartIdx(startIdx);
					List<MyRecordPlanVO> list = mapper.list3(vo);
					
					int endPage = (int)Math.ceil(vo.getPage() / 8.0)*8;
					int startPage = endPage - 7;
					if(endPage > totalPage) endPage = totalPage;
					boolean prev = startPage > 1 ? true : false;
					boolean next = totalPage > endPage ? true : false;
					
					Map map = new HashMap();
					map.put("totalCount", totalCount);
					map.put("totalPage", totalPage);
					map.put("list", list);
					map.put("startPage",startPage);
					map.put("endPage", endPage);
					map.put("prev", prev);
					map.put("next",next);
					
					return map;
				}
}