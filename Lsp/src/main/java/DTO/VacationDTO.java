package DTO;

public class VacationDTO {
	private String m_num;
	private int leavetype;
	private String leave_start;
	private String leave_end;
	private String reason;
	private String bancha_time;
	public String getM_num() {
		return m_num;
	}
	public void setM_num(String m_num) {
		this.m_num = m_num;
	}
	public int getLeavetype() {
		return leavetype;
	}
	public void setLeavetype(int leavetype) {
		this.leavetype = leavetype;
	}
	public String getLeave_start() {
		return leave_start;
	}
	public void setLeave_start(String leave_start) {
		this.leave_start = leave_start;
	}
	public String getLeave_end() {
		return leave_end;
	}
	public void setLeave_end(String leave_end) {
		this.leave_end = leave_end;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getBancha_time() {
		return bancha_time;
	}
	public void setBancha_time(String bancha_time) {
		this.bancha_time = bancha_time;
	}
	
	
}
