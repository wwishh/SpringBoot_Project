package boot.data.Dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("chat")
public class ChatDto {
	
	private int room_id;
	private int chat_id;
	private String receiver;//판매상품을 올려논 판매자의 id
	private String sender;//현재로그인 된 사용자(session으로 loginid 받아오기)
	private String content;
	private int status;
	private Timestamp writeday;

}
