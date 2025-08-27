package com.example.demo.board;

import com.example.demo.base.BaseDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDto extends BaseDto {
	private String boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardStatus;
	private String boardWriter;
	
	public BoardDto() {}
	
    // VO → DTO 변환
    public BoardDto(BoardVo boardVo) {
        super(boardVo);

        if (boardVo == null) return;

        if (boardVo.getBoardNo() != null) {
        	this.boardNo = boardVo.getBoardNo().toString();
        }
        this.boardTitle = boardVo.getBoardTitle();
        this.boardContent = boardVo.getBoardContent();
        this.boardStatus = boardVo.getBoardStatus();
        this.boardWriter = boardVo.getBoardWriter();
    }
}
