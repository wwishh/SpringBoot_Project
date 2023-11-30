package boot.data.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.NoticeDto;
import boot.data.service.AdminService;

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

	@GetMapping("/information")
	public String information() {
		return "/admin/admin/member_information/listForm";
	}
	
	
	
}
