package boot.data.controller;

<<<<<<< HEAD
=======

>>>>>>> master
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

<<<<<<< HEAD
import boot.data.Dto.InterestDto;
=======
>>>>>>> master
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
	
	@GetMapping("/interest/count")
	@ResponseBody
	public int count(String i_id, int i_sangpum) {
		return inter.getCount(i_id, i_sangpum);
	}
	
	

}
