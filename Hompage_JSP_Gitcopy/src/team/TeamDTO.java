package team;

public class TeamDTO { //데이터를 가지고 다니는 객체 1폼에서 입력받는다 2데이터베이서에서 데이터를 저장한다
	private int no;
	private String name;
	private String gender;
	private String phone ;
	private String zipcode;
	private String address1	;
	private String address2	;
	private String[] skill; //createForm에서 입력받은 데이터를 받는다.
	private String skillstr; //DB에서 select한 결과를 저장하는 역할, DB에 skill배열을 문자열로 변환하여 저장한다.(insert,update)
	private String hobby;
	private String filename;
	
	public String getSkillstr() { //DB에 insert, update할 때 호출된다, DB에서 select한 결과를 jsp페이지에 출력받을떄 호출
		if(skill != null){// DB에 insert, update할 때 처리를 위한 코드
		 String skillstr = "";
		   for(int i=0; i<skill.length; i++){
			   skillstr += skill[i];
			   if(i<skill.length-1){
			   skillstr += ",";
		   }
		}
		this.skillstr = skillstr;   
	}	
		return skillstr;
	}
	public void setSkillstr(String skillstr) {
		this.skillstr = skillstr;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String[] getSkill() {
		return skill;
	}
	public void setSkill(String skill[]) {
		this.skill = skill;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	

}
