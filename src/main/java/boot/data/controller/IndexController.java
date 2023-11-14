package boot.data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
	
	@GetMapping("/")
	public String index() {
		return "/layout/main";
	}
	
	@GetMapping("/index2")
	public String index2() {
		return "/category/layout/main";
	}
	
	@GetMapping("/index3")
	public String index3() {
		return "/detail/layout/main";
	}
	
	@GetMapping("/loginform")
	public String loginform() {
		return "/index/login/main";
	}
	
}
