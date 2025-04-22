<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kiki`s Delivery</title>
    <script>
    	function logout(event) {
            event.preventDefault();
            
            fetch('/logout.au', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = '/';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                alert('로그아웃 중 오류가 발생했습니다.');
                console.log(error);
            });
    	}
    
    </script>
</head>
<body>
	<div style="display: flex; justify-content: space-between; align-items: center; padding: 10px 20px; background-color: #f8f9fa; border-bottom: 1px solid #ddd;">
    <!-- Logo -->
    <div style="font-size: 24px; font-weight: bold;">
        <a href="/" style="text-decoration: none; color: black;">Kiki`s Delivery</a>
    </div>

    <!-- Navigation -->
    <div style="display: flex; gap: 20px;">
        <a href="/board?pno=1" style="text-decoration: none; color: black;">Request</a>
        <c:choose>
            <c:when test="${not empty loginUser}">
        		<a href="/mypage" style="text-decoration: none; color: black;">Mypage</a>
                <a href="#" onclick="logout(event)" style="text-decoration: none; color: black;">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="/login" style="text-decoration: none; color: black;">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
	</div>
</body>
</html>