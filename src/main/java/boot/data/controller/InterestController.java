package boot.data.controller;


import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.SangpumDto;
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
	
	@GetMapping("/interest/likesangpum")
	public ModelAndView likesangpum(String u_id) {
		ModelAndView model = new ModelAndView();
		
	 	List<SangpumDto> list = inter.selectlikesangpum(u_id);

	 	for(SangpumDto dto : list) {
	 		StringTokenizer st = new StringTokenizer(dto.getJ_imageurl(),",");
	 		String photo = st.nextToken();
	 		//System.out.println(photo);
	 		
	 		dto.setSangimg(photo);
	 	}
	 	//System.out.println(list);
	 	
	 	model.addObject("list", list);
	 	model.setViewName("/2/mypage/likesangpum");
		
		return model;
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
