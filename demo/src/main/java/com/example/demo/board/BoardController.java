package com.example.demo.board;

import java.util.Collections;
import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.pagination.PageInfo;
import com.example.demo.pagination.Pagination;

import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	
	// 게시물 가져오기
	private void addBoardListToModel(int pno, String keyword, Model model) {
	    int listCount = boardService.selectListCount(keyword);
	    int pageLimit = 10;
	    int boardLimit = 10;

	    PageInfo pi = Pagination.getPageInfo(listCount, pno, pageLimit, boardLimit);
	    List<BoardDto> boardList = boardService.selectAll(pi, keyword);
	    
	    model.addAttribute("pi", pi);
	    model.addAttribute("boardList", boardList);
	}
	
	// 게시물 리스트 보기
	@GetMapping("/board")
	String board(@RequestParam(value = "pno", required = false, defaultValue = "1") int pno,
				@RequestParam(value = "keyword", required = false) String keyword,
				Model model) {
		addBoardListToModel(pno, keyword, model);
		return "board/list";
	}
	
	// 게시물 상세보기
	@GetMapping("/board/{bno}")
	String detail(@PathVariable("bno") int bno, @RequestParam(value = "pno", required = false, defaultValue = "1") int pno,
				@RequestParam(value = "keyword", required = false) String keyword,
				Model model) {
		addBoardListToModel(pno, keyword, model);
		model.addAttribute("board", boardService.selectByIndex(bno));
		return "board/detail";
	}
	
	// 게시물 수정보기
	@GetMapping("/board/update/{bno}")
	String update(@PathVariable("bno") int bno, @RequestParam(value = "pno", required = false, defaultValue = "1") int pno,
			@RequestParam(value = "keyword", required = false) String keyword,
			Model model) {
		addBoardListToModel(pno, keyword, model);
		model.addAttribute("board", boardService.selectByIndex(bno));
		return "board/update";
	}
	
	// 글 작성하기
	@GetMapping("/board/write")
	String write(@RequestParam(value = "pno", required = false, defaultValue = "1") int pno,
			@RequestParam(value = "keyword", required = false) String keyword,
			Model model) {
		addBoardListToModel(pno, keyword, model);
		return "board/write";
	}
	
	// 게시물 작성
	@PostMapping("/write.bo")
	ResponseEntity<Map<String, Object>> writeBoard(@RequestBody BoardDto boardDto, HttpSession httpSession) {
		try {
			boardService.write(boardDto, httpSession);
			return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
		}
	}
	
	@PatchMapping("/update.bo")
	ResponseEntity<Map<String, Object>> updateBoard(@RequestBody BoardDto boardDto, HttpSession httpSession) {
		try {
			boardService.update(boardDto, httpSession);
			return ResponseEntity.ok(Collections.singletonMap("success", true));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
		}
	}
	
	@DeleteMapping("/delete.bo/{bno}")
	@ResponseBody
	public String deleteBoard(@PathVariable("bno") int bno, HttpSession httpSession) {
	    try {
	    	boardService.delete(bno, httpSession);
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
}
