package boot.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boot.data.Dto.UserDto;
import boot.data.mapper.UserMapperInter;
@Service
public class UserService implements UserServiceInter {

	@Autowired
	UserMapperInter mapperInter;

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return mapperInter.getTotalCount();
	}

	@Override
	public int loginIdPassCheck(String user_id, String user_pass) {
		Map<String, String> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("user_pass", user_pass);
		return mapperInter.loginIdPassCheck(map);
	}

	// 예지
	@Override
	public UserDto getUserById(String user_id) {
		// TODO Auto-generated method stub
		return mapperInter.getUserById(user_id);
	}

	@Override
	public UserDto getUserByNum(String user_num) {
		// TODO Auto-generated method stub
		return mapperInter.getUserByNum(user_num);
	}

	// 우형 시작
	@Override
	public void updateCover(String user_num, String user_cover) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<>();
		map.put("user_num", user_num);
		map.put("user_cover", user_cover);

		mapperInter.updateCover(map);

	}

	@Override
	public List<UserDto> getAllUsers() {
		// TODO Auto-generated method stub
		return mapperInter.getAllUsers();

	}

	@Override
	public void updatePhoto(String user_num, String user_photo) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<>();
		map.put("user_num", user_num);
		map.put("user_photo", user_photo);

		mapperInter.updatePhoto(map);

	}

	@Override
	public void updateUserInfo(UserDto dto) {
		// TODO Auto-generated method stub
		mapperInter.updateUserInfo(dto);
	}



	
	@Override
	public void deleteGuestBook(String guest_num) {
		// TODO Auto-generated method stub
		mapperInter.deleteGuestBook(guest_num);
	}
	
	//우형 끝	

	//희수 시작

	@Override
	public void insertOauthUserInfo(UserDto dto) {
		//oauth 회원가입은 이메일인증을 하지 않는다.
		mapperInter.insertOauthUserInfo(dto);
	}

	@Override
	public UserDto getUserDtoById(String user_id) {
		return mapperInter.getUserDtoById(user_id);
	}

	@Override
	public int loginEmailCheck(String user_email) {
		return mapperInter.loginEmailCheck(user_email);
	}

	@Override
	public void updatePassword(String user_num, String user_pass) {
		Map<String, String> map = new HashMap<>();
        map.put("user_pass", user_pass);
        map.put("user_num", user_num);
		mapperInter.updatePassword(map);
	}

	@Override
	public String getTempPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
        String str = "";

        // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        return str;
	}


	@Override
	public String getUserIdByEmail(String user_email) {
		return mapperInter.getUserIdByEmail(user_email);
	}

	@Override
	public String getUserEmailBynamehp(String user_name, String user_hp) {
		Map<String, String> map = new HashMap<>();
		map.put("user_name", user_name);
		map.put("user_hp", user_hp);
		return mapperInter.getUserEmailBynamehp(map);
	}

	@Override
	public int loginIdCheck(String user_id) {
		return mapperInter.loginIdCheck(user_id);
	}

	@Override
	public void userDelete(String user_num) {
		mapperInter.userDelete(user_num);
	}

	@Override
	public int updateMailKey(UserDto dto) throws Exception {
		return mapperInter.updateMailKey(dto);
	}

	@Override
	public int updateMailAuth(UserDto dto) throws Exception {
		return mapperInter.updateMailAuth(dto);
	}

	@Override
	public int emailAuthFail(String user_num) throws Exception {
		return mapperInter.emailAuthFail(user_num);
	}

	@Override
	public void updateUserPass(UserDto dto) {
		mapperInter.updateUserPass(dto);
	}

	@Override
	public void updateMailAuthByOauthLogin(String user_num) {
		mapperInter.updateMailAuthByOauthLogin(user_num);
	}
	// 희수 끝

	//예지
	@Override
	public List<UserDto> getUserByName(String user_name) {
		// TODO Auto-generated method stub
		return mapperInter.getUserByName(user_name);
	}

	@Override
	public void insertUserInfo(UserDto dto) throws Exception {
		// TODO Auto-generated method stub
		mapperInter.insertUserInfo(dto);
		
	}



}
