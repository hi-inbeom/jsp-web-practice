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
    
    public AuthDto login(LoginDto loginDto)  {
    	AuthVo userInfo = authDao.findByUserId(new AuthVo(loginDto));
    	
    	if (userInfo==null) {
    		throw new AuthException("존재하지 않는 아이디");
    	}
		AuthDto loginUser = new AuthDto(userInfo);
        if (!passwordEncoder.matches(authDto.getUserPassword(), loginUser.getUserPassword())) {
            throw new AuthException("비밀번호 불 일치");
        }
        
        return loginUser;
    }
    
    @Transactional
    public AuthDto registerAuth(AuthFormDto authFormDto) {
    	AuthVo authVo = new AuthVo(authFormDto);
    	
    	// 아이디 길이
    	if (authFormDto.getUserId().length()<4) {
    		throw new AuthException("아이디 짧음 4자 이상");
    	}
    	// 비밀번호 길이
    	if (authFormDto.getUserPassword().length()<4) {
    		throw new AuthException("비밀번호 짧음 4자 이상");
    	}
    	// 닉네임 길이
    	if (authFormDto.getUserNick().length()<1) {
    		throw new AuthException("닉네임이 설정되지 않음");
    	}
    	// 아이디 중복 검사
    	if (authDao.findByUserId(authVo)!=null) {
    		throw new AuthException("아이디 중복");
    	};
    	// 이메일 중복 검사
    	if (authDao.findByEmail(authVo)!=null) {
    		throw new AuthException("이메일 중복");
    	}
    	
        // 비밀번호 암호화
    	authFormDto.setUserPassword(passwordEncoder.encode(authFormDto.getUserPassword()));

        // DAO를 통해 회원 정보 저장
        int result = authDao.insertAuth(authVo);
        if (result == 1) {
        	return new AuthDto(authDao.findByUserId(authVo));
        }
		return null;
    }

	public AuthDto findAccount(AuthDto authDto) {
		authDto = new AuthDto(authDao.findByEmail(new AuthVo(authDto)));
		
    	if (authDto==null) {
    		throw new AuthException("가입된 계정 정보가 없음");
    	}
    	
    	return authDto;
	}

    @Transactional
	public void updateAccount(AuthDto authDto) {
		AuthVo authVo = new AuthVo(authDto);
		
    	// 비밀번호 길이
    	if (authDto.getUserPassword().length()<4) {
    		throw new AuthException("비밀번호 짧음 4자 이상");
    	}

    	authVo.setUserPassword(passwordEncoder.encode(authVo.getUserPassword()));
    	System.out.println(authVo.toString());
		authDao.updateByUserId(authVo);
		authVo = authDao.findByUserId(authVo);
		System.out.println(authVo.toString());
	}

    @Transactional
	public void deleteAccount(AuthDto authDto) {
		AuthVo authVo = new AuthVo(authDto);
		

		if (authDao.findByUserId(authVo)==null) {
    		throw new AuthException("존재하지 않는 아이디");
		}
		
		authDao.deleteByUserId(authVo);
	}
}