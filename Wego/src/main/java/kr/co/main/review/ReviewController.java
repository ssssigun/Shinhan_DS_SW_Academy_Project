
package kr.co.main.review;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;





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
	    
	    
	    
		model.addAttribute("data", review);
		model.addAttribute("comments", comments);
		model.addAttribute("watch", rservice.reviewWatch(vo));
		
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
			model.addAttribute("url", "index.do?review_pk="+vo.getReview_pk());
			
		} else {
			model.addAttribute("msg", "수정 실패");
			
		}
		return "include/alert";
	}
	
	
	
	
	
	/*
	
	//등록
		@PostMapping("/board/notice/insert.do")
		public String insert(Model model, NoticeVO vo, HttpSession sess) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
			MemberVO loginSess = (MemberVO)sess.getAttribute("loginSess");
			vo.setMemberno(loginSess.getNo());
			if(nservice.insert(vo)) {
				model.addAttribute("msg", "정상적으로 잘 등록되었습니다.");
				model.addAttribute("url", "index.do");
				
			} else {
			model.addAttribute("msg", "등록 실패");
			
			}
			return "include/alert";
		}
	
	
	*/
	
	
	
	
	
	
	
	
	

	/*@GetMapping("/{id}")
    public ResponseEntity<ReviewVO> getReviewById(@PathVariable("id") Long id) {
        ReviewVO review = rservice.getReviewById(id);
        if (review != null) {
            return new ResponseEntity<>(review, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<ReviewVO>> getAllReviews() {
        List<ReviewVO> reviews = rservice.getAllReviews();
        return new ResponseEntity<>(reviews, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<ReviewVO> addReview(@RequestBody ReviewVO review) {
        ReviewVO createdReview = rservice.addReview(review);
        return new ResponseEntity<>(createdReview, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ReviewVO> updateReview(@PathVariable("id") Long id, @RequestBody ReviewVO review) {
        ReviewVO updatedReview = rservice.updateReview(id, review);
        if (updatedReview != null) {
            return new ResponseEntity<>(updatedReview, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable("id") Long id) {
        boolean deleted = rservice.deleteReview(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }*/
	
		
}