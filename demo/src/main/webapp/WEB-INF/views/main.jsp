<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
</head>
<body>
    <header>
        <h1>전자정부프레임워크 웹 서비스</h1>
    </header>
    
    <nav>
        <ul>
            <li><a href="/board">게시판</a></li>
            <li><a href="/mypage">마이페이지</a></li>
        </ul>
    </nav>

    <main>
        <c:choose>
            <c:when test="${not empty loginUser}">
                <h2>환영합니다, ${loginUser}님!</h2>
                <p>전자정부프레임워크 기반 웹 서비스에 오신 것을 환영합니다.</p>
                <form action="/logout" method="post">
                    <button type="submit">로그아웃</button>
                </form>
            </c:when>
            <c:otherwise>
                <h2>로그인이 필요합니다.</h2>
                <p><a href="/login">로그인 페이지로 이동</a></p>
            </c:otherwise>
        </c:choose>
    </main>

    <footer>
        <p>&copy; 2025 전자정부프레임워크 프로젝트</p>
    </footer>
</body>
</html>
