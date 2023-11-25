package boot.data.mapper;

import org.apache.ibatis.annotations.Mapper;
import boot.data.Dto.SangpumDto;

@Mapper
public interface SangpumMapperInter {
	
	public SangpumDto getSangpumById(int sangIdx);
}
