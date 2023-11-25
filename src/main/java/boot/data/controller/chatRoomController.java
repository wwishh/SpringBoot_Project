package boot.data.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.ChatDto;
import boot.data.Dto.ChatRoomDto;
import boot.data.service.ChatRoomService;
import boot.data.service.ChatService;
import boot.data.service.SangpumService;
import boot.data.service.UserService;

@Controller
public class chatRoomController {
	
	@Autowired 
	ChatRoomService service;
	
	@Autowired
	SangpumService sangService;
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	UserService userService;
	
	@PostMapping("/creatRoom")
	@ResponseBody
	public int createRoom(@RequestParam int sangidx,HttpSession session, Model model) {
		
		/*
		 * String buyer_id = (String)session.getAttribute("loginid"); String seller_id =
		 * sangService.getSangpumById(sangidx).getMember_name();
		 */
		String buyer_id=(String)session.getAttribute("loginid");
		String seller_id="김영준";
		
		ChatRoomDto room = new ChatRoomDto();
		room.setJ_sangid(sangidx);
		room.setBuyer_id(buyer_id);
		room.setSeller_id(seller_id);
		
		//System.out.println(service.findRoomByInfo(room) == null?"-1":service.findRoomByInfo(room));
		
		//판매자와 구매자가 같다면
		if(buyer_id==seller_id) {
			return 0;//본인임
		}else if(service.findRoomByInfo(room)!=null) {//기존에 만들어진 채팅방이라면 기존방으로 이동
			int room_id = Integer.parseInt(service.findRoomByInfo(room));
			return room_id;
		}else {
		 	service.insertChatRoom(room);//새로운 채팅방을 개설
		 	return service.maxNumByRoom();
		}

	}
	
	@GetMapping("/moveChating")
	public ModelAndView chating(@RequestParam int room_id, HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		int sangIdx = service.getChatRoomById(room_id).getJ_sangid();
		String roomName = sangService.getSangpumById(sangIdx).getJ_title();
		ChatRoomDto room = new ChatRoomDto();
		room = service.getChatRoomById(room_id);
		mv.addObject("room_id", room.getRoom_id());
		mv.addObject("seller_id", room.getSeller_id());
		mv.addObject("buyer_id", room.getBuyer_id());
		mv.addObject("roomName", roomName);
		mv.addObject("loginid", (String)session.getAttribute("loginid"));
		mv.setViewName("/chat");
		
		return mv;
	}
	
	@GetMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/2/jsp/chat");
		return mv;
	}
	
	
	@GetMapping("/getChatting")
	@ResponseBody
	public List<ChatDto> getChatting(@RequestParam int room_id) {
		
		System.out.println(room_id);
		
		List<ChatDto> chatlist = chatService.getChatListByRoomID(room_id);
		
		return chatlist;
	}
	

}
