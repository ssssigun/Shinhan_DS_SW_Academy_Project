package kr.co.main.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService AService;
	
	//관리자 로그인 폼 불러오기
	@GetMapping("/login.do")
	public String adminLogin() {
		return "admin/adminLogin";
	}
	//관리자 로그인 처리
	@ResponseBody
	@PostMapping("login.do")
	public int adminLoginProcess(AdminVO vo) {
		return AService.adminLoginProcess(vo);
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
