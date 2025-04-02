package com.example.demo.board;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.AllArgsConstructor;

@Repository
@AllArgsConstructor
public class BoardDao {
	private final SqlSessionTemplate sqlSession;

	public int selectAll() {
		return sqlSession.selectOne("boardMapper.selectALL", null);
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
