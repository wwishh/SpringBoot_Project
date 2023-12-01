package boot.data.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.SessionScope;

import boot.data.Dto.LoginDto;
import boot.data.mapper.InterestMapperInter;
import boot.data.mapper.PurchaseMapperInter;
import boot.data.mapper.SangpumMapperInter;
import boot.data.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	SangpumMapperInter sanginter;
	
	@Autowired
	PurchaseMapperInter purchaseinter;
	
	@Autowired
	InterestMapperInter interstinter;
	
	@Autowired
	LoginService service;
	
	//로그인폼으로
	@GetMapping("/loginform")
	public String loginform()
	{
		return "/2/login/loginform";
	}
	//회원가입폼으로
	@GetMapping("/joinform")
	public String joinform()
	{
		return "/2/login/joinform";
	}
	
	//회원가입
	@PostMapping("/join")
	public String join(@ModelAttribute LoginDto login,
			HttpSession session,
			Model model)
	{
		model.addAttribute("login",login);
		service.insertMember(login);
		
		return "/2/login/gaipsuccess";
	}
	
		//로그인시 메인화면 이동
		@GetMapping("/main")
		public String loginform(HttpSession session, Model model)
		{	
			//폼의 아이디 얻기
			String u_id=(String)session.getAttribute("u_id");
			
			//로그인 상태인지 아닌지 체크
			String loginok = (String)session.getAttribute("loginok");
			
			//학번도 실행안하면 null
			if(loginok==null)
				return "/2/login/loginform";
			else {
				//로그인중이면 request에 name 저장
				String u_name = service.getName(u_id);
				model.addAttribute("u_name", u_name);
				
				return "/";
			}
			
			
		}
		
		@PostMapping("/login")
		public String loginproc(@RequestParam String u_id,
				@RequestParam String u_pass,
				HttpSession session)
		{
			HashMap<String, String> map = new HashMap<>();
			
			int check = service.loginPassCheck(u_id, u_pass);
			int failcheck = service.failcheck(u_id);
			
			if(check==1 && failcheck<5) {
				session.setMaxInactiveInterval(60*60*1); //1시간
				session.setAttribute("myid", u_id);
				session.setAttribute("loginok", "yes");
				
				LoginDto login = service.getDataById(u_id);
				session.setAttribute("myname", login.getU_name());
				session.setAttribute("myhp", login.getU_hp());
				session.setAttribute("myemail", login.getU_email());
				
				service.failreset(u_id);
				
				session.removeAttribute("findid");
				
				return "redirect:main";
			}else if(check==1 && failcheck>=5) {
				return "/3/login/failfive";
			}
			else {
				//실패시  session failcount 1씩증가 ;
				service.failcount(u_id);
				return "/3/login/passfail";
			}
		
		}
		
		@GetMapping("/logoutprocess")
		public String logout(HttpSession session)
		{
			session.removeAttribute("loginok");
			session.removeAttribute("myid");
			session.removeAttribute("myname");
			session.removeAttribute("myhp");
			session.removeAttribute("myemail");
			
			return "redirect:main";
		}
		@GetMapping("/idsearch")
		public String idsearch()
		{
			return "/2/login/findidform";
		}
		@GetMapping("/pwsearch")
		public String pwsearch()
		{
			return "/2/login/findpwform";
		}
		@PostMapping("/findid")
		public String findid(@RequestParam String u_name,
				@RequestParam String u_email,
				@RequestParam String u_hp,
				HttpSession session)
		{
			HashMap<String, String> map = new HashMap<>();
			int check = service.findIdCheck(u_name, u_email,u_hp); //u_name ,u_email,u_hp
			String findid= service.getId(u_name, u_email, u_hp);
			//System.out.println(check);
			//System.out.println(findid);
			if(check==1) {
				
				session.setAttribute("findid", findid);
				
				return "/2/login/findidsuccess";
			}else {
			return "/2/login/findidform";
			}
		}
	//마이페이지
	@GetMapping("/mypage")
	public ModelAndView mypage(String u_id) {
		ModelAndView model = new ModelAndView();
		
		LoginDto dto = service.getDataById(u_id);
		int likes = interstinter.countlikes(u_id);
		int purchase = purchaseinter.countpurchase(u_id);
		int sell = sanginter.countIdOfsell(u_id);
		
		model.addObject("sell", sell);
		model.addObject("purchase", purchase);
		model.addObject("likes", likes);
		model.addObject("dto", dto);
		model.setViewName("/2/login/mypage");
		
		return model;
	}
	
	//회원정보 데이터 가져오기
	@GetMapping("/updateform")
	public ModelAndView updateform(String u_id) {
		ModelAndView model = new ModelAndView();
		
		LoginDto dto = service.getDataById(u_id);
		
		model.addObject("dto", dto);
		model.setViewName("/2/login/updateform");
		
		return model;
	}
	
	//회원정보수정
	@PostMapping("/update")
	public String update(LoginDto login) {
		
		System.out.println(login);
		service.updateuserinfo(login);
		
		return "redirect:main";
	}
	
}
