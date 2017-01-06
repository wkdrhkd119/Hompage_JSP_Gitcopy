package suggest;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.DBClose;
import utility.DBOpen;

public class Team extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        
        //출력시 사용할 객체 생성
        PrintWriter out = response.getWriter();
        
        // 문자셋 테스트
        // Utility.charsetTest(request.getParameter("keyword"));
        
        String keyword = request.getParameter("keyword");
        System.out.println("servlet keyword: " + keyword);
        
        int count = 0;
        
        if (keyword == null){
            keyword ="";
        }
        
        Connection con = DBOpen.open();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = null;
        
        try {
            sql = new StringBuffer();
            
            sql.append(" SELECT COUNT(*)");
            sql.append(" FROM team");
            sql.append(" WHERE name LIKE '" + keyword +"%'");
 
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery(); // 쿼리 실행
            
            if (rs.next()){
             count = rs.getInt(1);  // 수량 산출
            }
            
            sql.delete(0, sql.toString().length()); // buffer clear
            
            sql.append(" SELECT name,phone,skill");
            sql.append(" FROM team");
            sql.append(" WHERE name LIKE '" + keyword +"%'");
            sql.append(" ORDER BY name ASC");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery(); // 쿼리 실행
            
            
            // Client로 지정
            // 문자열 조합: 갯수|
            out.print(count + "|");
            
            while(rs.next()) {
                count = count - 1;
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String skill = rs.getString("skill");
                out.print(name+"^"+phone+"^"+skill);
                if (count > 0){ // 값의 중간만 콤마 출력
                    out.print("#");
                }
            }
            
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             DBClose.close(con,pstmt, rs);
        }        
        
    }   

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
	
}
