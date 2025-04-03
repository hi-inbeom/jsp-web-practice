<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <!-- Bootstrap CSS -->
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
    </style>
</head>
<body>
    <div class="container">
        <div class="board-container">
            <h2 class="text-center mb-4">게시판</h2>
            <!-- 검색창 -->
			<div class="row mb-4">
			    <div class="col-md-10 offset-md-1">
			        <form action="<c:url value='/board'/>" method="get" class="search-container">
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
            
            <!-- 게시글 목록 -->
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 100px">번호</th>
                        <th>제목</th>
                        <th style="width: 100px">작성자</th>
                        <th style="width: 100px">작성일</th>
                        <th style="width: 100px">조회수</th>
                        <th style="width: 100px">추천수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty boardList}">
                            <c:forEach var="board" items="${boardList}">
                                <tr>
                                    <td>${board.id}</td>
                                    <td><a href="detail?id=${board.id}">${board.title}</a></td>
                                    <td>${board.author}</td>
                                    <td>${board.createdAt}</td>
                                    <td>${board.viewCount}</td>
                                    <td>${board.likeCount}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center text-muted">게시글이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <!-- 페이지네이션 -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="<c:url value='/board?pno=${pi.startPage-1}&searchType=${param.searchType}&keyword=${param.keyword}'/>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="pageNum">
                        <li class="page-item <c:if test='${pageNum eq pi.currentPage}'>active</c:if>'">
                            <a class="page-link" href="<c:url value='/board?pno=${pageNum}&searchType=${param.searchType}&keyword=${param.keyword}'/>">${pageNum}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="<c:url value='/board?pno=${pi.endPage+1}&searchType=${param.searchType}&keyword=${param.keyword}'/>" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>