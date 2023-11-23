package boot.data.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import boot.data.mapper.SearchMapperInter;

@Controller
public class IndexController {
	
	@Autowired
	SearchMapperInter inter;
	
	@GetMapping("/")
	public String index() {
		return "/1/layout/main";
	}
	
	/*
	 * @GetMapping("/detail") public String index2() { return"/2/detail/detail"; }
	 */
	
	@GetMapping("/search")
	public ModelAndView index3(@RequestParam String s_id) {
		
		ModelAndView model=new ModelAndView();
		
		List<String> list=inter.searchSave(s_id);
		List<String> title=inter.bestsearch();
		
		model.addObject("list", list);
		model.addObject("title", title);
		model.setViewName("/3/search2/search2");
		
		return model;
	}
	
	@PostMapping("/adminPage")
	public String adminIndex() {
		return"/admin/layout-admin/admin_main/admin_main";
	}
	
	
	
}
