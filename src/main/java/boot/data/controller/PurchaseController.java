package boot.data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
