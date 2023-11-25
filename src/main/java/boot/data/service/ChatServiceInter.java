package boot.data.service;

import java.util.List;

import boot.data.Dto.ChatDto;

public interface ChatServiceInter {
	
	public int ckChatRoom(ChatDto dto);
	
	public void insertChat(ChatDto dto);
	
	public List<ChatDto> getChatListByRoomID(int room_id);

}
