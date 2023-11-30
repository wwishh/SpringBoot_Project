package boot.data.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.NoticeDto;

@Mapper
public interface AdminMapper {
	
	public AdminLoginDto getAdminID(String a_id);
	public int adminLoginPassCheck(Map<String, String>map);
	public void insertNotice(NoticeDto n_dto);
	public List<NoticeDto> getAllNotice();
}
