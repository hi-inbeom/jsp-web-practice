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
	private Long id;
    private String userId;
    private String email;
    private String password;
    private LocalDateTime createdAt;
    
    // DTO를 VO로 변환
    public static AuthVo of(AuthDto authDto) {
        AuthVo authVo = new AuthVo();
        authVo.setUserId(authDto.getUserId());
        authVo.setEmail(authDto.getEmail());
        authVo.setPassword(authDto.getPassword());

        if (authDto.getCreatedAt() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            authVo.setCreatedAt(LocalDateTime.parse(authDto.getCreatedAt(), formatter));
        }
        return authVo;
    }

	@Override
	public String toString() {
		return "AuthVo [id=" + id + ", userId=" + userId + ", email=" + email + ", password=" + password
				+ ", createdAt=" + createdAt + "]";
	}
}