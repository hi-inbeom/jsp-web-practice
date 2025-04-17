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
public class BoardDto {
	private String boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardDate;
	private String boardStatus;
	private String boardView;
	private String boardWriter;
	
    // BoardVo -> BoardDto 변환
    public static BoardDto of(BoardVo boardVo) {
        BoardDto boardDto = new BoardDto();
        
        boardDto.setBoardNo(String.valueOf(boardVo.getBoardNo())); // int -> String
        boardDto.setBoardTitle(boardVo.getBoardTitle());
        boardDto.setBoardContent(boardVo.getBoardContent());
        boardDto.setBoardDate(boardVo.getBoardDate());
        boardDto.setBoardStatus(String.valueOf(boardVo.isBoardStatus()));
        boardDto.setBoardView(String.valueOf(boardVo.getBoardView())); // int -> String
        boardDto.setBoardWriter(String.valueOf(boardVo.getBoardWriter())); // int -> String
        
        return boardDto;
    }
}
