
package kr.co.main.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.main.myRecord.plan.MyRecordPlanService;
import kr.co.main.myRecord.plan.MyRecordPlanVO;



@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	ReviewService rservice;
	
	
	//===
	//상세 게시물 댓글 조회수 review_comment_write => view 리뷰 상세 보기
	//===
	@GetMapping("view.do")
	public String view(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		// 후기 게시글 조회
	    ReviewVO review = rservice.view(vo);
	    
	 // 후기 게시글의 댓글 조회
	    List<ReviewVO> comments = rservice.getReviewComments(vo.getReview_pk());
		model.addAttribute("data", rservice.view(vo));
		
		System.out.println(vo);
		
		
		return "review/view";
	}
		
		
		
		
	//===
	//후기 게시판 전체 목록 사진있는거 review => index 목록
	//===
	@GetMapping("index.do")
	public String review(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		model.addAttribute("result", rservice.index(vo));
		return "review/index";
	}	
		

	//===
	//수정 review_update => edit
	//===
	@GetMapping("edit.do")
	public String edit(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		model.addAttribute("data", rservice.edit(vo));
		return "review/edit";
	}	
	
	
	@PostMapping("update.do")
	public String update(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		if(rservice.update(vo)) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "index.do?no="+vo.getReview_pk());
			
		} else {
			model.addAttribute("msg", "수정 실패");
			
		}
		return "include/alert";
	}
		
}