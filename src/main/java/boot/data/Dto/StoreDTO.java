package boot.data.Dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
public class StoreDTO {
	
	private String mem_id;
	private String store_nickname;
	private String store_img;
	private String store_intro;
	private int store_echo;
	private int store_scoreavg;


}
