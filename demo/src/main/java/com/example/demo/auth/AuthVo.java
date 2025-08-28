package com.example.demo.auth;

import com.example.demo.base.BaseVo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthVo extends BaseVo {
	private Long userNo;
	private String userId;
    private String userEmail;
    private String userNick;
    private String userPassword;
    
    public AuthVo() { }
    
    public AuthVo(AuthDto authDto) {
    	super(authDto);
    	this.userNo = Long.parseLong(authDto.getUserNo());
    	this.userId = authDto.getUserId();
    	this.userEmail = authDto.getUserEmail();
    	this.userNick = authDto.getUserNick();
    }
    
    // 회원가입
    public AuthVo(AuthFormDto authFormDto) {
    	super();
    	this.userId = authFormDto.getUserId();
    	this.userEmail = authFormDto.getUserEmail();
    	this.userNick = authFormDto.getUserEmail();
    	this.userPassword = authFormDto.getUserPassword();
    }
    
    // 회원로그인
    public AuthVo(LoginDto loginDto) {
    	this.userId = loginDto.getUserId();
    	this.userPassword = loginDto.getUserPassword();
    }

	@Override
	public String toString() {
		return super.toString() + " + AuthVo [userNo=" + userNo + ", userId=" + userId + ", userEmail=" + userEmail + ", userNick=" + userNick
				+ ", userPassword=" + userPassword + "]";
	}
    
}