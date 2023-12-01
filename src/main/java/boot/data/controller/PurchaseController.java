package boot.data.controller;

import java.sql.Timestamp;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import boot.data.Dto.PurchaseDto;
import boot.data.Dto.SangpumDto;
import boot.data.mapper.PurchaseMapperInter;

@Controller
public class PurchaseController {
	
	@Autowired
	PurchaseMapperInter inter;
	
	@PostMapping("/purchase/insert")
	@ResponseBody
	public String insert(String u_id, int j_sangid, String p_method) {
		inter.insertPurchase(u_id, j_sangid, p_method);
		
		return "insert";
	}
	
	//구매내역 리스트
		@GetMapping("/sangpum/buysangpum")
		public ModelAndView buysangpum(String u_id) {
			ModelAndView model = new ModelAndView();
			
		 	List<SangpumDto> list = inter.selectbuysangpum(u_id);
		 	int count = inter.countpurchase(u_id);
		 	String buydate = inter.selectpurchase(u_id);
		 	StringTokenizer st = new StringTokenizer(buydate," ");
		 	buydate = st.nextToken();
		 	
		 	for(SangpumDto dto : list) {
		 		st = new StringTokenizer(dto.getJ_imageurl(),",");
		 		String photo = st.nextToken();
		 		//System.out.println(photo);
		 		
		 		dto.setBuydate(buydate);
		 		dto.setSangimg(photo);
		 	}
		 	
		 	model.addObject("count", count);
		 	model.addObject("list", list);
		 	model.setViewName("/2/mypage/buysangpum");
			
			return model;
		}
		
}
