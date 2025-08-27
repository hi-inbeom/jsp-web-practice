package com.example.demo.history;

import org.springframework.stereotype.Controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@AllArgsConstructor
public class HistoryController {
    @GetMapping("/history")
    public String getMethodName() {

        return "history/map";
    }
    
}
