package images;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class ImagesDAO {
	
	
	public List imgRead(int no){
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(no,2)     over (order by no) pre_imgno2,    ");
		sql.append("          lag(no,1)     over (order by no) pre_imgno1,   ");
		sql.append("          no,  ");
		sql.append("          lead(no,1)    over (order by no) nex_imgno1,    ");
		sql.append("          lead(no,2)    over (order by no) nex_imgno2,    ");
		sql.append("          lag(fname,2)  over (order by no) pre_file2,     ");
		sql.append("          lag(fname,1)  over (order by no) pre_file1,  ");
		sql.append("          fname,   ");
		sql.append("          lead(fname,1) over (order by no) nex_file1,  ");
		sql.append("          lead(fname,2) over (order by no) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT no, fname   ");
		sql.append("               FROM images ");
		sql.append("               ORDER BY no DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE no = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_imgno2"),
						rs.getInt("pre_imgno1"),
						rs.getInt("no"),
						rs.getInt("nex_imgno1"),
						rs.getInt("nex_imgno2")
					    };
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("fname"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(con, pstmt, rs);
		}
				
		return list;
		
		
	}
	/**
	 * 부모글인지 확인
	 * 부모글이면 삭제 못함
	 * @param imagesDTO 삭제 하려고 하는 글 번호
	 * @return true=부모글 번호, false=부모글 번호 아님.
	 */
	public boolean checkRefno(int no){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select count(refno) from images ");
		sql.append(" where refno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt = rs.getInt(1);
				if(cnt>0) flag = true;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
	}
	
	public int total(String col, String word) {
		int total = 0;
		Connection con= DBOpen.open();
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		StringBuffer sql= new StringBuffer();
		sql.append(" select count(*) from images ");	
		if(word.trim().length()>0)
		sql.append(" where "+col+" like '%'||?||'%' ");

		try {
		pstmt=con.prepareStatement(sql.toString());
		if(word.trim().length()>0)
		pstmt.setString(1, word);
		rs=pstmt.executeQuery();

		if(rs.next()){
		total=rs.getInt(1);
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
		sql.append(" update images set ");
		sql.append(" ansnum = ansnum + 1 ");
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
	public boolean createReply(ImagesDTO dto){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" INSERT INTO images ");
		sql.append(" (no, wname, title, content, passwd, wdate, grpno, indent, ansnum, refno, fname) ");
		sql.append(" VALUES((SELECT NVL(MAX(no), 0) + 1 as no FROM images), ");
		sql.append(" ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno());
			pstmt.setInt(6, dto.getIndent()+1);
			pstmt.setInt(7, dto.getAnsnum()+1);
			pstmt.setInt(8, dto.getNo());
			pstmt.setString(9, dto.getFname());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) flag =true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
		
		return flag;

	}
	public ImagesDTO readReply(int no){
		ImagesDTO dto = null;                      
		Connection con = DBOpen.open();       
		PreparedStatement pstmt = null;       
		ResultSet rs = null;                  
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select no, wname, title, content, grpno, indent, ansnum, fname ");
		sql.append(" from images ");
		sql.append(" where no = ?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new ImagesDTO();
				dto.setNo(rs.getInt("no"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setFname(rs.getString("fname"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}
	
	public boolean delete(int no){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from images  ");
		sql.append(" where no = ? ");

		try {
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setInt(1, no);

		int cnt = pstmt.executeUpdate();

		if(cnt>0) flag=true;

		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}finally{
		DBClose.close(con, pstmt);
		}



		return flag;
		}
	
	public boolean update(ImagesDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE images SET wname=?, title=?, content=? ,fname=? WHERE no = ? ");
		try {
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setString(1, dto.getWname());
		pstmt.setString(2, dto.getTitle());
		pstmt.setString(3, dto.getContent());
		pstmt.setString(4, dto.getFname());
		pstmt.setInt(5, dto.getNo());
		int cnt = pstmt.executeUpdate();
		if (cnt > 0)
		flag = true;
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		DBClose.close(con, pstmt);
		}

		return flag;
		}
	
	public boolean passCheck(Map map){
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int no = (Integer)map.get("no");
		String passwd = (String)map.get("passwd");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(no) as cnt ");
		sql.append(" FROM images ");
		sql.append(" WHERE no=? AND passwd=? ");


		try {
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setInt(1, no);
		pstmt.setString(2, passwd);

		rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");

		if(cnt>0) flag=true;//올바른 패스워드
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}finally{
		DBClose.close(con, pstmt, rs);
		}

		return flag;
		}
	
	public ImagesDTO read(int no){
		ImagesDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" SELECT no, wname, title, content, viewcnt, wdate, fname ");
		sql.append(" FROM images ");
		sql.append(" WHERE no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new ImagesDTO();
				dto.setNo(rs.getInt("no"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}
	public void upViewcnt(int no){
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" UPDATE images ");
		sql.append(" SET viewcnt = viewcnt + 1 ");
		sql.append(" WHERE no=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt);
		}
	}
		
	public List<ImagesDTO> list(Map map) {
		List<ImagesDTO> list = new ArrayList<ImagesDTO>();
		Connection con=DBOpen.open();
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		String col=(String)map.get("col");
		String word=(String)map.get("word");

		int sno=(Integer)map.get("sno");
		int eno=(Integer)map.get("eno");
		StringBuffer sql= new StringBuffer();

		sql.append(" SELECT no, wname, title, content, passwd, viewcnt, wdate, grpno, indent, fname, r ");
		sql.append("    	 from(   ");
		sql.append("    	SELECT no, wname, title, content, passwd, viewcnt, wdate, grpno, indent, fname, rownum r ");
		sql.append(" 	   	from( ");
		sql.append(" 	SELECT no, wname, title, content, passwd, viewcnt, wdate, grpno, indent, fname ");
		sql.append(" 	FROM images   ");
		if(word.trim().length()>0)
		sql.append(" 	where "+col+" like '%'||?||'%' ");
		sql.append(" 	ORDER BY grpno DESC, ansnum  ");
		sql.append(" 	    ) ");
		sql.append("   	  ) where r>=? and r<=? ");

		try {
		pstmt=con.prepareStatement(sql.toString());
		int i=0;
		if(word.trim().length()>0)
		pstmt.setString(++i, word);
		pstmt.setInt(++i, sno);
		pstmt.setInt(++i, eno);

		rs=pstmt.executeQuery();
		//no, wname, title, content, password, grpno, indent, ansnum, filename	
		while(rs.next()){
		ImagesDTO dto= new ImagesDTO();
		dto.setNo(rs.getInt("no"));
		dto.setWname(rs.getString("wname"));
		dto.setTitle(rs.getString("title"));
		dto.setViewcnt(rs.getInt("viewcnt"));
		dto.setWdate(rs.getString("wdate"));
		dto.setIndent(rs.getInt("indent"));
		dto.setFname(rs.getString("fname"));

		list.add(dto);
		}
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}finally{
		DBClose.close(con, pstmt, rs);
		}

		return list;

		}

	public boolean create(ImagesDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into IMAGES(no, wname, title, content, passwd, grpno, fname, wdate) ");
		sql.append(" values((select nvl(max(no),0)+1 as no from images), ?, ?, ?, ?, ");
		sql.append(" (SELECT NVL(MAX(grpno), 0)+1 FROM images), ?, sysdate) ");

		try {
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setString(1, dto.getWname());
		pstmt.setString(2, dto.getTitle());
		pstmt.setString(3, dto.getContent());
		pstmt.setString(4, dto.getPasswd());
		pstmt.setString(5, dto.getFname());

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

}