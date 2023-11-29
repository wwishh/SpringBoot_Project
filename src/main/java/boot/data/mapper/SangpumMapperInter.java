package boot.data.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.SangpumDto;

@Mapper
public interface SangpumMapperInter {
	
	public SangpumDto getSangpumById(int sangIdx);
	public int getMaxNum();
	public int getMainCount();
	public int getTotalCount(Map<String, String> map);
	// public List<SangpumDto> mainPageList(SangpumDto dto);
	
	public List<SangpumDto> getPagingList(Map<String, Object> map);
	public void insertSangpum(SangpumDto dto);
	public SangpumDto getData(int num);
	public void updateSangpum(SangpumDto dto);
	public void deleteSangpum(int num);
	public void updateInterest(int num);
	public SangpumDto getSangpum(int num);
	public void updateReadCount(int num);	
	public void plusInterest(int num);
	public void minusInterest(int num);
	
	public int countIdOfsell(String u_id);
}
