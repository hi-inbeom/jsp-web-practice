package com.example.demo.auth;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDto {
	private String userId;
	private String userPassword;
	
	@Override
	public String toString() {
		return "LoginDto [userId=" + userId + ", userPassword=" + userPassword + "]";
	}
}
