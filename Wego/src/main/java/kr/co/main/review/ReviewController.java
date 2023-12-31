
package kr.co.main.review;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.UUID;
import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.main.first.UserVO;
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
	public String view(Model model, ReviewVO vo, HttpSession sess) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		UserVO user = (UserVO)sess.getAttribute("loginSession");
		// 후기 게시글 조회
	    ReviewVO review = rservice.view(vo);
	    
	    // 후기 게시글의 댓글 조회
	    List<ReviewVO> comments = rservice.getReviewComments(vo.getReview_pk());
	    if(!comments.isEmpty()) {
	    	System.out.println(comments.get(0).getRegdate_comment());
	    }
	   

	    String nick = user.getNickName();
	    System.out.println( nick);
	    model.addAttribute("nickname", user.getNickName());
//	    System.out.println(vo.getNickname());
	    model.addAttribute("user_pk", user.getUser_pk());
	    model.addAttribute("review_pk", vo.getReview_pk());
		model.addAttribute("data", review);
		model.addAttribute("comments", comments);
		model.addAttribute("watch", rservice.reviewWatch(vo));
		//추천수
		model.addAttribute("recommend", rservice.reviewRecommend(vo));
		//조회수 1씩 증가
		model.addAttribute("watchPlus", rservice.reviewWatchPlus(vo));
		
		
		//===사진===//
		
		
		
		//===사진===//
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		return "review/view";
	}
		
	//추천수추가
	//
	/*	
	@PostMapping("reviewRecommendPlus.do")
	public void reviewRecommendPlus(ReviewVO vo) {
		/*System.out.println(vo);*/
		
		/*vo.setUser_pk(user_pk);*/
		/*vo.setRegdate_comment(new Date(System.currentTimeMillis()));*/
		
	//	rservice.reviewRecommendPlus(vo);
	//}
	
	//추천수추가
	@PostMapping("reviewRecommendPlus.do")
	@ResponseBody
	public int reviewRecommendPlus(ReviewVO vo) {
	    int updatedRecommendCount = rservice.reviewRecommendPlus(vo);
	    return updatedRecommendCount;
	}
	
	//조회수추가
	@PostMapping("reviewWatchPlus.do")
	@ResponseBody
	public int reviewWatchPlus(Model model, ReviewVO vo) {
		model.addAttribute("watchPlus", rservice.reviewWatch(vo));
	    int reviewWatchPlus = rservice.reviewWatchPlus(vo);
	    return reviewWatchPlus;
	}
	
	
		
	//===
	//후기 게시판 전체 목록 사진있는거 review => index 목록
	//===
	@GetMapping("index.do")
	public String review(Model model, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		model.addAttribute("result", rservice.index(vo));
		model.addAttribute("watch", rservice.reviewWatch(vo));
		model.addAttribute("recommend", rservice.reviewRecommend(vo));
		//model.addAttribute("ReviewVO", vo);
		return "review/index";
	}	
		

	//===
	//수정 review_update => edit
	//===
	@GetMapping("edit.do")
	public String edit(Model model, ReviewVO vo, HttpSession sess) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		UserVO user = (UserVO)sess.getAttribute("loginSession");
		model.addAttribute("user_pk", user.getUser_pk());
		model.addAttribute("data", rservice.edit(vo));
		return "review/edit";
	}	
	
	// 글 수정 처리
	@PostMapping("update.do")
	public String update(HttpServletRequest request, Model model, ReviewVO vo, @RequestParam(value = "filename", required = false) MultipartFile[] files) {
	    vo.setState(0);
	    System.out.println(vo);
//	    System.out.println("files.size():"+files.length);
//	    if (files != null && files.length > 0) {
	        int randn = (int)(Math.random() * (files.length - 1));
//	        System.out.println(randn);
	        int fr = 0;
	        for (MultipartFile file : files) {
	        	if (!file.isEmpty()) {
		            try {
		                String originalFilename = file.getOriginalFilename();
		                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
		                String uniqueFilename = UUID.randomUUID().toString() + fileExtension;
		                String filePath = request.getRealPath("/image/client/") + uniqueFilename;
		                File dest = new File(filePath);
		                FileUtils.writeByteArrayToFile(dest, file.getBytes());
		                file.transferTo(dest);
		                System.out.println("파일: " + dest.getAbsolutePath());
		                vo.setFilename_org(originalFilename);
		                vo.setFilename_save(uniqueFilename);
		                vo.setFilesize(dest.length());
		                
		                if (fr == randn)
		                    vo.setFilestate(1);
		                else
		                    vo.setFilestate(0);
		                
		                rservice.savingReview_image(vo);
		                
		            } catch (IOException e) {
		                e.printStackTrace();
		            } finally {
		                System.out.println(fr);
		                fr++;
		            }
	        	}
	        }
//	    }
	    
	    if (rservice.update(vo)) {
	        model.addAttribute("msg", "정상적으로 수정되었습니다.");
	        model.addAttribute("url", "index.do?review_pk=" + vo.getReview_pk());
	    } else {
	        model.addAttribute("msg", "수정 실패");
	    }
	    
	    return "include/alert";
	}
	
	
	
	
	
	
	
	
	/*
	//글수정
	@PostMapping("update.do")
	public String update(HttpServletRequest request, Model model, ReviewVO vo, @RequestParam("file") List<MultipartFile> files) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		//
		vo.setState(0);
		if(files != null) {
			int randn = (int)(Math.random() * files.size()-1);
			System.out.println(randn);
			int fr = 0;
			for(MultipartFile file : files) {
				try {
					String originalFilename = file.getOriginalFilename();
					String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
					String uniqueFilename = UUID.randomUUID().toString() + fileExtension;
					String filePath = request.getRealPath("/image/client/") + uniqueFilename;
					File dest = new File(filePath);
					FileUtils.writeByteArrayToFile(dest, file.getBytes());
					file.transferTo(dest);
					System.out.println("파일: "+ dest.getAbsolutePath());
					vo.setFilename_org(originalFilename);
					vo.setFilename_save(uniqueFilename);
					vo.setFilesize(dest.length());
					
					if(fr == randn)
						vo.setFilestate(1);
					else
						vo.setFilestate(0);
					rservice.savingReview_image(vo);
					
				}catch(IOException e){
					e.printStackTrace();
				}finally {
					System.out.println(fr);
					fr++;
				}
			}
		}
		
		
		
		
		
		//
		if(rservice.update(vo)) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "index.do?review_pk="+vo.getReview_pk());
			
			
			
			
			
			
			
			
			
			
			
			
		} else {
			model.addAttribute("msg", "수정 실패");
			
		}
		
		
		
		
		
		
		
		return "include/alert";
	}
	*/
	
	
	
	//댓글 등록
	@PostMapping("insertReviewComment.do")
	public String insertReviewComment(Model model, ReviewVO vo, HttpSession sess) {
		System.out.println("댓글등록"+vo);
		UserVO user = (UserVO)sess.getAttribute("loginSession");
		model.addAttribute("user_pk", user.getUser_pk());
		//vo.setUser_pk(user_pk);
		vo.setRegdate_comment(new Date(System.currentTimeMillis()));
		model.addAttribute("nickname", vo.getNickname());
		
		if(rservice.insertReviewComment(vo)) {
			model.addAttribute("msg", "정상적으로 잘 등록되었습니다.");
			model.addAttribute("url", "view.do?review_pk="+vo.getReview_pk()+"&user_pk="+vo.getUser_pk());
		} else {
			model.addAttribute("msg", "등록 실패");
		}
//		model.addAttribute("insertReviewComment", rservice.insertReviewComment(vo));
		return "include/alert";
	}

	
	/*
	@PostMapping("insertReviewComment.do")
	public String insertReviewComment(Model model, ReviewVO vo, HttpSession sess) {
	    System.out.println("댓글등록" + vo);
	    UserVO user = (UserVO) sess.getAttribute("loginSession");
	    if (user == null) {
	        model.addAttribute("msg", "댓글 등록에 실패하였습니다. 로그인이 필요합니다.");
	        return "include/alert";
	    }
	    model.addAttribute("user_pk", user.getUser_pk());
	    vo.setRegdate_comment(new Date(System.currentTimeMillis()));
	    model.addAttribute("nickname", vo.getNickname());

	    try {
	        if (rservice.insertReviewComment(vo)) {
	            model.addAttribute("msg", "정상적으로 잘 등록되었습니다.");
	            model.addAttribute("url", "view.do?review_pk=" + vo.getReview_pk() + "&user_pk=" + vo.getUser_pk());
	        } else {
	            model.addAttribute("msg", "댓글 등록에 실패하였습니다.");
	        }
	    } catch (Exception e) {
	        model.addAttribute("msg", "댓글 등록 중 오류가 발생하였습니다.");
	        // 여기서 e.getMessage()를 이용해 예외 메시지를 가져와서 추가로 출력해도 좋습니다.
	    }

	    return "include/alert";
	}

	*/
	
	
	
	
	
	
	//댓글수정`
	/*@PostMapping("commentUpdate.do")
	public String commentUpdate(Model model, @RequestParam("review_comment_pk") String review_comment_pk, ReviewVO vo) { //필요해서 param 다드러잇어 sword page 기본ㅏㄱㅄ으로 들어가잇고
		if(rservice.commentUpdate(vo)) {
			int commentPk = Integer.parseInt(review_comment_pk); 
			vo.setReview_comment_pk(commentPk);
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "view.do?review_pk="+vo.getReview_pk()+"&user_pk="+vo.getUser_pk());
			
		} else {
			model.addAttribute("msg", "수정 실패");
		}
		return "include/alert";
	}*/
	
	@PostMapping("commentUpdate.do")
	public String commentUpdate(Model model, @RequestParam("review_comment_pk") String review_comment_pk, ReviewVO vo) {
	    try {
	        int commentPk = Integer.parseInt(review_comment_pk);
	        // 유효한 정수로 변환된 경우의 처리 로직
	        vo.setReview_comment_pk(commentPk);
	        if (rservice.commentUpdate(vo)) {
	            model.addAttribute("msg", "정상적으로 수정되었습니다.");
	            //model.addAttribute("url", "view.do?review_pk=" + vo.getReview_pk() + "&user_pk=" + vo.getUser_pk());
	        } else {
	            model.addAttribute("msg", "수정 실패");
	        }
	    } catch (NumberFormatException e) {
	        // 유효하지 않은 정수인 경우의 처리 로직
	        model.addAttribute("msg", "유효하지 않은 댓글 ID입니다.");
	    }
	    return "include/alert";
	}

	
	
	//댓글삭제
	@GetMapping("commentDelete.do")
	public String deleteReviewComment(Model model, ReviewVO vo) { //필요해서 param 다들어잇어 sword page 기본값으로 들어가잇고
		
		if(rservice.deleteReviewComment(vo)) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "view.do?review_pk="+vo.getReview_pk()+"&user_pk="+vo.getUser_pk());
			
			
		} else {
			model.addAttribute("msg", "삭제 실패");
			
			
		}
		return "include/alert";
	}
	
	
	
	//신고
	// 서버 측 코드
	@PostMapping("insertReviewSue.do")
	@ResponseBody
	public boolean insertReviewSue(Model model, ReviewVO vo) {
	    boolean success = rservice.insertReviewSue(vo);

	    return success;
	}


	
	
	
	/*
	//댓글삭제
	@GetMapping("commentDelete.do")
	public String deleteReviewComment(Model model, @RequestParam("review_comment_pk") int review_comment_pk, @RequestParam("review_pk") int review_pk, @RequestParam("user_pk") int user_pk) {
	    ReviewVO vo = new ReviewVO(); // ReviewVO 객체 생성
	    vo.setReview_pk(review_pk); // review_pk 설정
	    vo.setUser_pk(user_pk); // user_pk 설정
	    
	    if (rservice.deleteReviewComment(review_comment_pk)) {
	        model.addAttribute("msg", "정상적으로 삭제되었습니다.");
	        model.addAttribute("url", "view.do?review_pk=" + vo.getReview_pk() + "&user_pk=" + vo.getUser_pk());
	    } else {
	        model.addAttribute("msg", "삭제 실패");
	    }
	    
	    return "include/alert";
	}*/

	
	
	
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
			파라미터 전달
			user_pk=1인 사람이 등록했다.
			
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
	
	
	
	
	
	
	
	//복붙
	@Transactional
	@PostMapping("reviewing2.do")
	public String savingReiews2(HttpServletRequest request, ReviewVO vo, HttpSession sess, @RequestParam("file") List<MultipartFile> files) {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String ppk = request.getParameter("plan_pk");
		int plan_pk = Integer.parseInt(ppk);
		vo.setPlan_pk(plan_pk);
		vo.setTitle(title);
		vo.setContent(contents);
		vo.setState(0);
		rservice.setReviewed2(plan_pk);
		rservice.savingReviews(vo);
		int randn = (int)(Math.random() * files.size()-1);
		System.out.println(randn);
		int fr = 0;
		for(MultipartFile file : files) {
			try {
				String originalFilename = file.getOriginalFilename();
				String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
				String uniqueFilename = UUID.randomUUID().toString() + fileExtension;
				String filePath = request.getRealPath("/image/client/") + uniqueFilename;
				File dest = new File(filePath);
				FileUtils.writeByteArrayToFile(dest, file.getBytes());
				file.transferTo(dest);
				System.out.println("파일: "+ dest.getAbsolutePath());
				vo.setFilename_org(originalFilename);
				vo.setFilename_save(uniqueFilename);
				vo.setFilesize(dest.length());
				
				if(fr == randn)
					vo.setFilestate(1);
				else
					vo.setFilestate(0);
				rservice.savingReview_image(vo);
				
			}catch(IOException e){
				e.printStackTrace();
			}finally {
				System.out.println(fr);
				fr++;
			}
		}
		
		return "review/index";
	}
	
	
	@GetMapping("viewingOLR.do")
	public String viewingOLR(@RequestParam("review_pk")String review_pk, Model model) {
		int x = Integer.parseInt(review_pk);
		model.addAttribute("result",rservice.viewingOLR(x));
		model.addAttribute("flag","jv");
		return "/review/view.do";
	}
	
	@GetMapping("viewingTR.do")
	public String viewingTR(@RequestParam("review_pk")String review_pk, Model model, HttpServletRequest request) {
		
		return "/myRecord/plan/review_update";
	}
	
//	깃허브테스트중 테스트 완료 클론 
	
	
}