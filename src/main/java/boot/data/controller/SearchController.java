package boot.data.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.SangpumDto;
import boot.data.mapper.SearchMapperInter;

@Controller
public class SearchController {

	@Autowired
	SearchMapperInter inter;
	
	@GetMapping("/search/result")
	@ResponseBody
	public List<String> result(String search) {
		return inter.sangSearch(search);
	}
	
	//검색 결과 화면
	@GetMapping("/search/main")
	public ModelAndView searchMain(String search, String s_id) {
		
		List<SangpumDto> list = inter.mainSangList(search);
		int count = inter.countsearchword(s_id, search);
		
		System.out.println("검색어 개수: "+count+", 아이디 값: "+s_id);
		
		ModelAndView model = new ModelAndView();
		
		if (count < 1 && !s_id.equals("guest")) {
			inter.searchsaveinsert(s_id,search);
			
			model.addObject("search", search);
			model.addObject("list", list);
			model.setViewName("/2/search/searchList");
			
			return model;
		}
		else {
			model.addObject("search", search);
			model.addObject("list", list);
			model.setViewName("/2/search/searchList");
			
			return model;
		}
	}
	
	//검색 상품 리스트
	@GetMapping("/search/list")
	@ResponseBody
	public List<SangpumDto> searchList(String search, String option){
		//System.out.println(option);
		return inter.sangList(search, option);
	}
	
	@GetMapping("/search/sangpumCount")
	@ResponseBody
	public int searchSangpumCount(String search) {
		return inter.getSangpumCount(search);
	}
	
}
