package boot.data.service;

import java.util.List;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.LoginDto;
import boot.data.Dto.NoticeDto;
import boot.data.Dto.UserDto;

public interface AdminServiceInter {
	public AdminLoginDto getAdminID(String a_id);
	public int adminLoginPassCheck(String id,String pass);
	public void insertNotice(NoticeDto n_dto);
	public List<NoticeDto> getAllNotice();
	public List<NoticeDto> getAllNoticeList(int start,int perPage);
	public NoticeDto getNoticeNum(int n_num);
	public void deleteNotice(int n_num);
	public void updateNotice(NoticeDto dto);
	public void failreset(String u_id); //페일카운트0으로 초기화
	public List<LoginDto> failuser(); //페일카운트 10이상 유저리스트
	public List<UserDto> userList();
	public int getTotalNoticeCount();
}
