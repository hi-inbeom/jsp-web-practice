package com.example.demo.auth;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository	
public class AuthDao {
	
	private SqlSessionTemplate sqlSession;
	
	public int insertAuth(AuthVo authVo) {
		int result = sqlSession.insert("authMapper.insertAuth", authVo);
		return result;
	}
	
	public AuthVo findById(AuthVo authVo) {
		return sqlSession.selectOne("authMapper.findById", authVo);
	}
}
