package com.ncs.green;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.BService;
import vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	BService service;

	@RequestMapping(value="/bcheck")
	public ModelAndView bcheck(ModelAndView mv , BoardVO vo) {
		//check에 선택 내용이 없으면 selectList()
		//check에 선택 내용이 있으면 checkSelectList()
		// 1) check 확인
		// 2) Service 처리
		List<BoardVO> list =null;
		if(vo.getCheck() != null && vo.getCheck().length > 0)
			list = service.checkSelectList(vo);
		else list = service.selectList();
		
		if(list.size() < 1) {
			System.out.println("검색된 자료가 없습니다. // list.size() == 0 ");
			mv.addObject("message","검색된 자료가 없습니다.");
		}
		mv.addObject("Banana",list);
		mv.setViewName("board/checkBList");
		return mv;
	}//bcheck
	
	
//***********************************************************************************************************************

	
	
	
	

	//** Search List
	@RequestMapping(value="/aidblist")
	public ModelAndView aidblist(HttpServletRequest request, ModelAndView mv,BoardVO vo) {

		//redirect 의 경우 message 처리
		/*
		 * if(request.getParameter("message") != null)
		 * mv.addObject("message",request.getParameter("message"));
		 */
		
		
		//Service 처리
		List<BoardVO> list = new ArrayList<BoardVO>();
//		list = service.searchList(vo);
		if(list != null) mv.addObject("banana",list);
		else mv.addObject("message","출력할 자료가 없습니다.");
		mv.setViewName("board/boardList");
		
		return mv;
	}//aiblist
	
//***********************************************************************************************************************	

	//JsonView Detail
	@RequestMapping(value="/jsBDetail")
	public ModelAndView jsBDetail(HttpServletResponse response ,ModelAndView mv , BoardVO vo) {
		//JsonView 사용지 resoponse 외 한글처리
		response.setContentType("text/html; charset=utf-8");
		vo = service.selectOne(vo);
		if(vo != null) {
			mv.addObject("content",vo.getContent());
		}else {
			mv.addObject("content","글번호에 해당하는 글내용이 없습니다.");
		}
		mv.setViewName("jsonView");
		return mv;
	}//jsBDetail
	
	
	
	
	
	
	
	
//***********************************************************************************************************************
	
	//** Ajax Board List
		@RequestMapping(value="/ablist")
		public ModelAndView adblist(HttpServletRequest request, ModelAndView mv,BoardVO vo) {

			//redirect 의 경우 message 처리
			/*
			 * if(request.getParameter("message") != null)
			 * mv.addObject("message",request.getParameter("message"));
			 */
			
			
			//Service 처리
			List<BoardVO> list = new ArrayList<BoardVO>();
			list = service.selectList();
			if(list != null) mv.addObject("banana",list);
			else mv.addObject("message","출력할 자료가 없습니다.");
			mv.setViewName("ajaxTest/axBoardList");
			
			return mv;
		}//ablist
	
	
	
	
	
	
	
//***********************************************************************************************************************	
	
	
//***********************************************************************************************************************		
	
	// ** 답글등록
	// 1) form 출력
	@RequestMapping(value="/rinsertf")
	public ModelAndView rinsertf(ModelAndView mv,BoardVO vo) {
		mv.addObject("ParentInfo",vo);
		mv.setViewName("board/rInsertForm");
		return mv;
	}//rinsertf
	
	// 2) 입력 글 등록
	@RequestMapping(value="/rinsert")
	public ModelAndView rinsert(ModelAndView mv,BoardVO vo) {
		//from : rinstert : id, title, content
		// 자동(sql 구문에서 ) : seq,regdate,cnt
		// 답글부분 : root(원글과 동일) , step , indent => set 필요함
		//		   step , indent 은 원글보다 1씩 큰 값(증가).
		// 		      그러므로 원글에서 보관해 놓아야 함.
		//해결 1) => session 에 보관(bdetail에서 보관)
		//해결 2) => form 에서 요청시 전달
		//			root는 동일, step/indent는 1씩 증가

		//** 해결2)로 ...
		vo.setStep(vo.getStep()+1);
		vo.setIndent(vo.getIndent()+1);
		
		if(service.rinsert(vo)>0) {
			//답글 등록 성공
			mv.addObject("message","답글 등록 성공");
			mv.setViewName("redirect:blist");
		}else {
			//답글 등록 실패
			mv.addObject("message","답글 등록 실패");
			mv.addObject("fCode","BF");
			mv.setViewName("member/doFinish");
		}
		return mv;
	}//rinsert
