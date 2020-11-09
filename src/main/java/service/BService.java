package service;

import java.util.List;

import vo.BoardVO;

public interface BService {

	
	
	// ** CheckBox BoardList : checkbox 이용한 다중검색
	List<BoardVO> checkSelectList(BoardVO vo);
	
	int searchRowCount();
	
	
	//** Criteria BoardList
	// ** PageList


	int totalRowCount();


	// ** 답글 등록
	int rinsert(BoardVO vo);//	rinsert

	// ** 조회수 증가
	int countUp(BoardVO vo);//countUp

	List<BoardVO> selectList();//selectList

	BoardVO selectOne(BoardVO vo);

	int insert(BoardVO vo); // insert

	int update(BoardVO vo); // update

	int delete(BoardVO vo);


}