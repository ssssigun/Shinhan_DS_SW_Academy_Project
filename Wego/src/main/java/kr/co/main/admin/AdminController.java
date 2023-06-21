package kr.co.main.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	//관리자 로그인 폼 불러오기
	@GetMapping("/login.do")
	public String adminLogin() {
		return "admin/adminLogin";
	}
	//관리자 로그인 처리
	@PostMapping("login.do")
	public String adminLoginProcess() {
		return "boardManagement.do";
	}
	//관리자 신고 게시물 페이지
	@GetMapping("/boardManagement.do")
	public String boardManagement() {
		return "admin/adminBoardList";
	}
	//관리 신고 유저 페이지
	@GetMapping("/userManagement.do")
	public String userManagement() {
		return "admin/adminUserList";
	}
}
