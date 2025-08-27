package com.example.demo.board;

import java.util.List;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.example.demo.auth.AuthDto;
import com.example.demo.pagination.PageInfo;

import exception.AuthException;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardService {
	private final BoardDao boardDao;
    private final SimpMessagingTemplate messagingTemplate;

	public int selectListCount(String keyword) {
		return boardDao.selectListCount(keyword);
	}

	public List<BoardDto> selectAll(PageInfo pi, String keyword) {
		// offset
	    int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
	    // limit
	    int boardLimit = pi.getBoardLimit();

	    return boardDao.selectAll(startRow, keyword, boardLimit);
	}

	public BoardDto selectByIndex(int bno) {
		boardDao.increaseViewByIndex(bno);
<<<<<<< HEAD
		return new BoardDto(boardDao.selectByIndex(bno));
=======
		return BoardDto.of(boardDao.selectByIndex(bno));
>>>>>>> ac64c8fbbf72adbabc0f8c318d290160ec89c406
	}

	public void write(BoardDto boardDto, HttpSession httpSession) {
		boardDto.setBoardWriter(getUserInfo(httpSession));
		// trigger를 통한 조회 테이블 insert
<<<<<<< HEAD
		boardDao.insert(new BoardVo(boardDto));
=======
		boardDao.insert(BoardVo.of(boardDto));
>>>>>>> ac64c8fbbf72adbabc0f8c318d290160ec89c406
		messagingTemplate.convertAndSend("/board", "new");
	}

	public BoardDto updateByIndex(int bno) {
<<<<<<< HEAD
		return new BoardDto(boardDao.selectByIndex(bno));
=======
		return BoardDto.of(boardDao.selectByIndex(bno));
>>>>>>> ac64c8fbbf72adbabc0f8c318d290160ec89c406
	}
	
	public void update(BoardDto boardDto, HttpSession httpSession) {
		boardDto.setBoardWriter(getUserInfo(httpSession));
<<<<<<< HEAD
		boardDao.update(new BoardVo(boardDto));
=======
		boardDao.update(BoardVo.of(boardDto));
>>>>>>> ac64c8fbbf72adbabc0f8c318d290160ec89c406
	}

	public void delete(int bno, HttpSession httpSession) {
//		if (boardAuthCheck(httpSession, boardDto)) {
			boardDao.delete(bno);
//		}
	}
	
//	public boolean boardAuthCheck(HttpSession httpSession, BoardDto boardDto) {
//		AuthDto authDto = (AuthDto) httpSession.getAttribute("loginUser");
//		System.out.println(boardDto.toString());
//		System.out.println(authDto.toString());
//		if (!(boardDto.getBoardWriter().equals(authDto.getUserNo()))) {
//			throw new AuthException("작성자가 다름");
//		}
//		return true;
//	}
	
	
	private String getUserInfo(HttpSession httpSession) {
		AuthDto authDto = (AuthDto) httpSession.getAttribute("loginUser");
		if (authDto == null) {
			throw new AuthException("미 로그인");
		}
		return authDto.getUserNo();
	}

}
