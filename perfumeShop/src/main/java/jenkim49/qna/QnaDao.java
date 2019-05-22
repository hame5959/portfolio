package jenkim49.qna;

import java.util.ArrayList;
import java.util.List;

public interface QnaDao {
	
	/*
	 * 공지사항 게시판 리스트 전체 읽기
	 */
	ArrayList<Qna> readAll() throws Exception;
	

	/*
	 * 게시물 하나 읽기
	 */
	Qna qna_readOne(int Q_no) throws Exception;
	

	/*
	 *  게시판 쓰기
	 */
	boolean qnaInsert(Qna qna) throws Exception;
	

	/*
	 *   답글게시물 추가하는 메소드
	 */
		
	int qnaReplay(Qna review) throws Exception;
	
	
	/*
	 * 삭제
	 */
	
	boolean qnaDelete(int q_no)throws Exception;
	
	/*
	 * 수정
	 */
	boolean qnaUpdate(Qna updateQna) throws Exception;
	
	/*
	 * 조회수 1올리는 메소드
	 */
	
	boolean increaseReadCount(int number) throws Exception;

	
	
	boolean getCount(int number)throws Exception;


	/*
	 *  제품번호로 게시판읽기
	 *  
	 */
	ArrayList<Qna> Qna_readOne_Pno(int p_no) throws Exception;
	
	
	
	
	}


