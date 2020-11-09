package jdbcUtil;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.BoardVO;

// Board Table JPA_Test
// => selectList, selectOne, insert, update, delete ,countUp
@Repository
public class BoardDAO {
	
	@PersistenceContext // EntityManager 객체 주입시 사용하는 어노테이션
	private EntityManager emanager;
	
	

//============================================================================================================================================	
	
	public List<BoardVO> selectList() {
		return emanager.createQuery("from BoardVO order by root desc, step asc").getResultList();
	}//selectList

//============================================================================================================================================	
	
	public BoardVO selectOne(BoardVO vo) {
	      return emanager.find(BoardVO.class, vo.getSeq());
	   }//selectOne

//============================================================================================================================================
	
	// ** 원글 insert
	// 추가 => root(seq와 동일),step(0),indent(0)
	public int insert(BoardVO vo) {
		return sqlsession.insert(NS+"insert", vo);
	} // insert

//============================================================================================================================================
	
	public int update(BoardVO vo) {
		return sqlsession.update(NS+"update", vo);
	} // update

//============================================================================================================================================

	// 원글삭제 => 일괄(답글들까지)삭제
	// 딥글삭제 => 해당 답글만 삭제
	public int delete(BoardVO vo) {
		return sqlsession.delete(NS+"delete",vo);
	} // delete

}