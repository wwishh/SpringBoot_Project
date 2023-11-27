package boot.data.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.SangpumDto;
import boot.data.service.SangpumService;
import boot.data.mapper.SangpumMapperInter;

@Controller
public class SangpumController {
	
	@Autowired
	SangpumMapperInter inter;
	
	@Autowired
	SangpumService service;
	
	@GetMapping("/form")
	public String insert() {
		return"/2/sangpum/s_insert";
	}
	
	@GetMapping("/sangpum/detail")
	public ModelAndView detail(int num) {
		ModelAndView model = new ModelAndView();
		
		inter.updateReadCount(num);
		
		SangpumDto dto = inter.getSangpum(num);
		
		model.addObject("dto",dto);
		
		model.setViewName("/2/detail/detail");
		
		return model;
	}
	
	@GetMapping("/sangpum/plusInterest")
	@ResponseBody
	public Map<String, Integer> plusInterest(int num) {
		Map<String, Integer> map = new HashMap<>();
		
		inter.plusInterest(num);
		
		int pInterst = inter.getSangpum(num).getJ_interest();
		
		map.put("pInterest", pInterst);
		
		return map;
	}
	
	@GetMapping("/sangpum/minusInterest")
	@ResponseBody
	public Map<String, Integer> minusInterest(int num) {
		Map<String, Integer> map = new HashMap<>();
		
		inter.minusInterest(num);
		
		int mInterst = inter.getSangpum(num).getJ_interest();
		
		map.put("mInterest", mInterst);
		
		return map;
	}
	
	@GetMapping("/list")
	public ModelAndView allSangpum(@RequestParam(defaultValue = "1") int currentPage, @RequestParam(value = "option", required = false) String option, @RequestParam(value = "search", required = false) String search, @ModelAttribute SangpumDto dto) {
		ModelAndView model = new ModelAndView();
		
		int totalCount;
		int totalPage; // 총 페이지수
		int startPage; // 각블럭에서 보여질 시작페이지
		int endPage; // 각블럭에서 보여질 끝페이지
		int startNum; // db에서 가져올 글의 시작번호(mysql은 첫글이 0,오라클은 1)
		int perPage = 8; // 한페이지당 보여질 글의 갯수
		int perBlock = 5; // 한블럭당 보여질 페이지 개수
		
		startNum = (currentPage - 1) * perPage;
		List<SangpumDto> list = service.getPagingList(option, search, startNum, perPage);
		totalCount = list.size();
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		
		if (endPage > totalPage)
			endPage = totalPage;
		
		startNum = (currentPage - 1) * perPage;
		
		int no = totalCount - (currentPage - 1) * perPage;
		
		
		model.addObject("list", list);
		model.addObject("totalCount", totalCount);
		model.addObject("startPage", startPage);
		model.addObject("endPage", endPage);
		model.addObject("no", no);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("/2/sangpum/s_list");
		return model;
	}
}
