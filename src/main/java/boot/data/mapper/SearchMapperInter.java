package boot.data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchMapperInter {

	//관련검색어 기능
	public List<String> sangSearch(String search);
	
	//최근 검색 기능
	public List<String> searchSave(String s_id);
}
