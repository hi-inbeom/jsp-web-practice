package com.example.demo.pagination;

public class Pagination {
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		// 페이지네이션의 최대 페이지 계산식
		// Math.ceil()은 올림 처리를 하여 최대 페이지 수를 계산합니다.
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		if (maxPage==0) { maxPage=1; }
		
		// 현재 페이지를 기준으로 보여줄 페이지 번호 계산식
		int startPage = currentPage - (currentPage % pageLimit) + 1;
		
		// 끝 페이지
		int endPage = startPage + pageLimit - 1;
		
		// 끝 페이지가 최대 페이지 넘지 않도록 조절식
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	}
}