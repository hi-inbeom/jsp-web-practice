package com.example.demo.auth;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import exception.AuthException;

@Service
public class AuthService {

    private final AuthDao authDao;
    private final PasswordEncoder passwordEncoder;

    public AuthService(AuthDao authDao) {
        this.authDao = authDao;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }
    
    public void login(AuthDto authDto)  {
		AuthVo authVo = AuthVo.of(authDto);
    	
    	if (authDao.findByUserId(authVo)==null) {
    		throw new AuthException("존재하지 않는 아이디");
    	}
    	
    	AuthDto loginUser= AuthDto.of(authDao.findByUserId(authVo));
    	
    	if (!passwordEncoder.matches(authVo.getPassword(), loginUser.getPassword())) {
    		throw new AuthException("비밀번호 불 일치");
    	}
    }
    
    @Transactional
    public void registerAuth(AuthDto authDto) {
		AuthVo authVo = AuthVo.of(authDto);
    	
    	// 아이디 중복 검사
    	if (authDao.findByUserId(authVo)!=null) {
    		throw new AuthException("아이디 중복");
    	};
    	// 이메일 중복 검사
    	if (authDao.findByEmail(authVo)!=null) {
    		throw new AuthException("이메일 중복");
    	}
    	
        // 비밀번호 암호화
    	authVo.setPassword(passwordEncoder.encode(authVo.getPassword()));

        // DAO를 통해 회원 정보 저장
        authDao.insertAuth(authVo);
    }

	public AuthDto findAccount(AuthDto authDto) {
		AuthVo authVo = AuthVo.of(authDto);
		authDto = AuthDto.of(authDao.findByEmail(authVo));
		
    	if (authDto==null) {
    		throw new AuthException("존재하지 않는 이메일");
    	}
    	
    	return authDto;
	}

    @Transactional
	public void updateAccount(AuthDto authDto) {
		AuthVo authVo = AuthVo.of(authDto);
		
		if (authDao.findByUserId(authVo)==null) {
    		throw new AuthException("존재하지 않는 아이디");
		}

    	authVo.setPassword(passwordEncoder.encode(authVo.getPassword()));
		authDao.updateByUserId(authVo);
	}

    @Transactional
	public void deleteAccount(AuthDto authDto) {
		AuthVo authVo = AuthVo.of(authDto);
		

		if (authDao.findByUserId(authVo)==null) {
    		throw new AuthException("존재하지 않는 아이디");
		}
		
		authDao.deleteByUserId(authVo);
	}
}