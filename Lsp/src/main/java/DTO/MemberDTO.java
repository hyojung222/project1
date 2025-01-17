package DTO;

public class MemberDTO {
	private String m_num;
	private String name;
	private String pw;
	private int join_date;
	private String address;
	private String phone;
	public int getAnnual_number() {
		return annual_number;
	}
	public void setAnnual_number(int annual_number) {
		this.annual_number = annual_number;
	}
	private String email;
	private String photo;
	private int admin;
	private int annual_number;
	public String getM_num() {
		return m_num;
	}
	public void setM_num(String m_num) {
		this.m_num = m_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getJoin_date() {
		return join_date;
	}
	public void setJoin_date(int join_date) {
		this.join_date = join_date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	
	
	
}
