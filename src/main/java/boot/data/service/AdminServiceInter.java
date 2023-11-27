package boot.data.service;

public interface AdminServiceInter {
	public String getAdminID(String a_id);
	public int adminLoginPassCheck(String id,String pass);
}
