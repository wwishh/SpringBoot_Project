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

import boot.data.Dto.MessageDto;
import boot.data.Dto.MessageRoomDto;
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
	
	
	@GetMapping("/goChattingRoom")
	public String goChattingRoom(@RequestParam int room_num,Model model) {
		
		String roomname = sangservice.getSangpumById(roomservice.getRoomById(room_num).getJ_sangid()).getJ_title();
		
		model.addAttribute("room_num", room_num);
		model.addAttribute("roomName", roomname);
		return "/2/jsp/chat";
	}
	
	@GetMapping("/goSellerRooms")
	public String goSellerRooms(@RequestParam int sangidx, Model model) {
		List<MessageRoomDto> rooms = roomservice.getRoomsBySangpum(sangidx);
		String sangname=sangservice.getSangpumById(sangidx).getJ_title();
		
		model.addAttribute("rooms", rooms);
		model.addAttribute("sangname", sangname);
		
		return "/2/jsp/room";
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
