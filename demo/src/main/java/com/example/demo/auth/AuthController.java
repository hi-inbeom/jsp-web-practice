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
    
    /* ========================== 화면 ==========================*/

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
    
    @GetMapping("/updateAccount")
    public String updateAccountPage() {
    	return "auth/updateAccount";
    }
    
    @GetMapping("/mypage")
    public String myPage() {
    	return "auth/myPage";
    }
    
    
    /* ========================== API ========================== */
    
    // 회원 가입
    @PostMapping("/signup.au")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> signUp(@RequestBody AuthFormDto authFormDto, HttpSession httpSession) throws Exception {        
        try {
            AuthDto authDto = authService.registerAuth(authFormDto);
        	httpSession.setAttribute("loginUser", authDto);
            return ResponseEntity.ok(Collections.singletonMap("success", true));
        } catch (AuthException e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
        }
    }
    
    // 로그인
    @PostMapping("/login.au")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginDto loginDto, HttpSession httpSession, HttpServletResponse response) {
    	try {
    		AuthDto loginUser = authService.login(loginDto);
    		
//    		if (authDto.isAutoLogin()) {
                Cookie loginCookie = new Cookie("userId", authDto.getUserId());
                loginCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일
                loginCookie.setPath("/"); // 모든 경로에서 쿠키 사용 가능
                loginCookie.setHttpOnly(true); // JavaScript에서 접근할 수 없도록 설정
                loginCookie.setSecure(true); // HTTPS에서만 전송하도록 설정
                response.addCookie(loginCookie); // 쿠키 추가
//    		}
    		
        	httpSession.setAttribute("loginUser", loginUser);
            return ResponseEntity.ok(Collections.singletonMap("success", true));
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
    	}
    }
    
    // 로그아웃
    @PostMapping("/logout.au")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> logout(HttpSession httpSession) {
    	try {
    		httpSession.removeAttribute("loginUser");
            return ResponseEntity.ok(Collections.singletonMap("success", true));
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", "로그인이 되어 있지 않습니다."));
    	}
    }
    
    @PostMapping("/findAccount.au")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> findAccount(@RequestBody AuthDto authDto, HttpSession httpSession) {
    	try {
        	authDto = authService.findAccount(authDto);
            Map<String, Object> response = new HashMap<>();
            httpSession.setAttribute("userInfo", authDto);
            response.put("success", true);
            return ResponseEntity.ok(response);
    	} catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
    	}
    }

    @PatchMapping("/updateAccount.au")
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
    
    @DeleteMapping("/deleteAccount.au")
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
