package service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jdbcUtil.BoardDAO;
import vo.BoardVO;

//Board Table 의 CRUD 구현
//=> selectList, selectOne, insert, update, delete 


@Service
public class BServiceImpl implements BService {
	
	@Autowired
	BoardDAO dao;
	
    // ** CheckBox BoardList : checkbox 이용한 다중검색
	public List<BoardVO> checkSelectList(BoardVO vo){
		return dao.checkSelectList(vo);
	}
	
	@Override
	public int searchRowCount() {
		return dao.searchRowCount();
	}
	
	
	@Override
	public int totalRowCount() {
		return dao.totalRowCount();
	}
	
	
	// ** 답글 등록
	@Override
	public int rinsert(BoardVO vo) {
		return dao.rinsert(vo);
	}//	rinsert
	
	// ** 조회수 증가
	@Override
	public int countUp(BoardVO vo) {
		return dao.countUp(vo);
	}//countUp
	
	@Override
	public List<BoardVO> selectList() {
		return dao.selectList();
	}//selectList
	
	@Override
	public BoardVO selectOne(BoardVO vo) {
		return dao.selectOne(vo);
	}
	
	@Override
	public int insert(BoardVO vo) {  
		return dao.insert(vo);  // 처리된 row 갯수 return	 
	} // insert
	
	@Override
	public int update(BoardVO vo) { // row(vo) 전달 받아 수정
		return dao.update(vo);  // 처리된 row 갯수 return
	} // update
	
	@Override
	public int delete(BoardVO vo) {
		return dao.delete(vo);
	}
	
	

	
}
