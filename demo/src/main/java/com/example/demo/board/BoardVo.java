package com.example.demo.board;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BoardVo {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardDate;
	private int boardViews;
	private int boardLikes;
	private int boardWriter;
	
    // BoardDto -> BoardVo 변환
    public static BoardVo of(BoardDto boardDto) {
        BoardVo boardVo = new BoardVo();
        
        boardVo.setBoardNo(Integer.parseInt(boardDto.getBoardNo())); // String -> int
        boardVo.setBoardTitle(boardDto.getBoardTitle());
        boardVo.setBoardContent(boardDto.getBoardContent());
        boardVo.setBoardDate(boardDto.getBoardDate());
        boardVo.setBoardViews(Integer.parseInt(boardDto.getBoardViews())); // String -> int
        boardVo.setBoardLikes(Integer.parseInt(boardDto.getBoardLikes())); // String -> int
        boardVo.setBoardWriter(Integer.parseInt(boardDto.getBoardWriter())); // String -> int
        
        return boardVo;
    }
}
