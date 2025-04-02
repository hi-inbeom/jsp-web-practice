package com.example.demo.board;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.pagination.PageInfo;
import com.example.demo.pagination.Pagination;

import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	
	// 게시물 가져오기
	@GetMapping("/board")
	String board(@RequestParam(value="pno", defaultValue="1") int currentPage, Model model) {
		// 전체 게시물 수
		int listCount = boardService.selectListCount();
		// 페이지 네이션에 표시될 페이지 수
		int pageLimit = 10;
		// 한 페이지에 들어갈 게시물 수
		int boardLimit = 10;
		
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<BoardDto> boardList = boardService.selectList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("boardList", boardList);
		
		return "board/list";
	}
	
	// 게시물 상세보기
	@GetMapping("/board/{bno}")
	String detail(@PathVariable int bno, Model model) {
		BoardDto boardDto = boardService.selectByIndex(bno);
		model.addAttribute("board", boardDto);
		return "board/detail";
	}
	
	// 게시물 수정보기
	@GetMapping("/board/update/{bno}")
	String update(@PathVariable int bno, Model model) {
		BoardDto boardDto = boardService.selectByIndex(bno);
		model.addAttribute("board", boardDto);
		return "board/update";
	}
	
	// 게시물 작성
	@PostMapping("/write.bo")
	ResponseEntity<Map<String,Object>> write(@RequestBody BoardDto boardDto) {
		try {
			boardService.write(boardDto);
			return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
		}
	}
	
	@PatchMapping("/update.bo")
	String update(@RequestBody BoardDto boardDto, HttpSession httpSession, Model model) {
		try {
			boardService.update(boardDto, httpSession, model);
			return "redirect:/board/"+boardDto.getBoardNo();
		} catch (Exception e) {
			return "";
		}
	}
	
	@DeleteMapping("/delete.bo")
	String update(@PathVariable int bno, HttpSession httpSession, Model model) {
		boardService.delete(bno, httpSession, model);
		return "redirect:/board/";
	}
}
