package boot.data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.ChatDto;

@Mapper
public interface ChatMapperInter {
	
	public int ckChatRoom(ChatDto dto);
	
	public void insertChat(ChatDto dto);
	
	public List<ChatDto> getChatListByRoomID(int room_id);

}
