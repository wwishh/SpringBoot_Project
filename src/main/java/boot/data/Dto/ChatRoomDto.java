package boot.data.Dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("chatRoom")
public class ChatRoomDto {
	
	private int room_id;
	private int j_sangid;//상품 index번호
	private String seller_id;
	private String buyer_id;
	private Timestamp roomday;

}
