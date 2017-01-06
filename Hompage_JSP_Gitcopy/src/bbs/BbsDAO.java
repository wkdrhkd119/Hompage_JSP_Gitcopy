package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class BbsDAO {
		
	/** 
	 * 부모글인지 확인
	 * 부모글이면 삭제 못함
	 * @param bbsno 삭제하려고하는 글번호
	 * @return true 부모글번호, false 부모글 아님
	 */
	public boolean checkRefno(int bbsno){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(refno) from bbs ");
		sql.append(" where refno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				int cnt = rs.getInt(1);
				if(cnt>0) flag = true;//부모글이다.
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	
	public int total(String col, String word){
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from bbs ");
		if(word.trim().length()>0)
		sql.append(" where "+col+" like '%'||?||'%' ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0){
				pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				total = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
				
		return total;
	}
	
	public void upAnsnum(Map map){
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		sql.append(" update bbs set ansnum = ansnum + 1 ");
		sql.append(" where grpno = ? and ansnum > ? ");
				
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		
	}
	
	
	public boolean createReply(BbsDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		sql.append(" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno, ");
		sql.append(" indent, ansnum, refno, filename, filesize) "); //refno 부모글번호 저장 하는 곳
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), ?, ?, ?, ?, sysdate, ");
		sql.append(" ?, ?, ?, ?, ?, ?) ");
		 
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno()); //부모와 동일
			pstmt.setInt(6, dto.getIndent()+1); //부모의 indent+1
			pstmt.setInt(7, dto.getAnsnum()+1); //부모의 ansnum+1
			pstmt.setInt(8, dto.getBbsno()); //부모의 글번호 등록
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	
	public BbsDTO readReply(int bbsno){
		BbsDTO dto = new BbsDTO();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select bbsno, title, grpno, indent, ansnum ");
		sql.append(" from bbs where bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
			dto.setBbsno(rs.getInt("bbsno"));
			dto.setTitle(rs.getString("title"));
			dto.setGrpno(rs.getInt("grpno"));
			dto.setIndent(rs.getInt("indent"));
			dto.setAnsnum(rs.getInt("ansnum"));
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public boolean delete(int bbsno){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from bbs where bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag=true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		
		return flag;
	}
	
	
	public boolean update(BbsDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update bbs set wname= ?, title= ?, content= ? "); //content= ?, 가 들어가면 안된다. if문을 돌리기 위해서
		if(dto.getFilesize()>0){
			sql.append(" ,filename = ?, filesize = ? ");
		}
		sql.append(" where bbsno = ? ");
		
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFilesize()>0){
				pstmt.setString(++i, dto.getFilename());
				pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getBbsno());
			
			int cnt = pstmt.executeUpdate(); 
			if(cnt>0) flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public boolean passCheck(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int bbsno = (Integer)map.get("bbsno");
		String passwd = (String)map.get("passwd");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(bbsno) as cnt ");
		sql.append(" from bbs where bbsno = ? and passwd= ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt("cnt");
			
			if(cnt>0) flag=true; //일치하는 패스워드가 존재한다.
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	
	public BbsDTO read(int bbsno){
		BbsDTO dto = new BbsDTO();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select bbsno, wname, title, viewcnt, wdate, content, filename, filesize ");
		sql.append(" from bbs where bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
			dto.setBbsno(rs.getInt("bbsno"));
			dto.setWname(rs.getString("wname"));
			dto.setTitle(rs.getString("title"));
			dto.setViewcnt(rs.getInt("viewcnt"));
			dto.setWdate(rs.getString("wdate"));
			dto.setContent(rs.getString("content"));
			dto.setFilename(rs.getString("filename"));
			dto.setFilesize(rs.getInt("filesize"));
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public void upViewcnt(int bbsno){
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update bbs set viewcnt = viewcnt + 1 ");
		sql.append(" where bbsno = ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
	}
	
	
	public List<BbsDTO> list(Map map){
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int eno = (Integer)map.get("eno");
		int sno = (Integer)map.get("sno");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select bbsno, wname, title, viewcnt, wdate, indent, filename, r ");
		sql.append(" from( ");
		sql.append(" SELECT bbsno, wname, title, viewcnt, wdate, indent, filename, rownum r ");
		sql.append(" from( ");
		sql.append(" select bbsno, wname, title, viewcnt, wdate, indent, filename from bbs ");
		if(word.trim().length()>0)
			sql.append(" where "+col+" like '%'||?||'%' ");
		sql.append(" ORDER BY grpno DESC, ansnum ASC ");
		sql.append(" 	) ");
		sql.append(" )where r>=? and r<=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if(word.trim().length()>0)
				pstmt.setString(++i, word);
			
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BbsDTO dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setIndent(rs.getInt("indent"));
				dto.setFilename(rs.getString("filename"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	
	public boolean create(BbsDTO dto){
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		sql.append(" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno, filename, filesize) ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), ?, ?, ?, ?, sysdate, ");
		sql.append(" (SELECT NVL(MAX(grpno), 0)+1 FROM bbs), ?, ?) ");
		 
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		 
		
		return flag;
	}

}
