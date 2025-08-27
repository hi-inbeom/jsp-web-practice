<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

.board-container {
    background: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    max-width: 900px;
    margin: 0 auto;
}

/* 게시판 헤더 스타일 */
.board-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 10px;
    border-bottom: 2px solid #eee;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 1rem;
    gap: 5px;
}

.board-header span {
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 게시판 리스트 스타일 */
.board-list {
    margin-top: 1rem;
}

.board-link {
    text-decoration: none;
    color: inherit;
    display: block;
}

.board-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
    cursor: pointer;
    background-color: #fff;
    transition: background-color 0.3s ease;
}

.board-item:hover {
    background-color: #f5f5f5;
}

.board-link:visited .board-item {
    color: #949494;
}

.board-header span,
.board-item span {
    flex-basis: 100%;
}

.board-item {
    gap: 5px;
}

.list-no {
	max-width:50px;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: center;
}
.list-title {
    text-align: left;
    overflow: hidden;
    text-overflow: ellipsis;
    flex-grow: 1;
}

.list-writer {
    text-align: left;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width:100px;
}

.list-date {
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: center;
    max-width: 120px;
}

.list-view {
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: center;
    max-width:70px;
}

.pagination {
    margin-top: 2rem;
    text-align: center;
}

.pagination-list {
    list-style-type: none;
    padding: 0;
}

.page-item {
    display: inline-block;
    margin: 0 5px;
}

.page-link {
    text-decoration: none;
    color: #007bff;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fff;
}

.page-item.disabled .page-link {
    color: #6c757d;
    background-color: #e9ecef;
    pointer-events: none;
}

.page-item.active .page-link {
    background-color: #007bff;
    color: #fff;
}
rder-color: #dee2e6; /* 테두리 색 변경 */
		}
    </style>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/js/favicon.js"></script>
<link id="favicon" rel="icon" href="/favicon.ico">
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

	function showWrite() {
		window.location.href = '/board/write' + window.location.search;
	}
	
	function showDetail(boardNo) {
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
            <c:if test="${loginUser!=null}">
	            <div class="d-grid d-md-flex justify-content-md-end mt-3">
	                <a href="javascript:void(0)" onclick="showWrite()" class="btn btn-primary">글쓰기</a>
	            </div>
            </c:if>
            
            <!-- 게시글 -->
		    <div class="board-header">
		        <span class="list-no">번호</span>
		        <span class="list-title">제목</span>
		        <span class="list-writer">작성자</span>
		        <span class="list-date">작성일</span>
		        <span class="list-view">조회수</span>
		    </div>
		
		    <div class="board-list">
		        <c:choose>
		            <c:when test="${not empty boardList}">
		                <c:forEach var="board" items="${boardList}" varStatus="status">
		                    <!-- a 태그로 감싸서 링크 방문 후 visited 스타일 적용 -->
		                    <a href="/board/${board.boardNo}" class="board-link">
		                        <div class="board-item">
		                            <span class="list-no">
		                                ${pi.listCount - ((pi.currentPage - 1) * pi.boardLimit + status.index)}
		                            </span>
		                            <span class="list-title">${board.boardTitle}</span>
		                            <span class="list-writer">${board.boardWriter}</span>
						            <fmt:parseDate value="${board.boardDate}" pattern="yyyy-MM-dd HH:mm" var="parsedDate" />
						            <fmt:formatDate value="${parsedDate}" pattern="yy.MM.dd HH.mm" var="formattedDate" />
									<span class="list-date">${formattedDate}</span>
		                            <span class="list-view">${board.boardView}</span>
		                        </div>
		                    </a>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <div class="board-item text-center text-muted">게시글이 없습니다.</div>
		            </c:otherwise>
		        </c:choose>
		    </div>
            
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