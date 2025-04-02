<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>게시판</title>
    <!-- Bootstrap 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">

    <h1 class="mb-4">게시판</h1>
    <a href="write.jsp" class="btn btn-primary mb-3">글쓰기</a>

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
		        <c:when test="true">
		            <c:forEach var="board" items="${boardList}">
		                <tr>
		                    <td>${board.id}</td>
		                    <td><a href="detail?id=${board.id}">${board.title}</a></td>
		                    <td>${board.author}</td>
		                    <td>${board.createdAt}</td>
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
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="board?page=${currentPage - 1}">이전</a>
                </li>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="board?page=${i}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="board?page=${currentPage + 1}">다음</a>
                </li>
            </c:if>
        </ul>
    </nav>

</body>
</html>
