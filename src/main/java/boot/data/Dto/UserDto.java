package boot.data.Dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("user")
public class UserDto {
	
	private int user_id;
	private String user_name;
}
