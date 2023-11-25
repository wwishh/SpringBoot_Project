package boot.data.service;

import java.util.List;

import boot.data.Dto.MessageDto;

public interface MessageServiceInter {
	
	public List<MessageDto> selectAllChatByRoom(int room_num);
	public void insertMessage(MessageDto dto);
	public void deleteMessage(String mess_num);
	public int selectMaxNum();
	public void deleteMessageByRoom(int room_num);

}
