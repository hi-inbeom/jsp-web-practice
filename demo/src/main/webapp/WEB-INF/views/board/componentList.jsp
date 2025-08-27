<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
        .search-container {
		    display: flex;
		    align-items: center;
		    gap: 8px; /* 요소 간 간격 */
		}
		
		.search-container input {
		    flex-grow: 1; /* 가변 크기 */
		    min-width: 150px; /* 최소 너비 설정 */
		}
		
		.search-container button {
		    height: 100%; /* 버튼 높이 input과 맞추기 */
		    white-space: nowrap; /* 버튼 내부 글자가 줄바꿈되지 않도록 */
		}
        
        .table-header th {
        	text-align: center;
        }
          /* tr 호버 시 배경색 변경 */
		 tbody tr:hover {
		   background-color: #f5f5f5;
		 }
		
		 /* 번호 가운데 정렬 */
		 .list-no,
		 .list-view,
		 .list-writer {
		   text-align: center;
		 }
		 
		 .list-no {
		 	max-width: 30px;
		 }
		 .list-title {
		 	max-width: 10px;
		 }
		 .list-writer {
		 	max-width: 10px;
		 }
		 .list-date {
		 	max-width: 10px;
		 }
		 .list-view {
		 	max-width: 10px;
	 	}
		 
		
		 .list-title,
		 .list-writer,
		 .list-date,
		 .list-view {
		   white-space: nowrap;
		   overflow: hidden;
		   text-overflow: ellipsis;
		 }
        
        
        
        
        .pagination .page-item.disabled .page-link .page-link.active {
		    pointer-events: none; /* 클릭 비활성화 */
		    background-color: #e9ecef; /* 회색 배경 */
		    color: #6c757d; /* 글자색 변경 */
		    border-color: #dee2e6; /* 테두리 색 변경 */
		}
    </style>
    
<script>
	function addSearch(event) {
	    event.preventDefault();
	    goToPage(1);
	}
	
	// 페이지 네이션
	function goToPage(pageNum) {
	    const params = new URLSearchParams(window.location.search);
	    const keyword = document.querySelector('[name="keyword"]').value;
	    /* const sortBy = document.querySelector('[name="sortBy"]').value; */
	    
	    // 쿼리 스트링 객체 구현
		params.set("pno", pageNum);
        if (keyword) {
            params.set("keyword", keyword);
        } else {
        	params.delete("keyword");
        }
/* 	 	if (sortBy) {
            params.set("sortBy", sortBy);
	 	} else {
	 		params.delete("sortBy");
	 	} */
	 	window.location.href = "/board?" + params.toString();
	}

	function showDetail(boardNo) {
	   /*  sessionStorage.setItem("boardListQuery", window.location.search); */
		window.location.href = '/board/' + boardNo + window.location.search;
	}
</script>
</head>
<body>
    <div class="container">
        <div class="board-container">
            <h2 class="text-center mb-4">게시판</h2>
            <!-- 검색창 -->
			<div class="row mb-4">
			    <div class="col-md-10 offset-md-1">
			        <form class="search-container" onsubmit="addSearch(event)">
                       <%-- <select name="searchType" class="form-select me-2" style="width: auto;">
                            <option value="title" <c:if test="${param.searchType eq 'title'}">selected</c:if>>제목</option>
                            <option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
                            <option value="writer" <c:if test="${param.searchType eq 'writer'}">selected</c:if>>작성자</option>
                        </select> --%>
			            <input type="text" name="keyword" class="form-control" value="${param.keyword}" placeholder="검색어를 입력하세요">
			            <button type="submit" class="btn btn-primary">검색</button>
			        </form>
			    </div>
			</div>
			
            <!-- 글쓰기 버튼 -->
            <div class="d-grid d-md-flex justify-content-md-end mt-3">
                <a href="<c:url value='/board/write'/>" class="btn btn-primary">글쓰기</a>
            </div>
            
            <!-- 게시글 -->
            <table class="table table-bordered">
            	<!-- 게시판 헤더 // 게시판 상단 정보 -->
                <thead class="table-dark">
                    <tr class="table-header">
                        <th style="width: 100px">번호</th>
                        <th>제목</th>
                        <th style="width: 100px">작성자</th>
                        <th style="width: 100px">작성일</th>
                        <th style="width: 100px">조회수</th>
                    </tr>
                </thead>
                <!-- 게시판 글 목록 -->
                <tbody>
                    <c:choose>
                        <c:when test="${not empty boardList}">
                            <c:forEach var="board" items="${boardList}" varStatus="status">
    							<tr onclick="showDetail(${board.boardNo})" style="cursor: pointer;">
        							<td class="list-no">${pi.listCount - ((pi.currentPage - 1) * pi.boardLimit + status.index)}</td>
									<td class="list-title">${board.boardTitle}</td>
									<td class="list-writer">${board.boardWriter}</td>
									<td class="list-date">${board.boardDate}</td>
									<td class="list-view">${board.boardView}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center text-muted">게시글이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <!-- 페이지네이션 -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
					<!-- 이전 페이지 -->
    				<li class="page-item">
    					<a class="page-link <c:if test='${pi.currentPage==1}'>disabled</c:if>"
    						href="javascript:void(0);"
    						onclick="goToPage(${pi.currentPage - 1})">&laquo;</a>
    				</li>
					
					<!-- 페이지 번호 -->
					<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="pageNum">
					    <li class="page-item">
						    <a class="page-link ${pageNum == pi.currentPage ? 'active' : ''}"
						    	href="javascript:void(0)"
						    	onclick="goToPage(${pageNum})">
						    ${pageNum}</a>
						</li>
					</c:forEach>
					
					
					<!-- 다음 페이지 -->
    				<li class="page-item">
    					<a class="page-link <c:if test='${pi.currentPage==pi.maxPage}'>disabled</c:if>"
    						href="javascript:void(0);"
    						onclick="goToPage(${pi.currentPage + 1})">&raquo;</a>
   					</li>
                </ul>
            </nav>
        </div>
    </div>
</body>
</html>