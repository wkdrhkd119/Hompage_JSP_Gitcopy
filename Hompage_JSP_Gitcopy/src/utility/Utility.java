package utility;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;

public class Utility {
	
	
	public static String getCodeValue(String code){
		String value=null;
		Hashtable codes = new Hashtable();
		codes.put("A01", "회사원");
		codes.put("A02", "전산관련직");
		codes.put("A03", "연구전문직");
		codes.put("A04", "각종학교학생");
		codes.put("A05", "일반자영업");
		codes.put("A06", "공무원");
		codes.put("A07", "의료인");
		codes.put("A08", "법조인");
		codes.put("A09", "종교/언론/예술인");
		codes.put("A10", "기타");
		
		value = (String)codes.get(code);
		
		
		return value;
	}
	
	
	/**
     * 오늘,어제,그제 날짜 가져오기
     * @return List- 날짜들 저장
     */
    public static List<String> getDay(){
        List<String> list = new ArrayList<String>();
        
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd"); //날짜 설정하기
        Calendar cal = Calendar.getInstance(); //현재날짜 알려주기
        for(int j = 0; j < 3; j++){
            list.add(sd.format(cal.getTime()));
            cal.add(Calendar.DATE, -1);//현재 날짜에서 하루전 날짜 뺴오기
        }
        
        return list;
    }
    /**
     * 등록날짜와 오늘,어제,그제날짜와 비교
     * @param wdate - 등록날짜
     * @return - true:오늘,어제,그제중 등록날짜와 같음
     *           false:오늘,어제,그제 날짜가 등록날짜와 다 다름
     */
    public static boolean compareDay(String wdate){
        boolean flag = false;
        List<String> list = getDay();
        if(wdate.equals(list.get(0)) 
           || wdate.equals(list.get(1))
           || wdate.equals(list.get(2))){
            flag = true;
        }
          
        return flag;
    }
	
	
	public static String checkNull(String str){
		if(str==null){
			str = "";
		}
		
		return str;

	}
	
	/** 
	   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
	   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
	   *  
	   * @param totalRecord 전체 레코드수 
	   * @param nowPage     현재 페이지 
	   * @param recordPerPage 페이지당 레코드 수  
	   * @param col 검색 컬럼  
	   * @param word 검색어
	   * @return 페이징 생성 문자열
	   */ 
	  public static String paging3(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
	    int pagePerBlock = 10; // 블럭당 페이지 수 ,한번에 보여질 페이지수
	    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // 전체 페이지  
	    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
	    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
	    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
	    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
	     
	    StringBuffer str = new StringBuffer(); 
	     
	    str.append("<style type='text/css'>"); 
	    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
	    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
	    str.append("  #paging A:hover{text-decoration:none; background-color: #CCCCCC; color:black; font-size: 1em;}"); 
	    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
	    str.append("  .span_box_1{"); 
	    str.append("    text-align: center;");    
	    str.append("    font-size: 1em;"); 
	    str.append("    border: 1px;"); 
	    str.append("    border-style: solid;"); 
	    str.append("    border-color: #cccccc;"); 
	    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
	    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
	    str.append("  }"); 
	    str.append("  .span_box_2{"); 
	    str.append("    text-align: center;");    
	    str.append("    background-color: #668db4;"); 
	    str.append("    color: #FFFFFF;"); 
	    str.append("    font-size: 1em;"); 
	    str.append("    border: 1px;"); 
	    str.append("    border-style: solid;"); 
	    str.append("    border-color: #cccccc;"); 
	    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
	    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
	    str.append("  }"); 
	    str.append("</style>"); 
	    str.append("<DIV id='paging'>"); 
//	    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
	 
	    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
	    if (nowGrp >= 2){ 
	      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
	    } 
	 
	    for(int i=startPage; i<=endPage; i++){ 
	      if (i > totalPage){ 
	        break; 
	      } 
	  
	      if (nowPage == i){ 
	        str.append("<span class='span_box_2'>"+i+"</span>"); 
	      }else{ 
	        str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
	      } 
	    } 
	     
	    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
	    if (nowGrp < totalGrp){ 
	      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
	    } 
	    str.append("</DIV>"); 
	     
	    return str.toString(); 
	  } 
	 
	
	 /** 
	   * 숫자 형태의 페이징, 1 페이지부터 시작 
	   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
	   *  
	   * @param totalRecord 전체 레코드수 
	   * @param nowPage     현재 페이지 
	   * @param recordPerPage 페이지당 출력할 레코드 수
	   * @param col 검색 컬럼  
	   * @param word 검색어
	   * @return 페이징 생성 문자열
	   */ 
	  public static String paging(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
	    int pagePerBlock = 10; // 블럭당 페이지 수 
	    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage));// 전체 페이지  
	    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
	    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
	    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
	    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
	     
	    StringBuffer str = new StringBuffer(); 
	     
	    str.append("<style type='text/css'>"); 
	    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
	    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
	    str.append("  #paging A:hover{text-decoration:underline; background-color: #ffffff; color:black; font-size: 1em;}"); 
	    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
	    str.append("</style>"); 
	    str.append("<DIV id='paging'>"); 
	    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
	 
	    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
	    if (nowGrp >= 2){ 
	      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A>]"); 
	    } 
	 
	    for(int i=startPage; i<=endPage; i++){ 
	      if (i > totalPage){ 
	        break; 
	      } 
	  
	      if (nowPage == i){ // 현재 페이지이면 강조 효과 
	        str.append("<span style='font-size: 1.2em; font-weight: bold;'>"+i+"</span> ");   
	      }else{ 
	        str.append("<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A> "); 
	      } 
	       
	    } 
	     
	    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
	    if (nowGrp < totalGrp){ 
	      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A>]"); 
	    } 
	    str.append("</DIV>"); 
	     
	    return str.toString(); 
	    
	  } 
	
}


