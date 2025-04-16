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
	private boolean boardStatus;
	private int boardViews;
	private String boardWriter;
	
    // BoardDto -> BoardVo 변환
    public static BoardVo of(BoardDto boardDto) {
        BoardVo boardVo = new BoardVo();
        
        if (boardDto.getBoardNo() != null)
            boardVo.setBoardNo(Integer.parseInt(boardDto.getBoardNo()));
        
        boardVo.setBoardTitle(boardDto.getBoardTitle());
        boardVo.setBoardContent(boardDto.getBoardContent());
        boardVo.setBoardDate(boardDto.getBoardDate());

        if (boardDto.getBoardStatus() != null)
            boardVo.setBoardStatus(Boolean.parseBoolean(boardDto.getBoardStatus()));

        if (boardDto.getBoardViews() != null)
            boardVo.setBoardViews(Integer.parseInt(boardDto.getBoardViews()));

        boardVo.setBoardWriter(boardDto.getBoardWriter());

        return boardVo;
    }
}
