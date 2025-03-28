package com.example.demo.auth;

import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthDto {
    private String id;
    private String userId;
    private String email;
    private String password;
    private String createdAt;
    private boolean autoLogin;
    
    // VO -> DTO 변환
    public static AuthDto of(AuthVo authVo) {
        AuthDto authDto = new AuthDto();
        authDto.setId(authVo.getId().toString());
        authDto.setUserId(authVo.getUserId());
        authDto.setEmail(authVo.getEmail());
        authDto.setPassword(authVo.getPassword());

        if (authVo.getCreatedAt() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            authDto.setCreatedAt(authVo.getCreatedAt().format(formatter));
        }
        return authDto;
    }
    
	@Override
	public String toString() {
		return "AuthDto [id=" + id + ", userId=" + userId + ", email=" + email + ", password=" + password
				+ ", createdAt=" + createdAt + "]";
	}
}