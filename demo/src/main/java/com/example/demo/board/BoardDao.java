package com.example.demo.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class BoardDao {
	private final SqlSessionTemplate sqlSession;

	public int selectListCount() {
		return sqlSession.selectOne("boardMapper.selectListCount", null);
	}
	
	public List<BoardDto> selectAll(int startRow, int boardLimit) {
	    Map<String, Integer> params = new HashMap<>();
	    params.put("startRow", startRow);
	    params.put("boardLimit", boardLimit);
		return sqlSession.selectList("boardMapper.selectAll", params);
	}

	public BoardDto selectByIndex(int bno) {
		return sqlSession.selectOne("boardMapper.selectByIndex", bno);
	}

	public void insert(BoardVo boardVo) {
		sqlSession.insert("boardMapper.insertBoard", boardVo);
		
	}

	public void update(BoardVo boardVo) {
		sqlSession.update("boardMapper.updateBoardByIndex",boardVo);
	}

	public void delete(int bno) {
		sqlSession.delete("boardMapper.deleteBoardByIndex", bno);
	}


}
