package com.example.demo.auth;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AuthFormDto {
	private String userId;
	private String userEmail;
	private String userNick;
	private String userPassword;
	
	
	@Override
	public String toString() {
		return "AuthFormDto [userId=" + userId + ", userEmail=" + userEmail + ", userNick=" + userNick
				+ ", userPassword=" + userPassword + "]";
	}
}
