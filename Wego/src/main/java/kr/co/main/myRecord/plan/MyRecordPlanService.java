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
				
				public Map deleting(int x ,MyRecordPlanVO vo) {
					mapper.deletion(x);
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
				
				public List<MyRecordPlanVO> chopAndReading(int x) {
					List<MyRecordPlanVO> list = mapper.list4(x);
					
					return list;
				}
				
				public boolean reviewing1(MyRecordPlanVO vo) {
					return mapper.reviewing1(vo) > 0 ? true : false;
				}
				
				public void setReviewed(int ppk) {
					mapper.setReviewed(ppk);
				}
				
				public void savingReviews(MyRecordPlanVO vo) {
					mapper.savingReviews(vo);
				}
				
				public void savingReview_image(MyRecordPlanVO vo) {
					mapper.savingReview_image(vo);
				}
				
				public List<MyRecordPlanVO> viewingOLR(int x) {
					List<MyRecordPlanVO> list = mapper.viewingOLR(x);
					return list;
				}
				
				public MyRecordPlanVO viewingTR(int x) {
					MyRecordPlanVO list = mapper.viewingTR(x);
					return list;
				} 
				
				public void setReviewed2(int ppk) {
					mapper.setReviewed2(ppk);
				}
}