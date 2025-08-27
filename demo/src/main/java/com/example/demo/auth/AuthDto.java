package com.example.demo.auth;

import com.example.demo.base.BaseDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthDto extends BaseDto {
	private String userNo;
    private String userId;
    private String userEmail;
    private String userNick;
    private String userPassword;

    public AuthDto() {}

    public AuthDto(AuthVo authVo) {
        super(authVo);
        this.userNo = authVo.getUserNo().toString();
        this.userId = authVo.getUserId();
        this.userEmail = authVo.getUserEmail();
        this.userNick = authVo.getUserNick();
        this.userPassword = authVo.getUserPassword();;
    }

	@Override
	public String toString() {
		return super.toString() + " + AuthDto [userNo=" + userNo + ", userId=" + userId + ", userEmail=" + userEmail + ", userNick="
				+ userNick + ", userPassword=" + userPassword + "]";
	}
}