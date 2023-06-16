package kr.co.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class DefaultController {
	@Autowired
	DefaultService Service;
	@GetMapping("/index.do")
	public String index(Model model) {
		List<DefaultVO> vo =  Service.test();
		System.out.println("controller" + vo.toString());
		model.addAttribute("vo", vo);
		return "index";
	}
	
	
	
	//===
	//상세 게시물 댓글 조회수
	//===
		@GetMapping("/review_comment_write.do")
		public String view(Model model, DefaultVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review_comment_write";
		}
		
	//===
	//후기 게시판 전체 목록 사진있는거
	//===
		@GetMapping("/review.do")
		public String review(Model model, DefaultVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
//			model.addAttribute("data", Service.view(vo));
			return "review";
		}	
		
}
