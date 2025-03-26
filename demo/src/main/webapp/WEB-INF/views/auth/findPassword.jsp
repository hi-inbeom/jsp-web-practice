<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="/findPassword" method="post">
        <div>
            <label for="email">이메일 주소:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <button type="submit">비밀번호 찾기</button>
        </div>
    </form>
</body>
</html>
