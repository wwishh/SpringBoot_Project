package boot.data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.ChatRoomDto;
import boot.data.mapper.ChatRoomMapperInter;


@Service
public class ChatRoomService implements ChatRoomServiceInter {
	
	@Autowired
	ChatRoomMapperInter mapper;

	@Override
	public void insertChatRoom(ChatRoomDto dto) {
		// TODO Auto-generated method stub
		mapper.insertChatRoom(dto);
	}

	@Override
	public ChatRoomDto getAllChatRoom() {
		// TODO Auto-generated method stub
		return mapper.getAllChatRoom();
	}

	@Override
	public ChatRoomDto getChatRoomById(int room_id) {
		// TODO Auto-generated method stub
		return mapper.getChatRoomById(room_id);
	}

	@Override
	public int maxNumByRoom() {
		// TODO Auto-generated method stub
		return mapper.maxNumByRoom();
	}

	@Override
	public ChatRoomDto getChatRoomBySangID(int sang_id) {
		// TODO Auto-generated method stub
		return mapper.getChatRoomBySangID(sang_id);
	}

	//상품idx, seller, buyer로 구성된 채팅룸이 있다면 반환
	@Override
	public String findRoomByInfo(ChatRoomDto dto) {
		// TODO Auto-generated method stub
		return mapper.findRoomByInfo(dto);
	}

}
