package boot.data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SangpumController {
	
	@GetMapping("/form")
	public String insert() {
		return"/2/sangpum/s_insert";
	}
}
