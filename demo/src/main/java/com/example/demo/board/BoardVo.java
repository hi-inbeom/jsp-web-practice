package com.example.demo.board;

import com.example.demo.base.BaseVo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVo extends BaseVo {
	private Long boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardStatus;
	private String boardWriter;
	
	public BoardVo() {}

    // DTO → VO 변환
    public BoardVo(BoardDto boardDto) {
        super(boardDto);

        if (boardDto == null) return;

        if (boardDto.getBoardNo() != null && !boardDto.getBoardNo().isEmpty()) {
            this.boardNo = Long.parseLong(boardDto.getBoardNo());
        }
        this.boardTitle = boardDto.getBoardTitle();
        this.boardContent = boardDto.getBoardContent();
        this.boardStatus = boardDto.getBoardStatus();
        this.boardWriter = boardDto.getBoardWriter();
    }
}
