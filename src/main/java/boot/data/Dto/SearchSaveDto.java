package boot.data.Dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("searchdto")
public class SearchSaveDto {
	
	private int num;
	private String s_id;
	private String s_searchword;
}
