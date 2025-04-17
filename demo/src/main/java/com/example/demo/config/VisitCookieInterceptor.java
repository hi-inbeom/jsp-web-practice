package com.example.demo.config;

import java.util.UUID;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class VisitCookieInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 쿠키에 "visitId" 가 있는지 확인
        boolean hasCookie = false;

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("visitId".equals(cookie.getName())) {
                    hasCookie = true;
                    break;
                }
            }
        }

        // 없다면 새로 만들어서 브라우저에게 전달
        if (!hasCookie) {
            String uuid = UUID.randomUUID().toString(); // 랜덤 문자열 만들기
            Cookie newCookie = new Cookie("visitId", uuid);
            newCookie.setPath("/");               // 사이트 전체에서 사용 가능
            newCookie.setMaxAge(60 * 60 * 24);    // 하루 동안 유지
            response.addCookie(newCookie);
        }

        return true; // 다음 페이지 처리로 계속 진행
    }
}
