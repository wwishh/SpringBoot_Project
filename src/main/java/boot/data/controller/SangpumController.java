package boot.data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.SangpumDto;
import boot.data.mapper.SangpumMapperInter;

@Controller
public class SangpumController {
	
	@Autowired
	SangpumMapperInter inter;
	
	@GetMapping("/form")
	public String insert() {
		return"/2/sangpum/s_insert";
	}
	
	@GetMapping("/sangpum/detail")
	public ModelAndView detail(String num) {
		ModelAndView model = new ModelAndView();
		
		inter.updateReadCount(num);
		
		SangpumDto dto = inter.getSangpum(num);
		
		model.addObject("dto",dto);
		
		model.setViewName("/2/detail/detail");
		
		return model;
	}
	
}
