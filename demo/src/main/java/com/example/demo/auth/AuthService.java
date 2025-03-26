package com.example.demo.auth;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    private final AuthDao authDao;
    private final BCryptPasswordEncoder passwordEncoder;

    public AuthService(AuthDao authDao) {
        this.authDao = authDao;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    @Transactional
    public void registerAuth(AuthDto authDto) throws Exception {
		AuthVo authVo = AuthVo.of(authDto);
    	
    	// 아이디 중복 검사
    	if (authDao.findById(authVo)!=null) {
    		throw new Exception("아이디 중복");
    	};
    	
        // 비밀번호 암호화
    	authVo.setPassword(passwordEncoder.encode(authVo.getPassword()));

        // DAO를 통해 회원 정보 저장
        authDao.insertAuth(authVo);
    }
}