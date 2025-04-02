package com.example.demo.board;

import java.util.ArrayList;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.auth.AuthDto;
import com.example.demo.pagination.PageInfo;

import exception.AuthException;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardService {
	private final BoardDao boardDao;

	public int selectListCount() {
		return boardDao.selectAll();
	}

	public ArrayList<BoardDto> selectList(PageInfo pi) {
		return null;
	}

	public BoardDto selectByIndex(int bno) {
		return boardDao.selectByIndex(bno);
	}

	public void write(BoardDto boardDto) {
		boardDao.insert(BoardVo.of(boardDto));
		
	}

	public void update(BoardDto boardDto, HttpSession httpSession, Model model) {
//		BoardDto boardDto = (BoardDto) model.getAttribute("board");
//		AuthDto authDto = (AuthDto) httpSession.getAttribute("loginUser");
//		if (!(boardDto.getBoardWriter().equals(authDto.getUserNo()))) {
//			throw new AuthException("작성자가 다름");
//		}
		boardDao.update(BoardVo.of(boardDto));
	}

	public void delete(int bno, HttpSession httpSession, Model model) {
		BoardDto boardDto = (BoardDto) model.getAttribute("board");
		AuthDto authDto = (AuthDto) httpSession.getAttribute("loginUser");
		if (!(boardDto.getBoardWriter().equals(authDto.getUserNo()))) {
			throw new AuthException("작성자가 다름");
		}
		boardDao.delete(bno);
	}

}
