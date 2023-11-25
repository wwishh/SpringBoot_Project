package boot.data.service;

import boot.data.Dto.ChatRoomDto;

public interface ChatRoomServiceInter {
	
	public void insertChatRoom(ChatRoomDto dto);
	//상품idx, seller, buyer로 구성된 채팅룸이 있다면 반환
	public String findRoomByInfo(ChatRoomDto dto);
	public ChatRoomDto getAllChatRoom();
	public ChatRoomDto getChatRoomById(int room_id);
	public ChatRoomDto getChatRoomBySangID(int sang_id);
	public int maxNumByRoom();

}
