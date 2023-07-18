package kr.co.main.myRecord.plan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyRecordPlanService {
	@Autowired
	MyRecordPlanMapper mapper;
	
	//���������̼� �ؼ� ��� �������°� : state=0 ��
	public Map index(MyRecordPlanVO vo) {
		int totalCount = mapper.count(vo.getUser_pk());
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
	
	//���������̼� �ؼ� ��� �������°� : state=1 ��
		public Map reviewing(MyRecordPlanVO vo) {
			int totalCount = mapper.count2(vo.getUser_pk());
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
		
		public Map dragingImage(int oh) {
			List<MyRecordPlanVO> list = mapper.dragingImage(oh);

			Map map = new HashMap();
			map.put("list",list);
			return map;
		}
		
		//���������̼� �ؼ� ��� �������°� : state=2 ��
				public Map tempSaved(MyRecordPlanVO vo) {
					int totalCount = mapper.count3(vo.getUser_pk());
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
					int totalCount = mapper.count(vo.getUser_pk());
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
				
				public List<MyRecordPlanVO> savedImages(int x){
					List<MyRecordPlanVO> list = mapper.savedImages(x);
					return list;
				}
}