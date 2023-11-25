package boot.data.Dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("room")
public class MessageRoomDto {
	
	private int room_num;
	private int j_sangid;
	private int sender_num;
	private int receiver_num;
	private Timestamp room_createday;

}
