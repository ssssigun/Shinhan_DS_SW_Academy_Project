
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
	@Autowired
	ReviewService Service;
	@GetMapping("/index.do")
	public String index(Model model) {
		List<ReviewVO> vo =  Service.test();
		System.out.println("controller" + vo.toString());
		model.addAttribute("vo", vo);
		return "index";
	}
	
	
	
	//===
	//상세 게시물 댓글 조회수
	//===
		@GetMapping("/review_comment_write.do")
		public String view(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review/review_comment_write";
		}
		
	//===
	//후기 게시판 전체 목록 사진있는거
	//===
		@GetMapping("/review.do")
		public String review(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review/review";
		}	
		
	//===
	//수정
	//===
		@GetMapping("/review_update.do")
		public String review_update(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//				model.addAttribute("data", Service.view(vo));
			return "review/review_update";
		}	
		
}