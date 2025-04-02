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
        System.out.println("1: 변환 시작");

        // 변환 로직
        authDto.setUserNo(authVo.getUserNo().toString());  // Long을 String으로 변환
        System.out.println("2: userNo 변환 완료 - " + authVo.getUserNo().toString());
        
        authDto.setUserId(authVo.getUserId());
        System.out.println("3: userId 변환 완료 - " + authVo.getUserId());
        
        authDto.setUserEmail(authVo.getUserEmail());  // 변수명 맞추기
        System.out.println("4: userEmail 변환 완료 - " + authVo.getUserEmail());
        
        authDto.setUserNick(authVo.getUserNick());
        System.out.println("5: userNick 변환 완료 - " + authVo.getUserNick());
        
        authDto.setUserPassword(authVo.getUserPassword());
        System.out.println("6: userPassword 변환 완료 - " + authVo.getUserPassword());

        // 날짜 변환
        if (authVo.getCreatedAt() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            authDto.setCreatedAt(authVo.getCreatedAt().format(formatter));
            System.out.println("7: createdAt 변환 완료 - " + authVo.getCreatedAt().format(formatter));
        }

        authDto.setUserStatus(authVo.getUserStatus());
        System.out.println("8: userStatus 변환 완료 - " + authVo.getUserStatus());

        authDto.setUserRole(authVo.getUserRole());
        System.out.println("9: userRole 변환 완료 - " + authVo.getUserRole());

        return authDto;
    }


	@Override
	public String toString() {
		return "AuthDto [userNo=" + userNo + ", userId=" + userId + ", userEmail=" + userEmail + ", userNick="
				+ userNick + ", userPassword=" + userPassword + ", createdAt=" + createdAt + ", userStatus="
				+ userStatus + ", userRole=" + userRole + ", autoLogin=" + autoLogin + "]";
	}
}