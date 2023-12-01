package boot.data.service;

import java.util.List;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.NoticeDto;

public interface AdminServiceInter {
	public AdminLoginDto getAdminID(String a_id);
	public int adminLoginPassCheck(String id,String pass);
	public void insertNotice(NoticeDto n_dto);
	public List<NoticeDto> getAllNotice();
	public NoticeDto getNoticeNum(int n_num);
	public void deleteNotice(int n_num);
	public void updateNotice(NoticeDto dto);
}
