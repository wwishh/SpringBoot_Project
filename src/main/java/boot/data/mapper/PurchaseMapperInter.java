package boot.data.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapperInter {
	public void insertPurchase(String u_id, int j_sangid, String p_method);
	public int countpurchase(String u_id);
}
