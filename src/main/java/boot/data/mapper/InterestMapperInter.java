package boot.data.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterestMapperInter {
	public void insertInterest(String i_id, int i_sangpum);
	public void deleteInterest(String i_id, int i_sangpum);
	public int getCount(String i_id, int i_sangpum);

}
