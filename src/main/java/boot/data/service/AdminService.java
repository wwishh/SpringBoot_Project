package boot.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.AdminLoginDto;
import boot.data.Dto.NoticeDto;
import boot.data.mapper.AdminMapper;

@Service
public class AdminService implements AdminServiceInter {
	@Autowired
	AdminMapper mapperInter;

	@Override
	public AdminLoginDto getAdminID(String a_id) {
		// TODO Auto-generated method stub
		return mapperInter.getAdminID(a_id);
	}

	@Override
	public int adminLoginPassCheck(String a_id, String a_pass) {
		// TODO Auto-generated method stub
		Map<String, String>map=new HashMap<>();
		map.put("a_id", a_id);
		map.put("a_pass", a_pass);
		return mapperInter.adminLoginPassCheck(map);
	}

	@Override
	public void insertNotice(NoticeDto n_dto) {
		// TODO Auto-generated method stub
		mapperInter.insertNotice(n_dto);
	}

	@Override
	public List<NoticeDto> getAllNotice() {
		// TODO Auto-generated method stub
		return mapperInter.getAllNotice();
	}
	
	
}
