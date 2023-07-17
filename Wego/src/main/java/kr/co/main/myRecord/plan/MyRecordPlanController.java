package kr.co.main.myRecord.plan;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/myRecord/plan")
public class MyRecordPlanController {
	
	@Autowired
	MyRecordPlanService service;
	
	@GetMapping("/index.do")
	public String index(MyRecordPlanVO vo, Model model) {
		model.addAttribute("result",service.index(vo));
		model.addAttribute("flag","1");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("/reviewing.do")
	public String reviewing(MyRecordPlanVO vo, Model model) {
		Map result = service.reviewing(vo);
		model.addAttribute("result",result);
		model.addAttribute("flag","2");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("/tempSaved.do")
	public String tempSaved(MyRecordPlanVO vo, Model model) {
		model.addAttribute("result",service.tempSaved(vo));
		model.addAttribute("flag","3");
		return "/myRecord/plan/index";
	}
	
	@GetMapping("writingReviews.do")
	public String writingReviews(MyRecordPlanVO vo, Model model, @RequestParam("plan_pk")String plan_pk) {
		int x = Integer.parseInt(plan_pk);
		model.addAttribute("result",service.chopAndReading(x));
		model.addAttribute("plan_pk",plan_pk);
		return "/myRecord/plan/review_comment_write";
	}
	
	@GetMapping("reviewUpdating.do")
	public String reviewUpdating(MyRecordPlanVO vo, Model model, @RequestParam("plan_pk")String plan_pk) {
		model.addAttribute("plan_pk",plan_pk);
		return "/myRecord/plan/review_update";
	}
	
	@GetMapping("deleting.do")
	public String deleting(@RequestParam("plan_pk")String plan_pk, @RequestParam("flag")String flag, MyRecordPlanVO vo, Model model) {
		int x = Integer.parseInt(plan_pk);
		model.addAttribute("result",service.deleting(x,vo));
		if(flag.equals("1"))
			return "redirect:/myRecord/plan/index.do";
		else
			return "redirect:/myRecord/plan/tempSaved.do";
	}
	
	@PostMapping("reviewing1.do")
	public String savingReviews(HttpServletRequest request ,MyRecordPlanVO vo, HttpSession sess) {
		String[] scores = request.getParameterValues("scores");
		String[] reviews = request.getParameterValues("oneLineReviews");
		String[] idx = request.getParameterValues("pks");
		String[] plan_pk = request.getParameterValues("plan_pk");
		int ppk = Integer.parseInt(plan_pk[0]);
		service.setReviewed(ppk);
		for(int i = 0; i<idx.length; i++) {
			vo.setLocation_content(reviews[i]);
			vo.setLocation_pk(Integer.parseInt(idx[i]));
			vo.setStar(Integer.parseInt(scores[i]));
			service.reviewing1(vo);
		}
		return "redirect:/myRecord/plan/reviewing.do";
	}
	
	@Transactional
	@PostMapping("reviewing2.do")
	public String savingReiews2(HttpServletRequest request, MyRecordPlanVO vo, HttpSession sess, @RequestParam("file") List<MultipartFile> files) {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String ppk = request.getParameter("plan_pk");
		int plan_pk = Integer.parseInt(ppk);
		vo.setPlan_pk(plan_pk);
		vo.setTitle(title);
		vo.setContent(contents);
		vo.setState(0);
		service.setReviewed2(plan_pk);
		service.savingReviews(vo);
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
				System.out.println("파일이 저장되었습니다: "+ dest.getAbsolutePath());
				vo.setFilename_org(originalFilename);
				vo.setFilename_save(uniqueFilename);
				vo.setFilesize(dest.length());
				
				if(fr == randn)
					vo.setFilestate(1);
				else
					vo.setFilestate(0);
				service.savingReview_image(vo);
				
			}catch(IOException e){
				e.printStackTrace();
			}finally {
				System.out.println(fr);
				fr++;
			}
		}
		
		return "redirect:/myRecord/plan/reviewing.do";
	}
	
	@GetMapping("viewingOLR.do")
	public String viewingOLR(@RequestParam("plan_pk")String plan_pk, Model model) {
		int x = Integer.parseInt(plan_pk);
		model.addAttribute("result",service.viewingOLR(x));
		model.addAttribute("flag","jv");
		return "/myRecord/plan/review_comment_write";
	}
	
	@GetMapping("viewingTR.do")
	public String viewingTR(@RequestParam("plan_pk")String plan_pk, Model model, HttpServletRequest request) {
		
		return "/review/edit.do?review_pk=${review_pk}";
	}
}