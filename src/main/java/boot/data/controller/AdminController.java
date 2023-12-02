package boot.data.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.LoginDto;
import boot.data.Dto.NoticeDto;
import boot.data.service.AdminService;
import boot.data.service.LoginService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService service;
	
	
	@GetMapping("/admin")
	public String adminIndex(HttpSession session) {
		//폼에 id 얻어줘야함
				String adminid=(String)session.getAttribute("a_id");
				//로그인인지 아닌지 판단
				String adminloginok=(String)session.getAttribute("a_loginok");
				
				 
				//한번도 실행안하면 null
				if(adminloginok==null) {
					return "/3/adminlogin/adminLoginForm";
				}
				
				return "/admin/layout-admin/admin_main/admin_main";
	}
	
	@PostMapping("/adminPage_action")
	public String loginproc(@RequestParam String a_id, @RequestParam String a_pass,@RequestParam(required = false) String savechk,HttpSession session) {
		HashMap<String, String>map=new HashMap<>();
		int check=service.adminLoginPassCheck(a_id, a_pass);
		if(check==1) {
			session.setMaxInactiveInterval(60*60*8);
			session.setAttribute("a_id", a_id);
			session.setAttribute("a_loginok", "ok");
			
			AdminLoginDto a_dto= service.getAdminID(a_id);
			session.setAttribute("a_email",a_dto.getA_email());
			session.setAttribute("a_right",a_dto.getA_right());
			session.setAttribute("a_hp", a_dto.getA_hp());
			session.setAttribute("a_name",a_dto.getA_name());
			
			return "/admin/layout-admin/admin_main/admin_main";
		}
		
		return "/3/adminlogin/passFail";
	}
	
	@GetMapping("/adminlogoutprocess")
	public String a_logout(HttpSession session) {
		session.removeAttribute("a_loginok");
		session.removeAttribute("a_id");
		session.removeAttribute("a_pass");
		session.removeAttribute("a_email");
		session.removeAttribute("a_right");
		session.removeAttribute("a_hp");
		session.removeAttribute("a_name");
		
		
		return "redirect:/";
	}
	
	
	@GetMapping("/notice")
	public String main(Model model) {
		List<NoticeDto>list=service.getAllNotice();
		model.addAttribute("list",list);
		
		
		return "/admin/admin/notice/notice_listForm";
	}
	
	@GetMapping("/n_addform")
	public String n_add() {
		return "/admin/admin/notice/notice_addForm";
	}
	
	@PostMapping("/a_notice_insert")
	public ModelAndView a_notice_add(@ModelAttribute NoticeDto n_dto) {
		ModelAndView model = new ModelAndView();
		service.insertNotice(n_dto);
		
		model.setViewName("redirect:notice");
		return model;
	}
	
	
	@ResponseBody
	@GetMapping("/a_notice_num")
	public Map<String, Object> a_notice_num(@RequestParam int num) {
		
		Map<String, Object>returnMap=new HashMap<>();
		NoticeDto n_dto = service.getNoticeNum(num);
		AdminLoginDto a_dto = service.getAdminID(n_dto.getN_id());
		
		returnMap.put("n_num", n_dto.getN_num());
		returnMap.put("n_email", a_dto.getA_email());
		returnMap.put("n_name", n_dto.getN_name());
		returnMap.put("n_title", n_dto.getN_title());
		returnMap.put("n_content", n_dto.getN_content());
		returnMap.put("n_registration_date", n_dto.getN_registration_date());
		returnMap.put("n_hits", n_dto.getN_hits());
		returnMap.put("n_id", n_dto.getN_id());
		
		return returnMap;
	}
	
	@PostMapping("a_notice_update")
	public ModelAndView a_notice_correction(@ModelAttribute NoticeDto n_dto) {
		ModelAndView model = new ModelAndView();
		service.updateNotice(n_dto);
		
		model.setViewName("redirect:notice");
		return model;
	}
	
	
	@GetMapping("/notice_delete")
	public String noticeDelete(@RequestParam int num) {
		
		service.deleteNotice(num);
		
		return "redirect:notice";
	}
	
	
	@GetMapping("/information")
	public ModelAndView information() {
		List<LoginDto> list = new ArrayList<>();
		ModelAndView model= new ModelAndView();
		 
		list= service.failuser();  //페일카운트 잇는 유저 전부호출
		
		 model.addObject("list",list);
	
		
		 model.setViewName("/admin/admin/member_information/listForm");
		 return model;
	}
	@GetMapping("/failreset")
	public String failreset(@RequestParam String u_id) {
		
		service.failreset(u_id); // 버튼누르면 페일카운트 10개인사람을 페일카운트0으로 초기화
		return "redirect:information";
	}
	
	
	
	
	
}
