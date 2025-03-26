package com.example.demo.auth;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuthController {

    private AuthService authService;

    @GetMapping("/login")
    public String loginPage() {
    	System.out.println("???");
        return "auth/login";
    }
    
    

    @GetMapping("/signup")
    public String signupPage() {
    	System.out.println("???");
        return "auth/signup";
    }
    
    @PostMapping("/signup")
    public String signUp(@RequestBody AuthDto userDto) throws Exception {
    	authService.registerAuth(userDto);
        return "auth/signup";
    }
    
    @GetMapping("/findAccount")
    public String findAccountPage() {
    	System.out.println("???");
        return "auth/findAccount";
    }
    

    @GetMapping("/findPassword")
    public String findPasswordPage() {
    	System.out.println("???");
        return "auth/findPassword";
    }
}
