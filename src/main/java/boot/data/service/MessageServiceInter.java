package boot.data.service;

import java.util.List;
import java.util.Map;

import boot.data.Dto.MessageDto;

public interface MessageServiceInter {
	
	public List<MessageDto> selectAllChatByRoom(int room_num);
	public void insertMessage(MessageDto dto);
	public void deleteMessage(String mess_num);
	public int selectMaxNum();
	//public int getCountOfMessage(String user_num,String other);
	public void deleteMessageByRoom(int room_num);
	public int getRecentMessageByRoom(int room_num);
	public MessageDto getMessageByNum(int mess_num);
	
}
