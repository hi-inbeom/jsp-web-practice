package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig  {
    @Bean
    public BCryptPasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorizeRequests ->
                authorizeRequests
                    .requestMatchers("/restricted/**").authenticated()  // '/restricted/**' 경로는 로그인한 사용자만 접근 가능
                    .requestMatchers("/**").permitAll()  // 그 외 URL은 모두 허용
            )
            .formLogin()  // 로그인 폼 사용
                .loginPage("/login")  // 로그인 페이지 URL
                .permitAll()  // 로그인 페이지는 모두 접근 가능
            .and()
            .logout()  // 로그아웃
                .permitAll();  // 로그아웃은 모두 접근 가능

        return http.build();
    }
    
    
}
    
