package boot.data.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.MessageRoomDto;
import boot.data.service.MessageRoomService;
import boot.data.service.SangpumService;
import boot.data.service.UserService;

@Controller
public class IndexController {
	
	@Autowired
	UserService uservice;
	
	@Autowired
	SangpumService sangservice;
	
	@Autowired
	MessageRoomService roomservice;
	
	@GetMapping("/")
	public String index(HttpSession session) {
		session.setAttribute("myid", "test2");
		return "/1/layout/main";
	}
	
	@GetMapping("/detail")
	public String index2() {
		return"/2/detail/detail";
	}
	
	@GetMapping("/search")
	public String index3() {
		return"/3/search2/search2";
	}
	
	@GetMapping("/admin")
	public String adminIndex() {
		return"/admin/layout-admin/admin_main";
	}
	
	/*
	 * @GetMapping("/index2") public String index2() { return "/layout2/category"; }
	 * 
	 * @GetMapping("/index3") public String index3() { return "/layout/detail"; }
	 * 
	 * @GetMapping("/loginform") public String loginform() { return
	 * "/index/login/main"; }
	 */
	
	
	@GetMapping("/insert")
	public String insert() {
		return"/2/Product/P_insert";
	}
	
	@PostMapping("/createRoom")
	@ResponseBody
	public int createRoom(@RequestParam int sangidx, HttpSession session){
		
		String sender_id= (String)session.getAttribute("myid");
		//중고상품판매자의 user_num을 찾을 수 있도록 수정해야 됨
		String seller_id = "test2";
		
		//현재 채팅을 보내려는 사용자가 판매자이면 방을 생성할 수 없음
		if(sender_id.equals(seller_id)) {
			return 0;
		}else {
			//기존에 존재하는 채팅방이라면 그곳으로 이동
			String room = roomservice.getRoomBySangIdxAndUserId(sangidx, sender_id);
			System.out.println(room);
			
			if(room!=null) {
				return Integer.parseInt(room);
			}else {//없다면 새로 방 생성후 생성된 방으로 이동
				
				MessageRoomDto newroom = new MessageRoomDto();
				newroom.setJ_sangid(sangidx);
				newroom.setSender_id(sender_id);
				newroom.setReceiver_id(seller_id);
				roomservice.insertRoom(newroom);
				return roomservice.getMaxRoom();
				
			}
			
		}
		
		
	}
}
