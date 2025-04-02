package com.example.demo.auth;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AuthVo {
	private Long userNo;
    private String userId;
    private String userEmail;
    private String userNick;
    private String userPassword;
    private LocalDateTime createdAt;
    private String userStatus;
    private String userRole;
    
 // DTO를 VO로 변환
    public static AuthVo of(AuthDto authDto) {
        AuthVo authVo = new AuthVo();
        
        if (authDto.getUserNo() != null) {
            authVo.setUserNo(Long.parseLong(authDto.getUserNo()));  // String을 Long으로 변환
        } 
        
        authVo.setUserId(authDto.getUserId());
        authVo.setUserEmail(authDto.getUserEmail());
        authVo.setUserNick(authDto.getUserNick());
        authVo.setUserPassword(authDto.getUserPassword());

        // 날짜 변환
        if (authDto.getCreatedAt() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            authVo.setCreatedAt(LocalDateTime.parse(authDto.getCreatedAt(), formatter));
        }

        authVo.setUserStatus(authDto.getUserStatus());
        authVo.setUserRole(authDto.getUserRole());

        return authVo;
    }


	@Override
	public String toString() {
		return "AuthVo [userNo=" + userNo + ", userId=" + userId + ", userEmail=" + userEmail + ", userNick=" + userNick
				+ ", userPassword=" + userPassword + ", createdAt=" + createdAt + ", userStatus=" + userStatus
				+ ", userRole=" + userRole + "]";
	}
}