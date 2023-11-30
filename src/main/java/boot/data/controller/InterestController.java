package boot.data.controller;

import java.util.ArrayList;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import boot.data.mapper.InterestMapperInter;

@Controller
public class InterestController {
	
	@Autowired
	InterestMapperInter inter;
	
	@GetMapping("/interest/insert")
	@ResponseBody
	public String insert(String i_id, int i_sangpum) {
		
		inter.insertInterest(i_id, i_sangpum);
		
		return "insert";
	}
	
	@GetMapping("/interest/delete")
	@ResponseBody
	public String delete(String i_id, int i_sangpum) {
		inter.deleteInterest(i_id, i_sangpum);
		return "delete";
	}
	
	
	/*
	 * @GetMapping("/interest/getAllLikeStatus")
	 * 
	 * @ResponseBody public Map<String, Object> getAllLikeStatus(@RequestParam
	 * String i_id, @RequestParam(value="i_sangpumList[]") ArrayList<Integer>
	 * i_sangpumList) { // i_id와 i_sangpumList를 이용하여 쿼리 실행 및 결과 반환
	 * 
	 * 
	 * return inter.getAllLikeStatus(i_id, i_sangpumList); }
	 */
}
