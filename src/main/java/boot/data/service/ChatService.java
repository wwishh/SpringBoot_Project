package boot.data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.ChatDto;
import boot.data.mapper.ChatMapperInter;
@Service
public class ChatService implements ChatServiceInter {
	
	@Autowired
	ChatMapperInter mapper;

	@Override
	public int ckChatRoom(ChatDto dto) {
		
		return mapper.ckChatRoom(dto);
	}

	@Override
	public void insertChat(ChatDto dto) {
		// TODO Auto-generated method stub
		mapper.insertChat(dto);
	}

	@Override
	public List<ChatDto> getChatListByRoomID(int room_id) {
		// TODO Auto-generated method stub
		return mapper.getChatListByRoomID(room_id);
	}



}
