package boot.data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boot.data.Dto.SangpumDto;

@Mapper
public interface PurchaseMapperInter {
	public void insertPurchase(String u_id, int j_sangid, String p_method);
	public int countpurchase(String u_id);
	
	//구매한 상품 출력
	public List<SangpumDto> selectbuysangpum(String u_id);
	public String selectpurchase(String u_id);
}
