package com.example.demo.auth;

import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthDto {
	private String userNo;
    private String userId;
    private String userEmail;
    private String userNick;
    private String userPassword;
    private String createdAt;
    private String userStatus;
    private String userRole;
    private boolean autoLogin;
    
 // VO -> DTO 변환
    public static AuthDto of(AuthVo authVo) {
        AuthDto authDto = new AuthDto();
        authDto.setUserNo(authVo.getUserNo().toString());
        authDto.setUserId(authVo.getUserId());
        authDto.setUserEmail(authVo.getUserEmail());
        authDto.setUserNick(authVo.getUserNick());
        authDto.setUserPassword(authVo.getUserPassword());
        if (authVo.getCreatedAt() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            authDto.setCreatedAt(authVo.getCreatedAt().format(formatter));
        }
        authDto.setUserStatus(authVo.getUserStatus());
        authDto.setUserRole(authVo.getUserRole());

        return authDto;
    }


	@Override
	public String toString() {
		return "AuthDto [userNo=" + userNo + ", userId=" + userId + ", userEmail=" + userEmail + ", userNick="
				+ userNick + ", userPassword=" + userPassword + ", createdAt=" + createdAt + ", userStatus="
				+ userStatus + ", userRole=" + userRole + ", autoLogin=" + autoLogin + "]";
	}
}