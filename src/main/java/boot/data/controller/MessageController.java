package boot.data.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TimeZone;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.MessageDto;
import boot.data.Dto.MessageRoomDto;
import boot.data.Dto.SangpumDto;
import boot.data.service.MessageRoomService;
import boot.data.service.MessageService;
import boot.data.service.SangpumService;
import boot.data.service.UserService;

@Controller
public class MessageController {
	
	@Autowired
	MessageService mservice;
	
	@Autowired
	UserService uservice;
	
	@Autowired
	MessageRoomService roomservice;
	
	@Autowired
	SangpumService sangservice;
	
	
	/*@GetMapping("/goChattingRoom")
	public String goChattingRoom(@RequestParam int room_num,Model model) {
		
		String roomname = sangservice.getSangpumById(roomservice.getRoomById(room_num).getJ_sangid()).getJ_title();
		
		model.addAttribute("room_num", room_num);
		model.addAttribute("roomName", roomname);
		return "/2/jsp/chat";
	}*/
	
	@GetMapping("/goChattingRoom")
	public String goChattingRoom(@RequestParam int room_num,
								@RequestParam int sangidx,
								Model model) {
		
		//판매자가 상품 디테일 페이지에서 채팅을 눌렀을 경우, 해당 상품에 관한 모든 채팅방을 가져온다.
		if(room_num==0) {
			List<MessageRoomDto> rooms = roomservice.getRoomsBySangpum(sangidx);
			
			for(MessageRoomDto dto:rooms) {
				//채팅방에서 마지막 메시지를 얻고
				int recentMessNum = mservice.getRecentMessageByRoom(dto.getRoom_num());
				
				if(recentMessNum==0) {//방은 있지만 아직 채팅을 나눈적 없음
					dto.setRecent_mess("");
				}else {
					//얻은 메시지를 해당 룸의 마지막 메시지로 설정
					dto.setRecent_mess(mservice.getMessageByNum(recentMessNum).getMess_content());
				}
				
			}
			
			model.addAttribute("rooms", rooms);
		}else if(room_num==-1&& sangidx==-1) {//종모양 클릭시
			return "/2/jsp/chatdesign";
		}
		
		SangpumDto sangdto= sangservice.getSangpumById(sangidx);
		
		model.addAttribute("room_num", room_num);
		model.addAttribute("sangdto", sangdto);
		return "/2/jsp/chatdesign";
	}
	
	@GetMapping("/goSellerRooms")
	public String goSellerRooms(@RequestParam int sangidx, Model model) {
		List<MessageRoomDto> rooms = roomservice.getRoomsBySangpum(sangidx);
		String sangname=sangservice.getSangpumById(sangidx).getJ_title();
		
		model.addAttribute("rooms", rooms);
		model.addAttribute("sangname", sangname);
		
		return "/2/jsp/room";
	}
	
	
	//종모양 클릭시 자신이 채팅했던 모든 방 나옴
	@GetMapping("/message/getMessageList")
	@ResponseBody
	public List<MessageRoomDto> getMessageList(@RequestParam String user_id){
		
		//ModelAndView mv = new ModelAndView();
		
		List<MessageRoomDto> rooms = roomservice.selectAllRooms(user_id);
		
		System.out.println(rooms.get(0).getRoom_num());
		
		for(MessageRoomDto dto:rooms) {
			//채팅방에서 마지막 메시지를 얻고
			int recentMessNum = mservice.getRecentMessageByRoom(dto.getRoom_num());
			//상품들의 이미지 가져오기
			String sangpumimgs = sangservice.getSangpumById(dto.getJ_sangid()).getJ_imageurl();
			StringTokenizer st = new StringTokenizer(sangpumimgs,",");
			String photo = st.nextToken();
			
			if(recentMessNum==0) {//방은 있지만 아직 채팅을 나눈적 없음
				dto.setRecent_mess("");
			}else {
				//얻은 메시지를 해당 룸의 마지막 메시지로 설정
				dto.setRecent_mess(mservice.getMessageByNum(recentMessNum).getMess_content());
				dto.setSang_img(photo);
			}
			
		}
		
		//mv.addObject("rooms", rooms);
		//mv.setViewName("/2/jsp/chatdesign");
		return rooms;
	}
	
	
	@GetMapping("/message/chatting")
	@ResponseBody
	public List<MessageDto> chatting(@RequestParam(required = false) int room_num, HttpSession session){
		
		try {
			Thread.sleep(100); //0.1초 기다리기
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//사용자의 num 받기
		String myid=(String)session.getAttribute("myid");
						
		List<MessageDto> chat=new ArrayList<>();
		
		chat = mservice.selectAllChatByRoom(room_num);
		//Collections.reverse(chat);//역정렬
		
		//채팅 시간 
		//대화 시간 오늘 날짜에서 빼기(몇 초전... 몇 분 전...)
		for(MessageDto dto:chat) {
			Date today=new Date();
			/* System.out.println(today); */
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
			Date writeday=new Date();
			try {
				writeday=sdf.parse(dto.getMess_writeday().toString());
				/* System.out.println(writeday); */
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			long diffSec=(today.getTime()-writeday.getTime());
			diffSec-=32400000L; //DB에 now()로 들어가는 시간이 9시간 차이 나서 빼줌
			/*System.out.println(diffSec); */

			//일시분초
			long day=(diffSec/(60*60*24*1000L))%365;
			long hour=(diffSec/(60*60*1000L))%24;
			long minute=(diffSec/(60*1000L))%60;
			long second=(diffSec/1000L)%60;

			String preTime="";

			if(day!=0) {
				//하루 이상이 지났으면 일수만 표시
				preTime=""+day+"일 전";
			}else {
				if(hour!=0) {
					//1시간 이상이 지났으면 시(hour)만 표시
					preTime=""+hour+"시간 전";
				}else {
					if(minute!=0) {
						//1분 이상이 지났으면 분만 표시
						preTime=""+minute+"분 전";
					}else {
						//1분 미만 초만 표시
						preTime="방금전";
					}
				}
			}

			dto.setMess_time(preTime);; //시간 다시 넣어주기
		}
		////////////
		
		return chat;
		
	}
	
	@PostMapping("/message/fileupload")
	@ResponseBody
	public Map<String,String> fileuUpload(@RequestParam MultipartFile upload,HttpSession session)
	{
		Map<String, String> map=new HashMap<>();
		
		//저장경로
		String path=session.getServletContext().getRealPath("/messagephoto");
		//파일 이름
		String fileName=upload.getOriginalFilename();
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
		
		String uploadName="msg_"+sdf.format(new Date())+fileName; //저장할 파일명
		
		//저장
		try {
			upload.transferTo(new File(path+"\\"+uploadName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		map.put("upload", uploadName);
		
		return map;
	}
	
	

}
