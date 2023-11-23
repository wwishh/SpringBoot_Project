package boot.data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.SangpumDto;

@Mapper
public interface SearchMapperInter {

	//관련검색어 기능
	public List<String> sangSearch(String search);
	
	public List<SangpumDto> mainSangList(String search);
	
	//검색리스트
	public List<SangpumDto> sangList(String search, String option);
	
	//검색한 상품 갯수
	public int getSangpumCount(String search);
	//최근 검색 기능
	public List<String> searchSave(String s_id);
	
	//인기 검색어 기능(10개)
	public List<String> bestsearch();
}
