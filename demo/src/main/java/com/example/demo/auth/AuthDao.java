package com.example.demo.auth;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository	
@RequiredArgsConstructor
public class AuthDao {
	
	private final SqlSessionTemplate sqlSession;
	
	public int insertAuth(AuthVo authVo) {
		int result = sqlSession.insert("authMapper.insertAuth", authVo);
		return result;
	}
	
	public AuthVo findByUserId(AuthVo authVo) {
		return sqlSession.selectOne("authMapper.findByUserId", authVo);
	}

	public AuthVo findByEmail(AuthVo authVo) {
		return sqlSession.selectOne("authMapper.findByEmail", authVo);
	}

	public void updateByUserId(AuthVo authVo) {
		sqlSession.update("authMapper.updateByUserId", authVo);
	}

	public void deleteByUserId(AuthVo authVo) {
		sqlSession.delete("authMapper.deleteByUserId", authVo);
	}
}
