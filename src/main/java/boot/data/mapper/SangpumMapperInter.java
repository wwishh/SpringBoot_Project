package boot.data.mapper;

import boot.data.Dto.SangpumDto;

public interface SangpumMapperInter {
	public SangpumDto getSangpum(String num);
	
	public void updateReadCount(String num);
}
