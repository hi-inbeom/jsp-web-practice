package com.example.demo.auth;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import exception.AuthException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }
    
    @GetMapping("/signup")
    public String signupPage() {
        return "auth/signup";
    }
    
    @GetMapping("/findAccount")
    public String findAccountPage() {
        return "auth/findAccount";
    }
    
    @GetMapping("/mypage")
    public String myPage() {
    	return "auth/myPage";
    }
    
    
    /* ================================================ */
    
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> login(@RequestBody AuthDto authDto, HttpSession httpSession, HttpServletResponse response) {
    	try {
    		authService.login(authDto);
    		
    		if (authDto.isAutoLogin()) {
                Cookie loginCookie = new Cookie("userId", authDto.getUserId());
                loginCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일
                loginCookie.setPath("/"); // 모든 경로에서 쿠키 사용 가능
                loginCookie.setHttpOnly(true); // JavaScript에서 접근할 수 없도록 설정
                loginCookie.setSecure(true); // HTTPS에서만 전송하도록 설정
                response.addCookie(loginCookie); // 쿠키 추가
    		}
    		
        	httpSession.setAttribute("loginUser", authDto.getUserId());
            return ResponseEntity.ok(Collections.singletonMap("success", true));
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
    	}
    }
    
    @PostMapping("/logout")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> logout(HttpSession httpSession) {
    	try {
    		httpSession.removeAttribute("loginUser");
            return ResponseEntity.ok(Collections.singletonMap("success", true));
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", "로그인이 되어 있지 않습니다."));
    	}
    }
    
    @PostMapping("/findAccount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> findAccount(@RequestBody AuthDto authDto) {
    	try {
        	authDto = authService.findAccount(authDto);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("userId", authDto.getUserId()); 
            
            return ResponseEntity.ok(response);
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
    	}
    }

    @PatchMapping("/updateAccount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateAccount(@RequestBody AuthDto authDto, HttpSession httpSession) {
    	try {
        	authService.updateAccount(authDto);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            
            httpSession.invalidate();
            
            return ResponseEntity.ok(Collections.singletonMap("success", true));
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
    	}
    }


    
    @PostMapping("/signup")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> signUp(@RequestBody AuthDto authDto, HttpSession httpSession) throws Exception {        
        try {
            authService.registerAuth(authDto);
        	httpSession.setAttribute("loginUser", authDto.getUserId());
            return ResponseEntity.ok(Collections.singletonMap("success", true));
        } catch (AuthException e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
        }
    }
    
    @DeleteMapping("/deleteAccount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteAccount(@RequestBody AuthDto authDto, HttpSession httpSession) throws Exception {
    	try {
			authService.deleteAccount(authDto);
			httpSession.invalidate();
            return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (AuthException e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
		}
    }
    

}
