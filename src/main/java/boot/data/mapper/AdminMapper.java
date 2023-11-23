package boot.data.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	
	public String getAdminID(String a_id);
	public int adminLoginPassCheck(Map<String, String>map);
	
}
