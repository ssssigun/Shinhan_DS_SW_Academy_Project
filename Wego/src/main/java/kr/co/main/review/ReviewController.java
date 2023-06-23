
package kr.co.main.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/review")
public class ReviewController {
	
	
	
	
	//===
	//상세 게시물 댓글 조회수 review_comment_write => view 리뷰 상세 보기
	//===
		@GetMapping("view.do")
		public String view(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review/view";
		}
		
	//===
	//후기 게시판 전체 목록 사진있는거 review => index 목록
	//===
		@GetMapping("index.do")
		public String review(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review/index";
		}	
		
	//===
	//수정 review_update => edit
	//===
		@GetMapping("edit.do")
		public String review_update(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//				model.addAttribute("data", Service.view(vo));
			return "review/edit";
		}	
		
}