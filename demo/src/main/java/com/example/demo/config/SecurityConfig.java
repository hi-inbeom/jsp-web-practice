package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig  {
    @Bean
    public BCryptPasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())  // CSRF 보호 비활성화, RESTful API 사용을 위함.
            .authorizeHttpRequests(authorizeRequests -> authorizeRequests
                .requestMatchers("/mypage").authenticated()  // /mypage는 로그인한 사용자만 접근 가능
                .anyRequest().permitAll()  // 나머지 모든 요청은 허용
            )
            .formLogin(form -> form
                .loginPage("/login") // GET 로그인 페이지 접근
                .permitAll()  // 로그인 페이지는 모두 접근 가능
            )
            .logout(logout -> logout
                .permitAll()  // 로그아웃은 모두 접근 가능
            );

        return http.build();
    }
    
}
    
