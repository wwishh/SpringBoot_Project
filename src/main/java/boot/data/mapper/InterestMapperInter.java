package boot.data.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterestMapperInter {
	public void insertInterest(String i_id, int i_sangpum);
	public void deleteInterest(String i_id, int i_sangpum);
	//public int getCount(String i_id, int i_sangpum);
    //public Map<String, Object> getAllLikeStatus(String i_id, ArrayList<Integer> i_sangList);

}