//***********************************************************************************************************************		
	@RequestMapping(value="/blist")
	public ModelAndView blist(HttpServletRequest request, ModelAndView mv) {

		//redirect 의 경우 message 처리
		if(request.getParameter("message") != null) 
			mv.addObject("message",request.getParameter("message"));
		
		
		//Service 처리
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = service.selectList();
		if(list != null) mv.addObject("Banana",list);
		else mv.addObject("message","출력할 자료가 없습니다.");
		mv.setViewName("board/boardList");
		
		return mv;
	}//blist
//***********************************************************************************************************************		
	@RequestMapping(value="/bdetail")
	public ModelAndView bdetail(HttpServletRequest request , ModelAndView mv , BoardVO vo) {
		// ** 조회수 증가
		// => 조건: 글쓴이의 ID와 글보는이의 logID가 다른경우
		// => 처리순서 : 증가후 조회
		// => 증가 : board update , cnt=cnt+1
		// 1) session 에서 logID get
		String logID;
		HttpSession session = request.getSession(false);
		if(session != null && session.getAttribute("logID") != null) {
			logID = (String)session.getAttribute("logID");

			// 2) 비교 & 증가
			if(!logID.equals(vo.getId())) {
				service.countUp(vo);
			}
			
		}else {// logID 가 null 인 경우 ->message , blist
			mv.addObject("message","요청을 처리할수 없습니다.");
			mv.setViewName("redirect:bliset");
			return mv; // 메서드 종료 , 즉 이하(service 처리)는 처리하지 않음
			
		}
		//Service 처리
		vo = service.selectOne(vo);
		//Mybatis를 사용하지 않고 직접 DAO의  메서드를 작성한 경우에는
		//DAO 에서 조회후 vo에 set 해놓은 결과가 담겨있고,
		//매개변수 vo 가 참조형이기대문에 265행이 없이 아래처럼 비교해도 되지만, 
		//vo에는 DAO에서 조회후 vo에 set해놓은 결과가 담겨있음.
		//if( service.selectOne(vo) != null{
		//Myvatis를 사용하는 경우에는 265행이 필요함.
		if(vo != null) {
			mv.addObject("Detail",vo);
			//Detail or Update 확인
			if("U".equals(request.getParameter("code"))) {
				//update
				mv.setViewName("board/bupdateForm");
			}else {
				mv.setViewName("board/boardDetail");
			}
		}
		else {
			mv.addObject("message","출력할 자료가 없습니다.");
			mv.setViewName("redirect:blist");
		}
		return mv;
	}//bdetail

//***********************************************************************************************************************	

	@RequestMapping(value="/binsertf")
	public ModelAndView binsertf(ModelAndView mv) {
		mv.setViewName("board/bInsertForm");
		return mv;
	}//binsertf

	@RequestMapping(value="/binsert")
	public ModelAndView binsert(ModelAndView mv , BoardVO vo) {
		if(service.insert(vo)>0) {
			//성공 -> blist
			mv.addObject("message","새글등록 성공");
			mv.setViewName("redirect:blist");
		}else {
			//실패 -> doFinish
			mv.addObject("message","새글등록 실패");
			mv.addObject("fCode","BF");
			mv.setViewName("member/doFinish");
		}
		return mv;
	}//binsert
	
	@RequestMapping(value="/bupdate")
	public ModelAndView bupdate(ModelAndView mv , BoardVO vo) {
				
		if ( service.update(vo) > 0 ) {
			// Update 성공 => blist
			mv.addObject("message","글 수정 성공");
			mv.setViewName("redirect:blist");
			
		}else {
			// Update 실패 => 실패 message, doFinish 출력
			mv.addObject("message","글 수정 실패");
			mv.addObject("fCode","BF");
			mv.setViewName("member/doFinish");
		}
		return mv;
	}//beupdate
	
	@RequestMapping(value="/bdelete")
	public ModelAndView bdelete(ModelAndView mv , BoardVO vo) {
		
		//Delete 갯수 확인
		int count=service.delete(vo);
		System.out.println("== Delete 갯수 =>"+count+"개 ");
		
		if ( count > 0 ) {
			// 성공 => blist
			mv.addObject("message","글 삭제 성공");
			mv.setViewName("redirect:blist");
			
		}else {
			// Update 실패 => 실패 message, doFinish 출력
			mv.addObject("message","글 삭제 실패");
			mv.addObject("fCode","BF");
			mv.setViewName("member/doFinish");
		}
		return mv;
	}//delete
	
}//class
