package boot.data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.SangpumDto;

@Mapper
public interface SearchMapperInter {

	//검색기능
	public List<String> sangSearch(String search);
	
	//검색리스트
	public List<SangpumDto> sangList(String search, String option);
	
	//검색한 상품 갯수
	public int getSangpumCount(String search);
}
