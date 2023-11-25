package boot.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.MessageRoomDto;
import boot.data.mapper.MessageRoomMapperInter;

@Service
public class MessageRoomService implements MessageRoomServiceInter {
	
	@Autowired
	MessageRoomMapperInter mapper;

	@Override
	public void insertRoom(MessageRoomDto dto) {
		// TODO Auto-generated method stub
		mapper.insertRoom(dto);
	}

	@Override
	public List<MessageRoomDto> getRoomsByUser(int user_num) {
		// TODO Auto-generated method stub
		return mapper.getRoomsByUser(user_num);
	}

	@Override
	public int getRoomBySangIdxAndUserId(int j_sangid, int user_num) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("j_sangid", j_sangid);
		map.put("user_num", user_num);
		return mapper.getRoomBySangIdxAndUserId(map);
	}

}
