package com.example.demo.controller;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@Autowired
    private ConfigurableEnvironment env;
    
    
    @GetMapping("/")
    public String home() {

//        Map<String, Object> map = new LinkedHashMap<>();
//
//        // 현재 활성화된 프로파일
//        map.put("activeProfiles", Arrays.asList(env.getActiveProfiles()));
//
//        // 모든 프로퍼티 소스 탐색
//        Map<String, Object> props = new LinkedHashMap<>();
//        for (PropertySource<?> propertySource : env.getPropertySources()) {
//            if (propertySource.getSource() instanceof Map) {
//                Map<String, Object> source = (Map<String, Object>) propertySource.getSource();
//                for (Map.Entry<String, Object> entry : source.entrySet()) {
//                    System.out.println(entry.getKey()+" : "+ entry.getValue());
//                }
//            }
//        }


        return "main";
    }
}
